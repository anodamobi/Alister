//
//  ANStorageUpdateModelInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/29/16.
//
//

@protocol ANStorageUpdateModelInterface <NSObject>

- (NSIndexSet*)deletedSectionIndexes;
- (NSIndexSet*)insertedSectionIndexes;
- (NSIndexSet*)updatedSectionIndexes;

- (NSArray*)deletedRowIndexPaths;
- (NSArray*)insertedRowIndexPaths;
- (NSArray*)updatedRowIndexPaths;
- (NSArray*)movedRowsIndexPaths;

- (void)addDeletedSectionIndex:(NSUInteger)index;
- (void)addUpdatedSectionIndex:(NSUInteger)index;
- (void)addInsertedSectionIndex:(NSUInteger)index;

- (void)addInsertedSectionIndexes:(NSIndexSet*)indexSet;
- (void)addUpdatedSectionIndexes:(NSIndexSet*)indexSet;
- (void)addDeletedSectionIndexes:(NSIndexSet*)indexSet;

- (void)addInsertedIndexPaths:(NSArray*)items;
- (void)addUpdatedIndexPaths:(NSArray*)items;
- (void)addDeletedIndexPaths:(NSArray*)items;
- (void)addMovedIndexPaths:(NSArray*)items;

- (BOOL)isRequireReload;

@end
