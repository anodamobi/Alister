//
//  ANStorageUpdater.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdateOperationInterface.h"

@class ANStorageModel;

/**
 
 This is a private class. You shouldn't use it directly in your code.
 ANStorageUpdater generates micro-transactions based on storage model updates.
 Also it handles all possible invalid arguments situations like nil values,
 or NSNotFound indexes to avoid crash and freezes.
 
 */

@interface ANStorageUpdater : NSObject

NS_ASSUME_NONNULL_BEGIN

//TODO: doc
+ (instancetype)updaterWithStorageModel:(ANStorageModel*)model;

@property (nonatomic, weak) id<ANStorageUpdateOperationInterface> updateDelegate;

/**
 Adds item to section at zero index.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 
 @param item  to add. If value is nil empty update will be generated
 */

- (void)addItem:(id)item;


/**
 Adds item to the specified section. If section index higher than existing sections count,
 all non-existing sections will be generated with empty rows array.
 Item will be appended to current items array.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 
 @param item          to add in storage
 @param sectionIndex  section to add item.
 */

- (void)addItem:(id)item toSection:(NSInteger)sectionIndex;


/**
 Adds array of items to the zero section. If section index higher than existing sections count,
 all non-existing sections will be generated with empty rows array.
 Items will be appended to current items array.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 
 @param items NSArray* of items to insert in specified storage
 */

- (void)addItems:(NSArray*)items;


/**
 Adds array of items to the specified section. If section index higher than existing sections count,
 all non-existing sections will be generated with empty rows array.
 Items will be appended to current items array.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 
 @param items         NSArray* of items to insert in specified storage
 @param sectionIndex  index for section where items should be added
 */

- (void)addItems:(NSArray*)items toSection:(NSInteger)sectionIndex;


/**
 
 Adds item to the specified indexPath in storage. If row higher that existed count of
 objects in section, update will be ignored. 
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 
 @param item      to add in storage
 @param indexPath for item in storage after update
 */

- (void)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath;


/**
 Replaces specified item with new one.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.

 @param itemToReplace item to replace, old existing item should be in storage already
 @param replacingItem new item, on which old item should be replaced
 */

- (void)replaceItem:(id)itemToReplace withItem:(id)replacingItem;


/**
 This method specially to pair UITableView's method:
 - (void)moveRowAtIndexPath:(NSIndexPath*)indexPath toIndexPath:(NSIndexPath*)newIndexPath
 
 @param fromIndexPath from which indexPath item should removed
 @param toIndexPath   to which indexPath item should be inserted
 */
- (void)moveItemWithoutUpdateFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath;


/**
 Moves item on specified indexPath to new indexPath. 
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.

 @param fromIndexPath NSIndexPath* to get item from. If there is no item at this indexPath operation will be terminated.
 @param toIndexPath   NSIndexPath* new place for item. If there is no section for indexPath.section it will be generated. If in thi section number of items less than specified indexPath.row operation will be ternimated.
 */

- (void)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath;


/**
 Reloads specified item. 
 You need this method when your item still the same, but it's content was updated.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 @param item    to reload
 */

- (void)reloadItem:(id)item;


/**
 Reloads specified items array in storage.
 You need this method when your item objects are still the same, but their content was updated.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.

 @param items   NSArray* items array for reload
 */
- (void)reloadItems:(NSArray*)items;


/**
 Generates empty sections to match count with specified index.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 
 @param sectionIndex section index up to what all section should be created

 @return NSIndexSet* that contains indexes of all creted sections.
 */

- (NSIndexSet*)createSectionIfNotExist:(NSInteger)sectionIndex;


/**
 Convention method for tables to register header model.
 You need to update headerKind property on storageModel before any updates
 
 @param headerModel  viewModel for header
 @param sectionIndex section index in UITableView
 */

- (void)updateSectionHeaderModel:(id)headerModel forSectionIndex:(NSInteger)sectionIndex;


/**
 Convention method for tables to register footer model
 You need to update footerKind property on storageModel before any updates
 
 @param footerModel  viewModel for footer
 @param sectionIndex section index in UITableView
 */

- (void)updateSectionFooterModel:(id)footerModel forSectionIndex:(NSInteger)sectionIndex;


NS_ASSUME_NONNULL_END

@end
