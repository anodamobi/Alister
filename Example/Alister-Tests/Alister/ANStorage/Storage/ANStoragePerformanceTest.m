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
static NSUInteger const kSectionsCount = 100;

@interface ANStoragePerformanceTest : XCTestCase

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANTableController* controller;

@end

@implementation ANStoragePerformanceTest

- (void)setUp
{
    [super setUp];
    self.storage = [ANStorage new];
    self.controller = [[ANTableController alloc] initWithTableView:[UITableView new]];
    [self.controller attachStorage:self.storage];
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
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"test_addItemsToEmptyStoragePerformanceTest"];
    
    [self measureBlock:^{
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:items toSection:0];
        }];
        
        [self.controller addUpdatesFinishedTriggerBlock:^{
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:1.5f handler:^(NSError* _Nullable error) {
        expect(error).to.beNil();
    }];
}

- (void)test_insertSingleItemToFilledStoragePerformanceTest
{
    //given: fill storage
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        for (NSUInteger sectionIndex = 0; sectionIndex < kSectionsCount; sectionIndex++)
        {
            NSArray* items = [self _generateItems];
            [storageController addItems:items toSection:sectionIndex];
        }
    }];
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"test_insertSingleItemToFilledStoragePerformanceTest"];
    NSUInteger midleSectionIndex = kSectionsCount / 2;
    NSArray* items = [self _generateItems];
    
    //then
    [self measureBlock:^{
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:items toSection:midleSectionIndex];
        }];
        
        [self.controller addUpdatesFinishedTriggerBlock:^{
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:1.5f handler:^(NSError* _Nullable error) {
        expect(error).to.beNil();
    }];
}

- (void)test_removeItemsInFilledStoragePerformanceTest
{
    //given: fill storage
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        for (NSUInteger sectionIndex = 0; sectionIndex < kSectionsCount; sectionIndex++)
        {
            NSArray* items = [self _generateItems];
            [storageController addItems:items toSection:sectionIndex];
        }
    }];
    
    NSIndexPath* indexPath = [self _middleIndexPath];
    XCTestExpectation* expectation = [self expectationWithDescription:@"test_removeItemsInFilledStoragePerformanceTest"];
    
    //then
    [self measureBlock:^{
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController removeItemsAtIndexPaths:@[indexPath]];
        }];
        
        [self.controller addUpdatesFinishedTriggerBlock:^{
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:1.5f handler:^(NSError* _Nullable error) {
        expect(error).to.beNil();
    }];
}

- (void)test_removeSectionsInFilledStoragePerformanceTest
{
    //given: fill storage
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        for (NSUInteger sectionIndex = 0; sectionIndex < kSectionsCount; sectionIndex++)
        {
            NSArray* items = [self _generateItems];
            [storageController addItems:items toSection:sectionIndex];
        }
    }];
    
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, kSectionsCount - 1)];
    XCTestExpectation* expectation = [self expectationWithDescription:@"test_removeSectionsInFilledStoragePerformanceTest"];
    
    //then
    [self measureBlock:^{
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController removeSections:indexSet];
        }];
        
        [self.controller addUpdatesFinishedTriggerBlock:^{
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:1.5f handler:^(NSError* _Nullable error) {
        expect(error).to.beNil();
    }];
}

- (void)test_replaceItemWithItemPerformanceTest
{
    //given: fill storage
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        for (NSUInteger sectionIndex = 0; sectionIndex < kSectionsCount; sectionIndex++)
        {
            NSArray* items = [self _generateItems];
            [storageController addItems:items toSection:sectionIndex];
        }
    }];
    
    NSIndexPath* indexPath = [self _middleIndexPath];
    XCTestExpectation* expectation = [self expectationWithDescription:@"test_replaceItemWithItemPerformanceTest"];
    
    NSString* oldItem = [self.storage objectAtIndexPath:indexPath];
    NSString* updatedItem = @"";
    
    //then
    [self measureBlock:^{
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController replaceItem:oldItem withItem:updatedItem];
        }];
        
        [self.controller addUpdatesFinishedTriggerBlock:^{
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:1.5f handler:^(NSError* _Nullable error) {
        expect(error).to.beNil();
    }];
}

- (void)test_moveItemWithoutUpdateFromIndexPathInFilledStoragePerformanceTest
{
    //given: fill storage
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        for (NSUInteger sectionIndex = 0; sectionIndex < kSectionsCount; sectionIndex++)
        {
            NSArray* items = [self _generateItems];
            [storageController addItems:items toSection:sectionIndex];
        }
    }];
    
    NSIndexPath* fromIndexPath = [self _middleIndexPath];
    NSIndexPath* toIndexPath = [NSIndexPath indexPathForRow:0 inSection:kSectionsCount - 1];
    XCTestExpectation* expectation = [self expectationWithDescription:@"test_replaceItemWithItemPerformanceTest"];
    
    //then
    [self measureBlock:^{
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
        }];
        
        [self.controller addUpdatesFinishedTriggerBlock:^{
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:1.5f handler:^(NSError* _Nullable error) {
        expect(error).to.beNil();
    }];
}

- (void)test_reloadItemsInFilledStoragePerformanceTest
{
    //given: fill storage
    __block NSArray* items  = nil;
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        for (NSUInteger sectionIndex = 0; sectionIndex < kSectionsCount; sectionIndex++)
        {
            items = [self _generateItems];
            [storageController addItems:items toSection:sectionIndex];
        }
    }];
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"test_reloadItemsInFilledStoragePerformanceTest"];
    
    //then
    [self measureBlock:^{
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController reloadItems:items];
        }];
        
        [self.controller addUpdatesFinishedTriggerBlock:^{
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:^(NSError* _Nullable error) {
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

- (NSIndexPath*)_middleIndexPath
{
    NSUInteger sectionsCount = 100;
    NSUInteger midleSectionIndex = sectionsCount / 2;
    
    return [NSIndexPath indexPathForRow:kGeneratedItemsCount - 1 inSection:midleSectionIndex];
}

@end
