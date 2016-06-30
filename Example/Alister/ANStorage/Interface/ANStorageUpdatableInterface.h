//
//  ANDataStorageUpdatableInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@protocol ANStorageUpdatableInterface <NSObject>


#pragma mark - Adding Items

- (void)addItem:(id)item;
- (void)addItem:(id)item toSection:(NSUInteger)sectionIndex;
- (void)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath;

- (void)addItems:(NSArray*)items;
- (void)addItems:(NSArray*)items toSection:(NSUInteger)sectionIndex;


#pragma mark - Reloading Items

- (void)reloadItem:(id)item;
- (void)reloadItems:(id)items;


#pragma mark - Removing Items

- (void)removeItem:(id)item;
- (void)removeItemsAtIndexPaths:(NSArray*)indexPaths;
- (void)removeItems:(NSArray*)items;
- (void)removeAllItems;


#pragma mark - Changing and Reorder Items

- (void)replaceItem:(id)itemToReplace withItem:(id)replacingItem;
- (void)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath;


#pragma mark - Sections

- (void)removeSections:(NSIndexSet*)indexSet;


#pragma mark - Views Models

- (void)setSectionHeaderModel:(id)headerModel forSectionIndex:(NSUInteger)sectionIndex;
- (void)setSectionFooterModel:(id)footerModel forSectionIndex:(NSUInteger)sectionIndex;


//collection view

- (void)setSupplementaryHeaderKind:(NSString*)headerKind;
- (void)setSupplementaryFooterKind:(NSString*)footerKind;

@end