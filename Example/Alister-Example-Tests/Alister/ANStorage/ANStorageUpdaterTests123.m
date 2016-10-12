//
//  ANStorageUpdaterTests.m
//  Alister-Example
//
//  Created by ANODA on 8/29/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#pragma mark - Helper Methods

- (ANStorageModel*)_fullStorage
{
    ANStorageModel* storage = [ANStorageModel new];
    for (NSInteger sectionsCounter = 0; sectionsCounter < kMaxSectionsCount; sectionsCounter++)
    {
        ANStorageSectionModel* section = [ANStorageSectionModel new];
        [[self _testItems] enumerateObjectsUsingBlock:^(id  _Nonnull obj, __unused NSUInteger idx, __unused BOOL*  _Nonnull stop) {
            [section addItem:obj];
        }];
        [storage addSection:section];
    }
    
    return storage;
}

- (NSArray*)_itemsInStorage:(ANStorageModel*)storage
{
    NSMutableArray* items = [NSMutableArray array];
    [storage.sections enumerateObjectsUsingBlock:^(__unused ANStorageSectionModel*  _Nonnull sectionModel, NSUInteger idx, __unused BOOL*  _Nonnull stop) {
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
