//
//  ANListControllerUpdateServiceTest.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/16/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANListControllerUpdateServiceFixture.h"
#import "ANListViewFixture.h"
#import "ANStorageUpdateOperation.h"
#import "ANListControllerUpdateOperation.h"
#import "ANListControllerReloadOperation.h"

@interface ANListControllerUpdateServiceTest : XCTestCase

@property (nonatomic, strong) ANListControllerUpdateServiceFixture* updateService;
@property (nonatomic, strong) ANListViewFixture* listView;
@property (nonatomic, strong) NSMutableArray* operations;

@end

@implementation ANListControllerUpdateServiceTest

- (void)setUp
{
    [super setUp];
    
    self.listView = [ANListViewFixture new];
    self.updateService = [[ANListControllerUpdateServiceFixture alloc] initWithListView:self.listView];
    
    self.operations = [NSMutableArray new];
    self.updateService.queue.operations = self.operations;
}

- (void)tearDown
{
    [super tearDown];
    
    self.updateService = nil;
}


- (void)test_initWithListView_shouldHaveListView
{
    expect(self.updateService.listView).equal(self.listView);
}


- (void)test_storageDidPerformUpdate_shouldAddUpdateOperation
{
    [self _performUpdate];
    
    ANStorageUpdateOperation* updateOp = self.operations[0];
    ANListControllerUpdateOperation* listOp = self.operations[1];
    
    expect(self.operations).haveCount(2);
    
    expect(listOp.delegate).equal(self.updateService);
    
    OCMVerify([updateOp setControllerOperationDelegate:listOp]);
    OCMVerify([updateOp setUpdaterDelegate:self.updateService]);
}


- (void)test_storageNeedsReloadWithIdentifier_shouldCancelAllPreviousOperationForIdentifier
{
    NSString* identifier = [self _performUpdate];
    [self _performUpdate];
    
    [self.updateService storageNeedsReloadWithIdentifier:identifier animated:NO];
    [self.operations removeLastObject]; //TODO: remove last reload operation as it will be added
    
    for (NSOperation* op in self.operations)
    {
        if ([op.name isEqualToString:identifier])
        {
            expect(op.isCancelled).beTruthy();
        }
    }
}



- (void)test_storageNeedsReloadWithIdentifier_shouldAddReloadOperation
{
    NSString* identifier = [ANTestHelper randomString];
    [self.updateService storageNeedsReloadWithIdentifier:identifier animated:YES];
    
    ANListControllerReloadOperation* op = [self.operations lastObject];
    
    expect(op.name).equal(identifier);
    expect(op.delegate).equal(self.updateService);
}


#pragma mark - Helpers

- (NSString*)_performUpdate
{
    NSString* identifier = [ANTestHelper randomString];
    id updateOperation = OCMClassMock([ANStorageUpdateOperation class]);
    [self.updateService storageDidPerformUpdate:updateOperation withIdentifier:identifier animatable:NO];
    
    return identifier;
}

@end
