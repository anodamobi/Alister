//
//  ANDataStorageUpdatableInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@protocol ANStorageUpdatableInterface <NSObject>


#pragma mark - Adding Items

- (void)addItem:(id _Nonnull)item;
- (void)addItem:(id _Nonnull)item toSection:(NSInteger)sectionIndex;
- (void)addItem:(id _Nonnull)item atIndexPath:(NSIndexPath* _Nonnull)indexPath;

- (void)addItems:(NSArray* _Nonnull)items;
- (void)addItems:(NSArray* _Nonnull)items toSection:(NSInteger)sectionIndex;


#pragma mark - Reloading Items

- (void)reloadItem:(id _Nonnull)item;
- (void)reloadItems:(id _Nonnull)items;


#pragma mark - Removing Items

- (void)removeItem:(id _Nonnull)item;
- (void)removeItemsAtIndexPaths:(NSArray* _Nonnull)indexPaths;
- (void)removeItems:(NSArray* _Nonnull)items;
- (void)removeAllItemsAndSections;


#pragma mark - Changing and Reorder Items

- (void)replaceItem:(id _Nonnull)itemToReplace withItem:(id _Nonnull)replacingItem;
- (void)moveItemFromIndexPath:(NSIndexPath* _Nonnull)fromIndexPath toIndexPath:(NSIndexPath* _Nonnull)toIndexPath;


/**
 This method specially to pair UITableView's method:
 - (void)moveRowAtIndexPath:(NSIndexPath*)indexPath toIndexPath:(NSIndexPath*)newIndexPath

 @param fromIndexPath from which indexPath item should removed
 @param toIndexPath   to which indexPath item should be inserted
 */
- (void)moveItemWithoutUpdateFromIndexPath:(NSIndexPath* _Nonnull)fromIndexPath toIndexPath:(NSIndexPath* _Nonnull)toIndexPath;


#pragma mark - Sections

- (void)removeSections:(NSIndexSet* _Nonnull)indexSet;


#pragma mark - Views Models

- (void)updateSectionHeaderModel:(id _Nonnull)headerModel forSectionIndex:(NSInteger)sectionIndex;
- (void)updateSectionFooterModel:(id _Nonnull)footerModel forSectionIndex:(NSInteger)sectionIndex;


//collection view

- (void)updateSupplementaryHeaderKind:(NSString* _Nonnull)headerKind;
- (void)updateSupplementaryFooterKind:(NSString* _Nonnull)footerKind;

@end
