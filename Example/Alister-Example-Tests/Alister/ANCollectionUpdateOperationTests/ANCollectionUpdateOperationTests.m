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

- (void)setUp
{
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
    //given
    self.operaton.shouldAnimate = YES;
    
    //then
    expect(self.operaton.shouldAnimate).to.beTruthy();
}

- (void)test_delegatePropertySetuped_positive_delegateSetupedSuccessfully
{
    //given
    ANTestableListControllerUpdateOperationDelegate* operationDelegate = [ANTestableListControllerUpdateOperationDelegate new];
    self.operaton.delegate = operationDelegate;
    
    //then
    expect(self.operaton.delegate).notTo.beNil();
}

- (void)test_delegatePropertySetuped_positive_delegateHasRightClass
{
    //given
    ANTestableListControllerUpdateOperationDelegate* operationDelegate = [ANTestableListControllerUpdateOperationDelegate new];
    self.operaton.delegate = operationDelegate;
    
    //then
    expect(self.operaton.delegate).equal(operationDelegate);
}

- (void)test_operationWithUpdateModel_positive_afterUpdateModelNotNil
{
    //given
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithUpdateModel:updateModel];
    
    //then
    expect(operation).notTo.beNil();
}

- (void)test_operationWithUpdateModel_positive_afterUpdateModelSetupedToOperation
{
    //given
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithUpdateModel:updateModel];
    
    //then
    expect(operation.updateModel).notTo.beNil();
    expect(operation.updateModel).to.equal(updateModel);
}

- (void)test_operationWithUpdateModel_positive_afterUpdateSetupedModelIsEqualCreatedModel
{
    //given
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithUpdateModel:updateModel];
    
    //then
    expect(operation.updateModel).to.equal(updateModel);
}

- (void)test_storageUpdateModelGenerated_positive_updateModelNotNil
{
    //given
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    
    //when
    [self.operaton storageUpdateModelGenerated:updateModel];
    
    //then
    expect(self.operaton.updateModel).notTo.beNil();
}

- (void)test_storageUpdateModelGenerated_positive_afterUpdateModelIsSameAsSetuped
{
    //given
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    
    //when
    [self.operaton storageUpdateModelGenerated:updateModel];
    
    //then
    expect(self.operaton.updateModel).equal(updateModel);
}

- (void)test_main_positive_raiseExpeptionIfCollectionIsNil
{
    //given
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANTestableListControllerUpdateOperationDelegate* delegate = [ANTestableListControllerUpdateOperationDelegate new];
    operation.delegate = delegate;
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    [operation storageUpdateModelGenerated:updateModel];
    
    //when
    void (^testBlock)() = ^{
        [operation main];
    };
    
    
    //then
    expect(testBlock).raiseAny();
}

- (void)test_main_positive_operationNotCanceledAndCalledPerformUpdate
{
    //given
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
    
    
    //when
    [operation main];
    
    //then
    OCMVerifyAll(mockedOperation);
}

- (void)test_performAnimatedUpdate_positive_collectionReloadDataCalled
{
    //given
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
   
    
    //when
    [operation _performAnimatedUpdate:updateModel];
    
    //then
    OCMVerifyAll(mockedCollectionView);

}

- (void)test_performAnimatedUpdate_positive_calledCollectionViewPerformUpdate
{
    //given
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
   
    //when
    [operation _performAnimatedUpdate:updateModel];
    
    //then
    OCMVerifyAll(mockedCollectionView);
}

- (void)test_performAnimatedUpdate_negative_raiseExceptionIfCollectionIsNil
{
    //given
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    ANTestableListControllerUpdateOperationDelegate* operationDelegate = [ANTestableListControllerUpdateOperationDelegate new];
    operation.delegate = operationDelegate;
   
    //when
    void (^testBlock)() = ^{
        [operation _performAnimatedUpdate:updateModel];
    };
    
    //then
    expect(testBlock).raiseAny();
}

- (void)test_performAnimatedUpdate_notRaiseExceptionIfUpdateIsEmpty
{
    //given
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    
    //when
    void(^testBlock)() = ^{
        [operation _performAnimatedUpdate:nil];
    };
    
    //then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_shouldReloadCollectionView_positive_shouldReturnNo
{
    //given
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANTestableCollectionView* collectionView = [[ANTestableCollectionView alloc] initWithFrame:CGRectZero
                                                                          collectionViewLayout:[UICollectionViewLayout new]];
    
    UIWindow* window = [[UIWindow alloc] initWithFrame:CGRectZero];
    [collectionView updateWindow:window];

    //when
    BOOL testResult = [operation _shouldReloadCollectionView:collectionView toPreventInsertFirstItemIssueForUpdate:nil];
    
    //then
    expect(testResult).notTo.beTruthy();
}

- (void)test_shouldReloadCollectionView_positive_shouldReturnYESIfWindowIsNil
{
    //given
    ANTestableCollectionUpdateOperation* operation = [ANTestableCollectionUpdateOperation operationWithCanceledValue:NO];
    ANTestableCollectionView* collectionView = [[ANTestableCollectionView alloc] initWithFrame:CGRectZero
                                                                          collectionViewLayout:[UICollectionViewLayout new]];
    //when
    BOOL testResult = [operation _shouldReloadCollectionView:collectionView toPreventInsertFirstItemIssueForUpdate:nil];
    
    //then
    expect(testResult).to.beTruthy();
}

@end
