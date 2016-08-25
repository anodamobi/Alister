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
- (BOOL)_shouldReloadCollectionView:(UICollectionView*)collectionView
toPreventInsertFirstItemIssueForUpdate:(ANStorageUpdateModel*)update;

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

- (void)test_main_positive_raiseExpeptionIfCollectionIsNil
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANTestableListControllerUpdateOperationDelegate* delegate = [ANTestableListControllerUpdateOperationDelegate new];
    operation.delegate = delegate;
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    [operation storageUpdateModelGenerated:updateModel];
    
    void (^testBlock)() = ^{
        [operation main];
    };
    
    expect(testBlock).raiseAny();
    
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

- (void)test_performAnimatedUpdate_positive_collectionReloadDataCalled
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    
    ANTestableCollectionView* collectionView = [[ANTestableCollectionView alloc] initWithFrame:CGRectZero
                                                                          collectionViewLayout:[UICollectionViewLayout new]];
    
    id mockedCollectionView = OCMPartialMock(collectionView);
    
    ANTestableListControllerUpdateOperationDelegate* operationDelegate = [ANTestableListControllerUpdateOperationDelegate new];
    [operationDelegate updateWithTestableCollectionView:mockedCollectionView];
    operation.delegate = operationDelegate;
    
    OCMExpect([mockedCollectionView reloadData]);
    
    [operation _performAnimatedUpdate:updateModel];
    
    OCMVerifyAll(mockedCollectionView);

}

- (void)test_performAnimatedUpdate_positive_calledCollectionViewPerformUpdate
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedSectionIndex:1];
    
    ANTestableCollectionView* collectionView = [[ANTestableCollectionView alloc] initWithFrame:CGRectZero
                                                                          collectionViewLayout:[UICollectionViewLayout new]];
    
    id mockedCollectionView = OCMPartialMock(collectionView);
    
    ANTestableListControllerUpdateOperationDelegate* operationDelegate = [ANTestableListControllerUpdateOperationDelegate new];
    [operationDelegate updateWithTestableCollectionView:mockedCollectionView];
    operation.delegate = operationDelegate;
    
    OCMExpect([mockedCollectionView performBatchUpdates:[OCMArg any] completion:nil]);
    
    [operation _performAnimatedUpdate:updateModel];
    
    OCMVerifyAll(mockedCollectionView);
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

- (void)test_performAnimatedUpdate_notRaiseExceptionIfUpdateIsEmpty
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    
    void(^testBlock)() = ^{
        [operation _performAnimatedUpdate:nil];
    };
    expect(testBlock).notTo.raiseAny();
}

- (void)test_shouldReloadCollectionView_positive_shouldReturnNo
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANTestableCollectionView* collectionView = [[ANTestableCollectionView alloc] initWithFrame:CGRectZero
                                                                          collectionViewLayout:[UICollectionViewLayout new]];
    
    UIWindow* window = [[UIWindow alloc] initWithFrame:CGRectZero];
    [collectionView updateWindow:window];

    BOOL testResult = [operation _shouldReloadCollectionView:collectionView toPreventInsertFirstItemIssueForUpdate:nil];
    
    expect(testResult).notTo.beTruthy();
}

- (void)test_shouldReloadCollectionView_positive_shouldReturnYESIfWindowIsNil
{
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANTestableCollectionView* collectionView = [[ANTestableCollectionView alloc] initWithFrame:CGRectZero
                                                                          collectionViewLayout:[UICollectionViewLayout new]];
    
    BOOL testResult = [operation _shouldReloadCollectionView:collectionView toPreventInsertFirstItemIssueForUpdate:nil];
    
    expect(testResult).to.beTruthy();
}

@end
