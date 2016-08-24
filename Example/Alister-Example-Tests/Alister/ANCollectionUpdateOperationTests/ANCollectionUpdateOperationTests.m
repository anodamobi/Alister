//
//  ANCollectionUpdateOperationTests.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "ANTestableCollectionUpdateOperation.h"
#import "ANStorageUpdateModel.h"
#import "ANTestableListControllerUpdateOperationDelegate.h"

@interface ANCollectionControllerUpdateOperation ()

@property (nonatomic, strong) ANStorageUpdateModel* updateModel;

+ (instancetype)operationWithUpdateModel:(ANStorageUpdateModel*)model;
- (void)_performAnimatedUpdate:(ANStorageUpdateModel*)update;
- (void)setFinished:(BOOL)finished;

@end

@interface ANCollectionUpdateOperationTests : XCTestCase

@property (nonatomic, strong) ANTestableCollectionUpdateOperation* operaton;

@end

@implementation ANCollectionUpdateOperationTests

- (void)setUp {
    [super setUp];
    self.operaton = [ANTestableCollectionUpdateOperation new];
}

- (void)tearDown
{
    self.operaton = nil;
    [super tearDown];
}

- (void)test_shouldAnimatePropertySetuped_positive_valueSetupedSuccessfully
{
    self.operaton.shouldAnimate = YES;
    expect(self.operaton.shouldAnimate).to.beTruthy();
}

- (void)test_delegatePropertySetuped_positive_delegateSetupedSuccessfully
{
    ANTestableListControllerUpdateOperationDelegate* operationDelegate = [ANTestableListControllerUpdateOperationDelegate new];
    self.operaton.delegate = operationDelegate;
    expect(self.operaton.delegate).notTo.beNil();
    expect(self.operaton.delegate).equal(operationDelegate);
}

- (void)test_operationWithUpdateModel_positive_afterUpdateModelNotNilAndReturnedValidValue
{
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithUpdateModel:updateModel];
    expect(operation).notTo.beNil();
    expect(operation.updateModel).notTo.beNil();
    expect(operation.updateModel).to.equal(updateModel);
}

- (void)test_storageUpdateModelGenerated_positive_updateModelNotNil
{
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [self.operaton storageUpdateModelGenerated:updateModel];
    
    expect(self.operaton.updateModel).notTo.beNil();
    expect(self.operaton.updateModel).equal(updateModel);
}

- (void)test_main_positive_operationShouldFinishedIfUpdateModelIsNil
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    id mockedOperation = OCMPartialMock(operation);
    OCMExpect([mockedOperation setFinished:YES]);
    [operation main];
    OCMVerifyAll(mockedOperation);
}

- (void)test_main_positive_operationNotCanceledAndCalledPerformUpdate
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    
    ANTestableCollectionView* collectionView = [[ANTestableCollectionView alloc] initWithFrame:CGRectZero
                                                                          collectionViewLayout:[UICollectionViewLayout new]];
    
    ANTestableListControllerUpdateOperationDelegate* operationDelegate = [ANTestableListControllerUpdateOperationDelegate new];
    [operationDelegate updateWithTestableCollectionView:collectionView];
    operation.delegate = operationDelegate;
    
    [operation storageUpdateModelGenerated:updateModel];
    
    id mockedOperation = OCMPartialMock(operation);
    OCMExpect([operation _performAnimatedUpdate:updateModel]);
    
    [operation main];
    OCMVerifyAll(mockedOperation);
}

- (void)test_main_positive_collectionUpdatedAndCalledFinished
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    
    ANTestableCollectionView* collectionView = [[ANTestableCollectionView alloc] initWithFrame:CGRectZero
                                                                          collectionViewLayout:[UICollectionViewLayout new]];
    
    ANTestableListControllerUpdateOperationDelegate* operationDelegate = [ANTestableListControllerUpdateOperationDelegate new];
    [operationDelegate updateWithTestableCollectionView:collectionView];
    operation.delegate = operationDelegate;
    
    [operation storageUpdateModelGenerated:updateModel];
    
    id mockedOperation = OCMPartialMock(operation);
    OCMExpect([operation setFinished:YES]);
    [operation main];
    OCMVerifyAll(mockedOperation);
}

- (void)test_performAnimatedUpdate_negative_raiseExceptionIfCollectionIsNil
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    ANTestableListControllerUpdateOperationDelegate* operationDelegate = [ANTestableListControllerUpdateOperationDelegate new];
    operation.delegate = operationDelegate;
    
    void (^testBlock)() = ^{
        [operation _performAnimatedUpdate:updateModel];
    };
    
    expect(testBlock).raiseAny();
    
}

@end
