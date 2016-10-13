//
//  ANStorageRemover.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageModel;
@class ANStorageUpdateModel;

/**
 
 This is a private class. You shouldn't use it directly in your code.
 ANStorageRemover generates micro-transactions based on storage model updates.
 Also it handles all possible invalid arguments situations like nil values,
 or NSNotFound indexes to avoid crash and freezes.
 
 */

@interface ANStorageRemover : NSObject


/**
 Removes specified item from storage.

 @param item    item to remove
 @param storage storageModel storage where item should be deleted.

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */
+ (ANStorageUpdateModel*)removeItem:(id)item fromStorage:(ANStorageModel*)storage;


/**
 Removes specified set of indexPaths from storage.

 @param indexPaths NSSet* of indexPaths which should be removed
 @param storage    storageModel storage where item should be deleted.

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */
+ (ANStorageUpdateModel*)removeItemsAtIndexPaths:(NSSet*)indexPaths fromStorage:(ANStorageModel*)storage;


/**
 Removes specified set of items from storage.

 @param items   NSSet* of items which should be removed. Not tested if storage contains equal objects.
 @param storage storageModel storage where item should be deleted.

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */
+ (ANStorageUpdateModel*)removeItems:(NSSet*)items fromStorage:(ANStorageModel*)storage;


/**
  Removes specified set of section indexes from storage.

 @param indexSet NSIndexSet* of section indexes which you want to remove
 @param storage  storageModel storage where item should be deleted.

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */
+ (ANStorageUpdateModel*)removeSections:(NSIndexSet*)indexSet fromStorage:(ANStorageModel*)storage;


/**
 Removes all sections and all items in sections. 
 Restores initial state.

 @param storage storageModel storage where item should be deleted.

 @return UpdateModel that contains diff for current operation. If operation was terminated update will be empty.
 */
+ (ANStorageUpdateModel*)removeAllItemsAndSectionsFromStorage:(ANStorageModel*)storage;

@end
