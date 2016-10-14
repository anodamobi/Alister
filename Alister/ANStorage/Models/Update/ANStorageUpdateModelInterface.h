//
//  ANStorageUpdateModelInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/29/16.
//
//

/**
 Interface methods for ANStorageUpdateModel to generate updates.
 */
@protocol ANStorageUpdateModelInterface <NSObject>


/**
 Returns all deleted section indexes

 @return deleted sections indexSet
 */
- (NSIndexSet*)deletedSectionIndexes;


/**
 Returns all inserted section indexes
 
 @return inserted sections indexSet
 */
- (NSIndexSet*)insertedSectionIndexes;


/**
 Returns all updated section indexes
 
 @return updated sections indexSet
 */
- (NSIndexSet*)updatedSectionIndexes;


/**
 Returns array of deleted indexPaths

 @return NSArray* deleted indexPaths
 */
- (NSArray*)deletedRowIndexPaths;


/**
 Returns array of inserted indexPaths
 
 @return NSArray* inserted indexPaths
 */
- (NSArray*)insertedRowIndexPaths;


/**
 Returns array of updated indexPaths
 
 @return NSArray* updated indexPaths
 */
- (NSArray*)updatedRowIndexPaths;


/**
 Returns array of moved indexPaths
 
 @return NSArray* moved indexPaths
 */
- (NSArray*)movedRowsIndexPaths;


/**
 Adds new index in a specified IndexSet

 @param index index to add
 */
- (void)addDeletedSectionIndex:(NSUInteger)index;


/**
 Adds new index in a specified IndexSet
 
 @param index index to add
 */
- (void)addUpdatedSectionIndex:(NSUInteger)index;


/**
 Adds new index in a specified IndexSet
 
 @param index index to add
 */
- (void)addInsertedSectionIndex:(NSUInteger)index;


/**
 Adds new indexes from indexSet to a inserted IndexSet
 
 @param indexSet indexes to add
 */
- (void)addInsertedSectionIndexes:(NSIndexSet*)indexSet;


/**
 Adds new indexes from indexSet to a updated IndexSet
 
 @param indexSet indexes to add
 */
- (void)addUpdatedSectionIndexes:(NSIndexSet*)indexSet;


/**
 Adds new indexes from indexSet to a deleted IndexSet
 
 @param indexSet indexes to add
 */
- (void)addDeletedSectionIndexes:(NSIndexSet*)indexSet;


/**
 Adds new indexPaths to existing property

 @param items NSArray* with inserted indexPaths. No update will happen if parameter is nil.
 */
- (void)addInsertedIndexPaths:(NSArray*)items;


/**
 Adds new indexPaths to existing property
 
 @param items NSArray* with updated indexPaths. No update will happen if parameter is nil.
 */
- (void)addUpdatedIndexPaths:(NSArray*)items;


/**
 Adds new indexPaths to existing property
 
 @param items NSArray* with deleted indexPaths. No update will happen if parameter is nil.
 */
- (void)addDeletedIndexPaths:(NSArray*)items;


/**
 Adds new indexPaths to existing property
 
 @param items NSArray* with moved indexPaths. No update will happen if parameter is nil.
 */
- (void)addMovedIndexPaths:(NSArray*)items;


/**
 Indicates does storage got big update so now related TableView or CollectionView 
 should be reloaded insted of applying updates.

 @return BOOL does require reload
 */
- (BOOL)isRequireReload;

@end
