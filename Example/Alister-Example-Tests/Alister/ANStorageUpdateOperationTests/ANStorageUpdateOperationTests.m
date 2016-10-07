//
//  ANStorageUpdateOperationTests.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/25/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANStorageUpdateOperation.h"
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "ANTestableStorageUpateOperation.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageUpdateOperation.h"

@interface ANStorageUpdateOperation ()

@property (nonatomic, copy) ANStorageUpdateOperationConfigurationBlock configurationBlock;
@property (nonatomic, strong) NSMutableArray* updates;

@end

@interface ANStorageUpdateOperationTests : XCTestCase
<
    ANStorageUpdateControllerInterface,
    ANStorageListUpdateOperationInterface
>

@end

@implementation ANStorageUpdateOperationTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_operationWithExecutionBlock_positive_returnValidInstance
{
    //given
    ANStorageUpdateOperation* updateOperation = [ANStorageUpdateOperation operationWithExecutionBlock:nil];
    
    //then
    expect(updateOperation).notTo.beNil();
    expect([updateOperation isMemberOfClass:[ANStorageUpdateOperation class]]).to.beTruthy();
}

- (void)test_updaterDelegate_positive_isNotEmptyAfterAssign
{
    //given
    ANStorageUpdateOperation* updateOperation = [ANStorageUpdateOperation operationWithExecutionBlock:nil];
    updateOperation.updaterDelegate = self;
    
    //then
    expect(updateOperation.updaterDelegate).notTo.beNil();
    expect(updateOperation.updaterDelegate).equal(self);
}

- (void)test_controllerOperationDelegate_positive_isNotEmptyAfterAssign
{
    //given
    ANStorageUpdateOperation* updateOperation = [ANStorageUpdateOperation operationWithExecutionBlock:nil];
    updateOperation.controllerOperationDelegate = self;
    
    //then
    expect(updateOperation.controllerOperationDelegate).notTo.beNil();
    expect(updateOperation.controllerOperationDelegate).equal(self);
}

- (void)test_configurationBlock_positive_configurationBlockCalled
{
    XCTestExpectation* expectation = [self expectationWithDescription:@"block called"];
    
    ANTestableStorageUpateOperation* operation = [ANTestableStorageUpateOperation operationWithCancelValue:NO];
    ANStorageUpdateOperationConfigurationBlock configBlock = ^(ANStorageUpdateOperation* updateOperation){
        [expectation fulfill];
        XCTAssertTrue([operation isEqual:updateOperation]);
    };
    
    operation.configurationBlock = configBlock;
    
    [operation main];
    
    [self waitForExpectationsWithTimeout:0.2 handler:^(NSError*  _Nullable error) {
        XCTAssertNil(error);
    }];
}

- (void)test_updaterDelegate_positive_updateModelIsRequireReloadAndCallUpdateStorageOperation
{
    
    id mockedUpdaterDelegate = OCMPartialMock(self);
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    updateModel.isRequireReload = YES;
    
    ANTestableStorageUpateOperation* operation = [ANTestableStorageUpateOperation operationWithCancelValue:NO];
    operation.updaterDelegate = mockedUpdaterDelegate;
    operation.updates = [NSMutableArray arrayWithArray:@[updateModel]];
    
    OCMExpect([mockedUpdaterDelegate updateStorageOperationRequiresForceReload:[OCMArg any]]);
    
    [operation main];
    
    OCMVerifyAll(mockedUpdaterDelegate);
}

- (void)test_controllerOperationDelegate_positive_calledStorageUpdateModelGenerated
{
    id mockedControllerOperationDelegate = OCMPartialMock(self);
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    updateModel.isRequireReload = NO;
    
    ANTestableStorageUpateOperation* operation = [ANTestableStorageUpateOperation operationWithCancelValue:NO];
    operation.controllerOperationDelegate = mockedControllerOperationDelegate;
    operation.updates = [NSMutableArray arrayWithArray:@[updateModel]];
    
    OCMExpect([mockedControllerOperationDelegate storageUpdateModelGenerated:[OCMArg any]]);
    
    [operation main];
    
    OCMVerifyAll(mockedControllerOperationDelegate);
}

- (void)test_collectUpdate_positive_updatesCountNotChanted
{
    ANTestableStorageUpateOperation* operation = [ANTestableStorageUpateOperation operationWithCancelValue:NO];
    void(^testBlock)() = ^{
        [operation collectUpdate:nil];
    };
    expect(testBlock).notTo.raiseAny();
    expect(operation.updates.count == 0).to.beTruthy();
}

- (void)test_collectUpdate_positive_updatesCountChangedAfterUpdate
{
    ANTestableStorageUpateOperation* operation = [ANTestableStorageUpateOperation operationWithCancelValue:NO];
    ANStorageUpdateModel* updateModel = [ANStorageUpdateModel new];
    [updateModel addInsertedIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    [operation collectUpdate:updateModel];
    
    expect(operation.updates.count).to.beGreaterThan(0);
}


#pragma mark - ANStorageUpdateControllerInterface

- (void)updateStorageOperationRequiresForceReload:(__unused ANStorageUpdateOperation*)operation
{

}


#pragma mark - ANStorageListUpdateOperationInterface

- (void)storageUpdateModelGenerated:(__unused ANStorageUpdateModel*)updateModel
{

}

@end
