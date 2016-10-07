//
//  ANStorageUpdaterTests.m
//  Alister-Example
//
//  Created by ANODA on 8/29/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "ANStorageModel.h"
#import "ANStorageUpdater.h"
#import "ANStorageSectionModel.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageLoader.h"

static NSInteger const kMaxSectionsCount = 2;
static NSInteger const kMaxItemsCount = 3;

@interface ANStorageUpdaterTests : XCTestCase

@property (nonatomic, strong) ANStorageModel* storage;
@property (nonatomic, strong) ANStorageModel* emptyStorage;

@end

@implementation ANStorageUpdaterTests

- (void)setUp
{
    [super setUp];
    self.storage = [self _fullStorage];
    self.emptyStorage = [ANStorageModel new];
}

- (void)tearDown
{
    self.storage = nil;
    self.emptyStorage = nil;
    [super tearDown];
}


#pragma mark - Helper Methods

- (ANStorageModel*)_fullStorage
{
    ANStorageModel* storage = [ANStorageModel new];
    for (NSInteger sectionsCounter = 0; sectionsCounter < kMaxSectionsCount; sectionsCounter++)
    {
        ANStorageSectionModel* section = [ANStorageSectionModel new];
        [[self _testItems] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL*  _Nonnull stop) {
            [section addItem:obj];
        }];
        [storage addSection:section];
    }
    
    return storage;
}

- (NSArray*)_itemsInStorage:(ANStorageModel*)storage
{
    NSMutableArray* items = [NSMutableArray array];
    [storage.sections enumerateObjectsUsingBlock:^(ANStorageSectionModel*  _Nonnull sectionModel, NSUInteger idx, BOOL*  _Nonnull stop) {
        [items addObjectsFromArray:[storage itemsInSection:idx]];
    }];
    
    return items;
}

- (NSArray*)_testItems
{
    NSMutableArray* items = [NSMutableArray array];
    
    for (NSInteger counter = 0; counter < kMaxItemsCount; counter++)
    {
        [items addObject:@"123"];
    }
    
    return items;
}


#pragma mark - addItemToStorage

- (void)test_addItemToStorage_positive_itemsInsertToStorage
{
    // given
    id item = @"item";
    
    NSInteger itemsBefore = [self _itemsInStorage:self.storage].count;
    
    // when
    NSInteger insetedItemsCount = 0;
    for (NSInteger counter = 0; counter < kMaxItemsCount; counter++)
    {
        ANStorageUpdateModel* model = [ANStorageUpdater addItem:item toStorage:self.storage];
        insetedItemsCount += model.insertedRowIndexPaths.count;
    }
    
    // then
    NSInteger itemsAfter = [self _itemsInStorage:self.storage].count;
    expect(itemsAfter).to.equal(itemsBefore + insetedItemsCount);
}

- (void)test_addItemToStorage_negative_notRaiseExceptionWhenAddNilItem
{
    // given
    id item = nil;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItem:item toStorage:self.storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_addItemToStorage_negative_notRaiseExceptionWhenAddToNilStorage
{
    // given
    id item = @"123";
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItem:item toStorage:nil];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addItemToSectionToStorage

- (void)test_addItemToSectionToStorage_positive_itemInsertToSection
{
    // given
    id item = @"123";
    NSInteger sectionNumber = 12;
    NSInteger itemsBefore = [self.storage itemsInSection:sectionNumber].count;
    
    // when
    [ANStorageUpdater addItem:item toSection:sectionNumber toStorage:self.storage];
    
    // given
    NSInteger itemsAfter = [self.storage itemsInSection:sectionNumber].count;
    expect(itemsAfter).to.equal(itemsBefore + 1);
}

- (void)test_addItemToSectionToStorage_negative_raiseExceptionWhenAddToNegativeSection
{
    // given
    id item = @"123";
    NSInteger sectionNumber = -2;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItem:item toSection:sectionNumber toStorage:self.storage];
    };
    
    // given
    expect(testBlock).to.raiseAny();
}

- (void)test_addItemToSectionToStorage_negative_toNotRaiseExceptionWhenAddNilItem
{
    // given
    id item = nil;
    NSInteger sectionNumber = 10;

    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItem:item toSection:sectionNumber toStorage:self.storage];
    };
    
    // given
    expect(testBlock).notTo.raiseAny();
}

- (void)test_addItemToSectionToStorage_negative_toNotRaiseExceptionWhenAddToNilStorage
{
    // given
    id item = @"123";
    NSInteger sectionNumber = 10;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItem:item toSection:sectionNumber toStorage:nil];
    };
    
    // given
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addItemAtIndexPathToStorage

- (void)test_addItemAtIndexPathToStorage_positive_initialItemsEqualReturnedItems
{
    // when
    NSMutableArray* path = [NSMutableArray array];
    NSMutableArray* items = [NSMutableArray array];
    
    for (NSInteger counter = 0; counter < kMaxItemsCount; counter++)
    {
        id item = @(counter);
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:counter];
        [path addObject:indexPath];
        [items addObject:item];
        [ANStorageUpdater addItem:item atIndexPath:indexPath toStorage:self.storage];
    }
    
    // then
    NSMutableArray* returnedItems = [NSMutableArray array];
    [path enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL*  _Nonnull stop) {
        [returnedItems addObject:[ANStorageLoader itemAtIndexPath:obj inStorage:self.storage]];
    }];
    expect(returnedItems).to.equal(items);
}

