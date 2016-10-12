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
 Also it handles app possible invalid arguments situations like nil values,
 or NSNotFound indexes to avoid crash and freezes.
 
 */

@interface ANStorageUpdater : NSObject

NS_ASSUME_NONNULL_BEGIN


/**
 Adds item to section at zero index.
 
 @param item  to add. If value is nil empty update will be generated
 @param storageModel storage where item will be inserted
 
 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

+ (ANStorageUpdateModel*)addItem:(id)item toStorage:(ANStorageModel*)storageModel;


/**
 Adds item to the specified section. If section index higher than existing sections count,
 all non-existing sections will be generated with empty rows array.
 Item will be appended to current items array.
 If any parameter will be nil, no update will be generated.
 
 @param item          to add in storage
 @param sectionIndex  section to add item.
 @param model         to insert to storage
 
 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

+ (ANStorageUpdateModel*)addItem:(id)item toSection:(NSUInteger)sectionIndex toStorage:(ANStorageModel*)model;


/**
 Adds array of items to the zero section. If section index higher than existing sections count,
 all non-existing sections will be generated with empty rows array.
 Items will be appended to current items array.
 If any parameter will be nil, no update will be generated.
 
 @param items NSArray* of items to insert in specified storage
 @param model where this item should be inserted
 
 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

+ (ANStorageUpdateModel*)addItems:(NSArray*)items toStorage:(ANStorageModel*)model;


/**
 Adds array of items to the specified section. If section index higher than existing sections count,
 all non-existing sections will be generated with empty rows array.
 Items will be appended to current items array.
 If any parameter will be nil, no update will be generated.
 
 @param items         NSArray* of items to insert in specified storage
 @param sectionIndex  index for section where items should be added
 @param model         where this item should be inserted
 
 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

+ (ANStorageUpdateModel*)addItems:(NSArray*)items toSection:(NSUInteger)sectionIndex toStorage:(ANStorageModel*)model;


/**
 
 Adds item to the specified indexPath in storage. If row higher that existed count of
 objects in section, update will be ignored. 
 If any parameter will be nil, no update will be generated.
 
 @param item      to add in storage
 @param indexPath for item in storage after update
 @param model     where this item should be inserted

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

+ (ANStorageUpdateModel*)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath toStorage:(ANStorageModel*)model;


/**
 Replaces specified item with new one.
 If any parameter will be nil, no update will be generated.

 @param itemToReplace item to replace, old existing item should be in storage already
 @param replacingItem new item, on which old item should be replaced
 @param storage       where this item should be inserted

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

+ (ANStorageUpdateModel*)replaceItem:(id)itemToReplace withItem:(id)replacingItem inStorage:(ANStorageModel*)storage;


/**
 Moves item on specified indexPath to new indexPath. 
 If any parameter will be nil, no update will be generated.

 @param fromIndexPath NSIndexPath* to get item from. If there is no item at this indexPath operation will be terminated.
 @param toIndexPath   NSIndexPath* new place for item. If there is no section for indexPath.section it will be generated. If in thi section number of items less than specified indexPath.row operation will be ternimated.
 @param storage       where this item should be inserted

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

+ (ANStorageUpdateModel*)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath
                                   toIndexPath:(NSIndexPath*)toIndexPath
                                     inStorage:(ANStorageModel*)storage;


/**
 Reloads specified item. 
 You need this method when your item still the same, but it's content was updated.
 If any parameter will be nil, no update will be generated.
 @param item    to reload
 @param storage where this item should be reloaded.

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */

+ (ANStorageUpdateModel*)reloadItem:(id)item inStorage:(ANStorageModel*)storage;


/**
 Reloads specified items array in storage.
 You need this method when your item objects are still the same, but their content was updated.
 If any parameter will be nil, no update will be generated.

 @param items   NSArray* items array for reload
 @param storage where this item should be inserted

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */
+ (ANStorageUpdateModel*)reloadItems:(NSArray*)items inStorage:(ANStorageModel*)storage;


/**
 Generates empty sections to match count with specified index.

 @param sectionIndex section index up to what all section should be created
 @param storage       where this item should be inserted

 @return NSIndexSet* that contains indexes of all creted sections.
 */

+ (NSIndexSet*)createSectionIfNotExist:(NSInteger)sectionIndex inStorage:(ANStorageModel*)storage;

NS_ASSUME_NONNULL_END

@end
