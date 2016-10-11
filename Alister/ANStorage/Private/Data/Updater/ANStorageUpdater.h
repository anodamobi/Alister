//
//  ANStorageUpdater.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageModel;
@class ANStorageUpdateModel;

@interface ANStorageUpdater : NSObject


/**
 Adds item to section at zero index.

 @param item  to add. If value is nil no update will be generated
 @param storageModel storage where item will be inserted
 
 @return UpdateModel that contains diff for current operation
 */

+ (ANStorageUpdateModel* __nullable)addItem:(id)item toStorage:(ANStorageModel*)storageModel;


/**
 Adds item to the specified section. If section index higher than existing sections count, 
 all non-existing sections will be generated with empty row array. 
 Item will be appended to current items array.

 @param item          to add. If value is nil no update will be generated
 @param sectionIndex  section to add item.
 @param model         model to insert to storage

 @return UpdateModel that contains diff for current operation
 */

+ (ANStorageUpdateModel* __nullable)addItem:(id)item toSection:(NSUInteger)sectionIndex toStorage:(ANStorageModel*)model;

+ (ANStorageUpdateModel* __nullable)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath toStorage:(ANStorageModel*)model;

+ (ANStorageUpdateModel* __nullable)addItems:(NSArray*)items toStorage:(ANStorageModel*)model;
+ (ANStorageUpdateModel* __nullable)addItems:(NSArray*)items toSection:(NSUInteger)sectionNumber toStorage:(ANStorageModel*)model;

+ (ANStorageUpdateModel* __nullable)replaceItem:(id)itemToReplace withItem:(id)replacingItem inStorage:(ANStorageModel*)storage;

+ (ANStorageUpdateModel* __nullable)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath
                                              toIndexPath:(NSIndexPath*)toIndexPath
                                                inStorage:(ANStorageModel*)storage;

+ (ANStorageUpdateModel* __nullable)reloadItem:(id)item inStorage:(ANStorageModel*)storage;
+ (ANStorageUpdateModel* __nullable)reloadItems:(NSArray*)items inStorage:(ANStorageModel*)storage;

+ (NSIndexSet* __nullable)createSectionIfNotExist:(NSUInteger)sectionNumber inStorage:(ANStorageModel*)storage;

@end