- (void)test_addItemAtIndexPathToStorage_negative_toNotRaiseExceptionWhenAddAtNilPath
{
    // given
    id item = @"123";
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItem:item atIndexPath:nil toStorage:self.storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_addItemAtIndexPathToStorage_negative_toNotRaiseExceptionWhenAddNilItem
{
    // given
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItem:nil atIndexPath:indexPath toStorage:self.storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_addItemAtIndexPathToStorage_negative_toNotRaiseExceptionWhenAddToNilStorage
{
    // given
    id item = @"123";
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItem:item atIndexPath:indexPath toStorage:nil];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addItemsToStorage

- (void)test_addItemsToStorage_positive_returnedItemsEqualAddedItems
{
    // given
    NSArray* items = [self _testItems];
    
    // when
    [ANStorageUpdater addItems:items toStorage:self.emptyStorage];
    
    // then
    id returnedItems = [self.emptyStorage itemsInSection:0];
    expect(returnedItems).to.equal(items);
}

- (void)test_addItemsToStorage_negative_toNotRaiseExceptionWhenAddNilItems
{
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItems:nil toStorage:self.emptyStorage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_addItemsToStorage_negative_toNotRaiseExceptionWhenAddToNilStorage
{
    // given
    NSArray* items = [self _testItems];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItems:items toStorage:nil];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addItemsToSectionToStorage

- (void)test_addItemsToSectionToStorage_positive_addedItemsEqualReturnedItems
{
    // given
    NSArray* items = [self _testItems];
    NSInteger itemsCount = 0;
    
    // when
    for (NSInteger sectionCounter = 0; sectionCounter < kMaxSectionsCount; sectionCounter++)
    {
        itemsCount += items.count;
        [ANStorageUpdater addItems:items toSection:sectionCounter toStorage:self.emptyStorage];
    }
    
    // then
    expect([self _itemsInStorage:self.emptyStorage].count).to.equal(itemsCount);
}

- (void)test_addItemsToSectionToStorage_negative_toNotRaiseExceptionWhenAddNilItems
{
    // given
    NSInteger section = 0;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItems:nil toSection:section toStorage:self.emptyStorage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_addItemsToSectionToStorage_negative_toRaiseExceptionWhenAddToNegativeSection
{
    // given
    NSArray* items = [self _testItems];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItems:items toSection:-2 toStorage:self.emptyStorage];
    };
    
    // then
    expect(testBlock).to.raiseAny();
}

- (void)test_addItemsToSectionToStorage_negative_toNotRaiseExceptionWhenAddToNilStorage
{
    // given
    NSArray* items = [self _testItems];
    NSInteger section = 0;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater addItems:items toSection:section toStorage:nil];
    };
    
    // then
    expect(testBlock).toNot.raiseAny();
}


#pragma mark - replaceItemWithItemInStorage

- (void)test_replaceItemWithItemInStorage_positive_storageContainsNewItem
{
    // given
    id item = [self.storage itemsInSection:0].firstObject;
    id newItem = @"123";
    id storage = self.storage;
    
    // when
    [ANStorageUpdater replaceItem:item withItem:newItem inStorage:storage];
    
    // then
    NSIndexPath* originalIndexPath = [ANStorageLoader indexPathForItem:item inStorage:storage];
    ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)originalIndexPath.section inStorage:storage];

    expect(section.objects).to.contain(newItem);
}

