//
//  ANStorageUpdater.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageModel;
@class ANStorageUpdateModel;

/**
 
 This is a private class. You shouldn't use it directly in your code.
 ANStorageUpdater generates micro-transactions based on storage model updates.
 Also it handles all possible invalid arguments situations like nil values,
 or NSNotFound indexes to avoid crash and freezes.
 
 */

@interface ANStorageUpdater : NSObject

NS_ASSUME_NONNULL_BEGIN


//TODO: doc
+ (instancetype)updaterWithStorageModel:(ANStorageModel*)model delegate:(id)delegate;

/**
 Adds item to section at zero index.
 
 @param item  to add. If value is nil empty update will be generated
 
 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

- (ANStorageUpdateModel*)addItem:(id)item;


/**
 Adds item to the specified section. If section index higher than existing sections count,
 all non-existing sections will be generated with empty rows array.
 Item will be appended to current items array.
 If any parameter will be nil, no update will be generated.
 
 @param item          to add in storage
 @param sectionIndex  section to add item.
 
 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

- (ANStorageUpdateModel*)addItem:(id)item toSection:(NSUInteger)sectionIndex;


/**
 Adds array of items to the zero section. If section index higher than existing sections count,
 all non-existing sections will be generated with empty rows array.
 Items will be appended to current items array.
 If any parameter will be nil, no update will be generated.
 
 @param items NSArray* of items to insert in specified storage
 
 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

- (ANStorageUpdateModel*)addItems:(NSArray*)items;


/**
 Adds array of items to the specified section. If section index higher than existing sections count,
 all non-existing sections will be generated with empty rows array.
 Items will be appended to current items array.
 If any parameter will be nil, no update will be generated.
 
 @param items         NSArray* of items to insert in specified storage
 @param sectionIndex  index for section where items should be added
 
 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

- (ANStorageUpdateModel*)addItems:(NSArray*)items toSection:(NSUInteger)sectionIndex;


/**
 
 Adds item to the specified indexPath in storage. If row higher that existed count of
 objects in section, update will be ignored. 
 If any parameter will be nil, no update will be generated.
 
 @param item      to add in storage
 @param indexPath for item in storage after update

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

- (ANStorageUpdateModel*)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath;


/**
 Replaces specified item with new one.
 If any parameter will be nil, no update will be generated.

 @param itemToReplace item to replace, old existing item should be in storage already
 @param replacingItem new item, on which old item should be replaced

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

- (ANStorageUpdateModel*)replaceItem:(id)itemToReplace withItem:(id)replacingItem;


/**
 Moves item on specified indexPath to new indexPath. 
 If any parameter will be nil, no update will be generated.

 @param fromIndexPath NSIndexPath* to get item from. If there is no item at this indexPath operation will be terminated.
 @param toIndexPath   NSIndexPath* new place for item. If there is no section for indexPath.section it will be generated. If in thi section number of items less than specified indexPath.row operation will be ternimated.

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

- (ANStorageUpdateModel*)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath
                                   toIndexPath:(NSIndexPath*)toIndexPath;


/**
 Reloads specified item. 
 You need this method when your item still the same, but it's content was updated.
 If any parameter will be nil, no update will be generated.
 @param item    to reload

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

- (ANStorageUpdateModel*)reloadItem:(id)item;


/**
 Reloads specified items array in storage.
 You need this method when your item objects are still the same, but their content was updated.
 If any parameter will be nil, no update will be generated.

 @param items   NSArray* items array for reload

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */
- (ANStorageUpdateModel*)reloadItems:(NSArray*)items;


/**
 Generates empty sections to match count with specified index.

 @param sectionIndex section index up to what all section should be created

 @return NSIndexSet* that contains indexes of all creted sections.
 */

- (NSIndexSet*)createSectionIfNotExist:(NSInteger)sectionIndex;

NS_ASSUME_NONNULL_END

@end
