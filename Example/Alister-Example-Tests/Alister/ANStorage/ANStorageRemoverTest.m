//
//  ANStorageRemoverTest.m
//  Alister-Example
//
//  Created by ANODA on 8/26/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANStorageRemover.h"
#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageLoader.h"

static NSInteger const kMaxSectionsCount = 3;
static NSInteger const kMaxObjectsCount = 3;

@interface ANStorageRemoverTest : XCTestCase

@property (nonatomic, strong) ANStorageModel* storageModel;

@end

@implementation ANStorageRemoverTest

- (void)setUp
{
    [super setUp];
    self.storageModel = [self _fullStorageModel];
}

- (void)tearDown
{
    self.storageModel = nil;
    [super tearDown];
}


#pragma mark - Helper Methods

- (ANStorageModel*)_fullStorageModel
{
    ANStorageModel* fullModel = [ANStorageModel new];
    
    for (NSInteger sectionCounter = 0; sectionCounter < kMaxSectionsCount; sectionCounter++)
    {
        ANStorageSectionModel* section = [ANStorageSectionModel new];
        for (NSInteger counter = 0; counter < kMaxObjectsCount; counter++)
        {
            [section addItem:@"12"];
        }
        [fullModel addSection:section];
    }
    return fullModel;
}

- (NSSet*)_indexPathsInStorage:(ANStorageModel*)storage
{
    NSMutableSet* indexPaths = [NSMutableSet set];
    
    [storage.sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* items = [ANStorageLoader itemsInSection:idx inStorage:storage];
        NSArray* path = [ANStorageLoader indexPathArrayForItems:items inStorage:storage];
        [indexPaths addObjectsFromArray:path];
    }];
    return indexPaths;
}

- (NSIndexSet*)_indexSetFromStorage:(ANStorageModel*)storage
{
    return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, storage.sections.count)];
}

- (NSArray*)_allItemsInStorage:(ANStorageModel*)storage
{
    NSMutableArray* items = [NSMutableArray array];
    
    [storage.sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* rows = [ANStorageLoader itemsInSection:idx inStorage:storage];
        [items addObjectsFromArray:rows];
    }];
    return items;
}

- (id)_anyItemInStorage:(ANStorageModel*)storage
{
    for (NSUInteger counter = 0; counter < storage.sections.count; counter++)
    {
        NSArray* items = [ANStorageLoader itemsInSection:counter inStorage:storage];
        if (items.count)
        {
            return items.firstObject;
        }
    }
    return nil;
}


#pragma mark - removeItemFromStorage

- (void)test_removeItemFromStorage_positive_deletedRowPathsContainRemovedPath
{
    // given
    ANStorageModel* storage = self.storageModel;
    id itemToRemove = [self _anyItemInStorage:storage];
    NSIndexPath* path = [ANStorageLoader indexPathForItem:itemToRemove inStorage:storage];
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeItem:itemToRemove fromStorage:storage];
    
    // then
    expect(updateModel.deletedRowIndexPaths).to.contain(path);
}

- (void)test_removeItemFromStorage_negative_deletedRowPathsHaveCountZeroWhenRemoveNilItem
{
    // given
    id item = nil;
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeItem:item fromStorage:self.storageModel];
    
    // then
    expect(updateModel.deletedRowIndexPaths).to.haveCount(0);
}

- (void)test_removeItemFromStorage_negative_toNotRaiseExceptionWhenStorageIsNil
{
    // given
    id storage = nil;

    // when
    void(^testBlock)() = ^() {
        [ANStorageRemover removeItem:@"" fromStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_removeItemFromStorage_negative_deletedRowPathsHaveCountZeroWhenStorageIsNil
{
    // given
    id storage = nil;
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeItem:@"" fromStorage:storage];
    
    // then
    expect(updateModel.deletedRowIndexPaths).to.haveCount(0);
}

- (void)test_removeItemFromStorage_negative_deletedRowPathsHaveCountZeroWhenParametersIsNil
{
    // given
    id storage = nil;
    id item = nil;
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeItem:item fromStorage:storage];
    
    // then
    expect(updateModel.deletedRowIndexPaths).to.haveCount(0);
}

- (void)test_removeItemFromStorage_negative_deletedRowPathsHaveCountZeroWhenMovedAnotherStorage
{
    // given
    ANStorageModel* fakeStorage = [ANStorageModel new];
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:[NSObject new]];
    [fakeStorage addSection:section];
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeItem:@"" fromStorage:fakeStorage];
    
    // then
    expect(updateModel.deletedRowIndexPaths).to.haveCount(0);
}


#pragma mark - removeItemsAtIndexPathsFromStorage

- (void)test_removeItemsAtIndexPathsFromStorage_positive_storageNotContainsRemovedItems
{
    // given
    ANStorageModel* storage = self.storageModel;

    // when
    NSSet* indexPaths = [self _indexPathsInStorage:storage];
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeItemsAtIndexPaths:indexPaths fromStorage:storage];
    
    // then
    expect(updateModel.deletedRowIndexPaths.count).to.equal(indexPaths.count);
}

