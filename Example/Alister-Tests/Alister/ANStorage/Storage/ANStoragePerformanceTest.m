//
//  ANStoragePerformanceTest.m
//  Alister-Example
//
//  Created by ANODA on 2/9/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorage.h"
#import "ANStorageModel.h"
#import "ANTableController.h"

static NSUInteger const kGeneratedItemsCount = 10000;

@interface ANStoragePerformanceTest : XCTestCase

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANTableController* controller;

@end

@implementation ANStoragePerformanceTest

- (void)setUp
{
    [super setUp];
    self.storage = [ANStorage new];
}

- (void)tearDown
{
    self.storage = nil;
    self.controller = nil;
    [super tearDown];
}

- (void)test_addItemsToEmptyStoragePerformanceTest
{
    NSArray* items = [self _generateItems];
    [self measureBlock:^{
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:items];
        }];
    }];
}

- (void)test_insertSingleItemToFilledStoragePerformanceTest
{
    //given: fill storage
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        NSUInteger sectionsCount = 100;
        for (NSUInteger sectionIndex = 0; sectionIndex < sectionsCount; sectionIndex++)
        {
            NSArray* items = [self _generateItems];
            [storageController addItems:items toSection:sectionIndex];
        }
    }];
    
    self.controller = [[ANTableController alloc] initWithTableView:[UITableView new]];
    [self.controller attachStorage:self.storage];
    XCTestExpectation* expectation = [self expectationWithDescription:@""];
    
    __weak typeof(self) welf = self;
    static BOOL isFirstInsert = YES;
    [self.controller addUpdatesFinishedTriggerBlock:^{
        if (isFirstInsert)
        {
            isFirstInsert = NO;
            [welf measureBlock:^{
                [welf.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
                    
                    NSUInteger lastIndex = kGeneratedItemsCount - 1;
                    [storageController addItem:@"TestItem" toSection:lastIndex];
                    
                    [expectation fulfill];
                }];
            }];
        }
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        expect(error).to.beNil();
    }];
}


#pragma mark - Private

- (NSArray*)_generateItems
{
    NSMutableArray* items = [NSMutableArray array];
    for (NSUInteger counter = 0; counter < kGeneratedItemsCount; counter++)
    {
        [items addObject:@"TestObject"];
    }
    return items;
}

@end
