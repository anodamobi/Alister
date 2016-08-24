//
//  ANTableControllerUpdateOperationTests.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "ANTestableTableUpdateOperation.h"
#import "ANTestableListControllerUpdateOperationDelegate.h"
#import "ANStorageUpdateModel.h"

@interface ANTableControllerUpdateOperation ()

- (void)setFinished:(BOOL)finished;
- (void)setExecuting:(BOOL)executing;
- (void)storageUpdateModelGenerated:(ANStorageUpdateModel*)updateModel;
- (void)_performAnimatedUpdate:(ANStorageUpdateModel*)update;

@end

@interface ANTableControllerUpdateOperationTests : XCTestCase

@property (nonatomic, strong) NSOperationQueue* operationQueue;
@property (nonatomic, strong) ANTestableListControllerUpdateOperationDelegate* delegate;

@end

@implementation ANTableControllerUpdateOperationTests

- (void)setUp {
    [super setUp];
    
    self.operationQueue = [NSOperationQueue new];
    self.operationQueue.maxConcurrentOperationCount = 1;
    self.operationQueue.name = @"Table controller test queue";
    self.delegate = [ANTestableListControllerUpdateOperationDelegate new];
}

- (void)tearDown {
    self.operationQueue = nil;
    [super tearDown];
}

- (void)test_operationFinishedAfterCancel_positivie_setterCalled
{
    //given
    ANTestableTableUpdateOperation* operation = [ANTestableTableUpdateOperation operationWithCancelValue:YES];
    id mockedOperation = OCMPartialMock(operation);
    OCMExpect([mockedOperation setFinished:YES]);
    [operation start];
    
    //then
    OCMVerifyAll(mockedOperation);
}

- (void)test_main_positive_finishedWithoutModel
{
    //given

    ANTestableTableUpdateOperation* operation = [ANTestableTableUpdateOperation operationWithCancelValue:NO];
    id mockedOperation = OCMPartialMock(operation);
    OCMExpect([mockedOperation setExecuting:NO]);
    
    void(^testBlock)() = ^{
        [operation main];
    };
    
    expect(testBlock).notTo.raiseAny();
    
    //then
    OCMVerifyAll(mockedOperation);
}

- (void)test_main_positive_finishedWithEmptyModel
{
    //given
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    ANTestableTableUpdateOperation* operation = [ANTestableTableUpdateOperation operationWithCancelValue:NO];
    [operation storageUpdateModelGenerated:updateModel];
    id mockedOperation = OCMPartialMock(operation);
    OCMExpect([mockedOperation setExecuting:NO]);
    [operation main];
    
    //then
    OCMVerifyAll(mockedOperation);
}

- (void)test_performAnimatedUpdate_positive_calledWithValidUpdateModel
{
    //given
    
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedSectionIndex:1];
    
    expect(updateModel.isEmpty).to.beFalsy();
    
    ANTestableTableUpdateOperation* operation = [ANTestableTableUpdateOperation operationWithCancelValue:NO];
    [operation storageUpdateModelGenerated:updateModel];
    id mockedOperation = OCMPartialMock(operation);
    OCMExpect([mockedOperation _performAnimatedUpdate:updateModel]);
    [operation main];
    
    //then
    OCMVerifyAll(mockedOperation);
}

- (void)test_performAnimatedUpdate_positive_calledTableViewInsertSections
{
    
    //given
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedSectionIndex:1];
    
    ANTestableTableUpdateOperation* operation = [ANTestableTableUpdateOperation operationWithCancelValue:NO];
    [operation storageUpdateModelGenerated:updateModel];
    operation.shouldAnimate = YES;
    
    ANTestableTableView* tableView = [[ANTestableTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    ANTestableListControllerUpdateOperationDelegate* delegate = [ANTestableListControllerUpdateOperationDelegate new];
    [delegate updateWithTestableTableView:tableView];
    operation.delegate = delegate;
    
    id mockedTableView = OCMPartialMock(tableView);
    OCMExpect([mockedTableView insertSections:updateModel.insertedSectionIndexes withRowAnimation:UITableViewRowAnimationNone]);
    
    [operation main];
    
    //then
    
    OCMVerifyAll(mockedTableView);
    
}

- (void)test_performAnimatedUpdate_positive_calledDelegateReloadStorage
{
    //given
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedSectionIndex:1];
    updateModel.isRequireReload = YES;
    
    ANTestableTableUpdateOperation* operation = [ANTestableTableUpdateOperation operationWithCancelValue:NO];
    [operation storageUpdateModelGenerated:updateModel];
    operation.shouldAnimate = NO;
    
    ANTestableTableView* tableView = [[ANTestableTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    ANTestableListControllerUpdateOperationDelegate* delegate = [ANTestableListControllerUpdateOperationDelegate new];
    [delegate updateWithTestableTableView:tableView];
    
    id mockedDelegate = OCMPartialMock(delegate);
    operation.delegate = mockedDelegate;
    
    OCMExpect([mockedDelegate storageNeedsReloadWithIdentifier:[OCMArg any]]);
    [operation main];
    
    //then
    
    OCMVerifyAll(mockedDelegate);
}

- (void)test_performAnimatedUpdate_negative_calledAssertWhenListViewNotValid
{
    //given
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedSectionIndex:1];
    
    ANTestableTableUpdateOperation* operation = [ANTestableTableUpdateOperation operationWithCancelValue:NO];
    [operation storageUpdateModelGenerated:updateModel];
    operation.shouldAnimate = NO;
    
    ANTestableListControllerUpdateOperationDelegate* delegate = [ANTestableListControllerUpdateOperationDelegate new];
    operation.delegate = delegate;

    void(^testBlock)() = ^{
        [operation main];
    };
    
    //then
    
    expect(testBlock).to.raiseAny();
}

@end