- (void)test_replaceItemWithItemInStorage_negative_notRaiseExceptionWhenSourceItemIsNil
{
    // given
    id item = nil;
    id newItem = @"123";
    id storage = self.storage;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater replaceItem:item withItem:newItem inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_replaceItemWithItemInStorage_negative_notRaiseExceptionWhenReplacingItemIsNil
{
    // given
    id item = [self.storage itemsInSection:0].firstObject;
    id newItem = nil;
    id storage = self.storage;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater replaceItem:item withItem:newItem inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_replaceItemWithItemInStorage_negative_notRaiseExceptionWhenStorageIsNil
{
    // given
    id item = [self.storage itemsInSection:0].firstObject;
    id newItem = @"123";
    id storage = nil;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater replaceItem:item withItem:newItem inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - moveItemFromIndexPathToIndexPathInStorage

- (void)test_moveItemFromIndexPathToIndexPathInStorage_positive_destinationSectionContainsMovedItem
{
    // given
    id storage = self.storage;
    NSIndexPath* fromPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* toPath = [NSIndexPath indexPathForRow:1 inSection:1];
    
    // when
    [ANStorageUpdater moveItemFromIndexPath:fromPath toIndexPath:toPath inStorage:storage];
    
    // then
    ANStorageSectionModel* toSection = [ANStorageLoader sectionAtIndex:(NSUInteger)toPath.section
                                                             inStorage:storage];
    
    id tableItem = [ANStorageLoader itemAtIndexPath:fromPath inStorage:storage];
    expect(toSection.objects).to.contain(tableItem);
}

- (void)test_moveItemFromIndexPathToIndexPathInStorage_negative_notRaiseExceptionWhenSourcePathIsNil
{
    // given
    id storage = self.storage;
    NSIndexPath* fromPath = nil;
    NSIndexPath* toPath = [NSIndexPath indexPathForRow:1 inSection:1];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater moveItemFromIndexPath:fromPath toIndexPath:toPath inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_moveItemFromIndexPathToIndexPathInStorage_negative_notRaiseExceptionWhenDestinationPathIsNil
{
    // given
    id storage = self.storage;
    NSIndexPath* fromPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* toPath = nil;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater moveItemFromIndexPath:fromPath toIndexPath:toPath inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_moveItemFromIndexPathToIndexPathInStorage_negative_notRaiseExceptionWhenStorageIsNil
{
    // given
    id storage = nil;
    NSIndexPath* fromPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* toPath = [NSIndexPath indexPathForRow:1 inSection:1];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater moveItemFromIndexPath:fromPath toIndexPath:toPath inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_moveItemFromIndexPathToIndexPathInStorage_negative_notRaiseExceptionWhenPathsIsNegative
{
    // given
    id storage = nil;
    NSIndexPath* fromPath = [NSIndexPath indexPathForRow:-1 inSection:-2];
    NSIndexPath* toPath = [NSIndexPath indexPathForRow:-2 inSection:NSNotFound];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater moveItemFromIndexPath:fromPath toIndexPath:toPath inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - reloadItemInStorage

- (void)test_reloadItemInStorage_positive_updatedRowCountGreaterThanZero
{
    // given
    id storage = self.storage;
    id item = [self _itemsInStorage:storage].firstObject;
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageUpdater reloadItem:item inStorage:storage];
    
    // then
    expect(updateModel.updatedRowIndexPaths.count).to.beGreaterThan(0);
}

- (void)test_reloadItemInStorage_negative_toNotRaiseExceptionWhenItmeIsNil
{
    // given
    id storage = self.storage;
    id item = nil;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater reloadItem:item inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_reloadItemInStorage_negative_toNotRaiseExceptionWhenStorageIsNil
{
    // given
    id storage = nil;
    id item = [self _itemsInStorage:self.storage].firstObject;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater reloadItem:item inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_reloadItemInStorage_negative_toNotRaiseExceptionWhenItemIsIncorrect
{
    // given
    id storage = self.storage;
    id item = @(arc4random());
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater reloadItem:item inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - reloadItemsInStorage

- (void)test_reloadItemsInStorage_positive_updatedRowCountIsGreaterThanZero
{
    // given
    id items = [self _testItems];
    id storage = self.storage;
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageUpdater reloadItems:items inStorage:storage];
    
    // then
    expect(updateModel.updatedRowIndexPaths.count).to.beGreaterThan(0);
}

- (void)test_reloadItemsInStorage_negative_toNotRaiseExceptionWhenItemsIsNil
{
    // given
    id items = nil;
    id storage = self.storage;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater reloadItems:items inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_reloadItemsInStorage_negative_toNotRaiseExceptionWhenStorageIsNil
{
    // given
    id items = [self _testItems];
    id storage = nil;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater reloadItems:items inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_reloadItemsInStorage_negative_toNotRaiseExceptionWhenParametersIsNil
{
    // given
    id items = nil;
    id storage = nil;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater reloadItems:items inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - createSectionIfNotExistSectionNumberInStorage

- (void)test_createSectionIfNotExistInStorage_positive_sectionCreatedAtSpecifiedIndex
{
    // given
    ANStorageModel* storage = self.storage;
    NSInteger sectionNumber = storage.sections.count + 3;
    
    // when
    [ANStorageUpdater createSectionIfNotExist:sectionNumber inStorage:storage];
    
    // then
    expect([storage sectionAtIndex:sectionNumber]).notTo.beNil();
}

- (void)test_createSectionIfNotExistInStorage_positive_toNotRaiseExceptionWhenSectionExists
{
    // given
    ANStorageModel* storage = self.storage;
    NSInteger sectionNumber = storage.sections.count / 2;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater createSectionIfNotExist:sectionNumber inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_createSectionIfNotExistInStorage_negative_raiseExceptionWhenAddNegativeIndex
{
    // given
    ANStorageModel* storage = self.storage;
    NSInteger sectionNumber = -1;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater createSectionIfNotExist:sectionNumber inStorage:storage];
    };
    
    // then
    expect(testBlock).to.raiseAny();
}

- (void)test_createSectionIfNotExistInStorage_negative_toNotRaiseExceptionWhenStorageIsNil
{
    // given
    ANStorageModel* storage = nil;
    NSInteger sectionNumber = storage.sections.count;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageUpdater createSectionIfNotExist:sectionNumber inStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

@end