- (void)test_removeItemsAtIndexPathsFromStorage_negative_deletedPathsHaveCountZeroWhenMovedPathsIsNil
{
    // given
    ANStorageModel* storage = self.storageModel;
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeItemsAtIndexPaths:nil fromStorage:storage];
    
    // then
    expect(updateModel.deletedRowIndexPaths).to.haveCount(0);
}

- (void)test_removeItemsAtIndexPathsFromStorage_negative_toNotRaiseExceptionWhenMovedPathsIsNil
{
    // given
    ANStorageModel* storage = self.storageModel;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageRemover removeItemsAtIndexPaths:nil fromStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_removeItemsAtIndexPathsFromStorage_negative_toNotRaiseExceptionWhenStorageIsNil
{
    // given
    NSSet* indexPaths = [self _indexPathsInStorage:self.storageModel];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageRemover removeItemsAtIndexPaths:indexPaths fromStorage:nil];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - removeItemsFromStorage

- (void)test_removeItemsFromStorage_positive_itemsRemovesFromStorage
{
    // given
    ANStorageModel* storage = self.storageModel;
    NSArray* items = [self _allItemsInStorage:storage];
    NSSet* setOfItems = [NSSet setWithArray:items];
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeItems:setOfItems fromStorage:storage];
    
    // them
    NSSet* returnedPaths = [self _indexPathsInStorage:storage];
    expect(updateModel.deletedRowIndexPaths.count).to.equal(returnedPaths.count);
}

- (void)test_removeItemsFromStorage_negative_toNotRaiseExceptionWhenItemsNil
{
    // given
    ANStorageModel* storage = self.storageModel;
    id items = nil;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageRemover removeItems:items fromStorage:storage];
    };
    
    // them
    expect(testBlock).toNot.raiseAny();
}

- (void)test_removeItemsFromStorage_negative_deletedPathHaveCountZeroWhenItemsNil
{
    // given
    ANStorageModel* storage = self.storageModel;
    id items = nil;
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeItems:items fromStorage:storage];
    
    // them
    expect(updateModel.deletedRowIndexPaths).to.haveCount(0);
}

- (void)test_removeItemsFromStorage_negative_toNotRaiseExceptionWhenStorageNil
{
    // given
    ANStorageModel* storage = nil;
    NSArray* items = [self _allItemsInStorage:self.storageModel];
    NSSet* setOfItems = [NSSet setWithArray:items];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageRemover removeItems:setOfItems fromStorage:storage];
    };
    
    // them
    expect(testBlock).toNot.raiseAny();
}


#pragma mark - removeSectionsFromStorage

- (void)test_removeSectionsFromStorage_positive_deletedSectionEqualInitial
{
    // given
    ANStorageModel* storage = self.storageModel;
    NSIndexSet* initialSet = [self _indexSetFromStorage:storage];
    
    // when
    ANStorageUpdateModel* updateModel = [ANStorageRemover removeSections:initialSet fromStorage:storage];
    
    // then
    NSIndexSet* removedSet = [self _indexSetFromStorage:storage];
    expect(updateModel.deletedSectionIndexes).to.equal(initialSet);
    expect(removedSet).to.haveCount(0);
}

- (void)test_removeSectionsFromStorage_negative_toNotRaiseExceptionWhenStorageIsNil
{
    // given
    ANStorageModel* storage = nil;
    NSIndexSet* initialSet = [self _indexSetFromStorage:self.storageModel];

    // when
    void(^testBlock)() = ^() {
        [ANStorageRemover removeSections:initialSet fromStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_removeSectionsFromStorage_negative_toNotRaiseExceptionWhenSectionsIsNil
{
    // given
    ANStorageModel* storage = self.storageModel;
    NSIndexSet* initialSet = nil;
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageRemover removeSections:initialSet fromStorage:storage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_removeSectionsFromStorage_negative_toNotRaiseExceptionWhenRemoveSectionsFromNotCorrectStorage
{
    // given
    ANStorageModel* storage = self.storageModel;
    NSIndexSet* initialSet = [self _indexSetFromStorage:storage];

    ANStorageModel* fakeStorage = [ANStorageModel new];
    
    // when
    void(^testBlock)() = ^() {
        [ANStorageRemover removeSections:initialSet fromStorage:fakeStorage];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

#pragma mark - removeAllItemsFromStorage

- (void)test_removeAllItemsFromStorage_positive_storageNotContainsSectionAfterRemoval
{
    // when
    [ANStorageRemover removeAllItemsFromStorage:self.storageModel];
    
    // then
    expect(self.storageModel.sections).to.haveCount(0);
}

- (void)test_removeAllItemsFromStorage_negative_toNotRaiseExceptionWhenStorageIsNil
{
    // when
    void(^testBlock)() = ^() {
        [ANStorageRemover removeAllItemsFromStorage:nil];
    };
    
    expect(testBlock).notTo.raiseAny();
}

@end
