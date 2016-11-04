//
//  ANStorageRemover.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageModel;
@class ANStorageUpdateModel;

#import "ANStorageUpdateOperationInterface.h"

/**
 
 This is a private class. You shouldn't use it directly in your code.
 ANStorageRemover generates micro-transactions based on storage model updates.
 Also it handles all possible invalid arguments situations like nil values,
 or NSNotFound indexes to avoid crash and freezes.
 
 */

NS_ASSUME_NONNULL_BEGIN

@interface ANStorageRemover : NSObject

//TODO: doc
+ (instancetype)removerWithStorageModel:(ANStorageModel*)storageModel andUpdateDelegate:(id<ANStorageUpdateOperationInterface>)delegate;

@property (nonatomic, weak) id<ANStorageUpdateOperationInterface> updateDelegate;

/**
 Removes specified item from storage.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.

 @param item    item to remove
 
 */
- (void)removeItem:(id)item;


/**
 Removes specified set of indexPaths from storage.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 
 @param indexPaths NSSet* of indexPaths which should be removed

 */
- (void)removeItemsAtIndexPaths:(NSSet*)indexPaths;


/**
 Removes specified set of items from storage.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 
 @param items   NSSet* of items which should be removed. Not tested if storage contains equal objects.
 */
- (void)removeItems:(NSSet*)items;


/**
 Removes specified set of section indexes from storage.
 Sends to delegate UpdateModel that contains diff for current operation.
 If operation was terminated update will be empty.
 
 @param indexSet NSIndexSet* of section indexes which you want to remove

 */
- (void)removeSections:(NSIndexSet*)indexSet;


/**
 Removes all sections and all items in sections and restores initial state.
 Sends to delegate UpdateModel that contains diff for current operation. 
 If operation was terminated update will be empty.
 */
- (void)removeAllItemsAndSections;

@end

NS_ASSUME_NONNULL_END
