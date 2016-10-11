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

+ (ANStorageUpdateModel*)addItem:(id)item toStorage:(ANStorageModel*)model;
+ (ANStorageUpdateModel*)addItem:(id)item toSection:(NSUInteger)sectionNumber toStorage:(ANStorageModel*)model;
+ (ANStorageUpdateModel*)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath toStorage:(ANStorageModel*)model;

+ (ANStorageUpdateModel*)addItems:(NSArray*)items toStorage:(ANStorageModel*)model;
+ (ANStorageUpdateModel*)addItems:(NSArray*)items toSection:(NSUInteger)sectionNumber toStorage:(ANStorageModel*)model;

+ (ANStorageUpdateModel*)replaceItem:(id)itemToReplace withItem:(id)replacingItem inStorage:(ANStorageModel*)storage;

+ (ANStorageUpdateModel*)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath
                                   toIndexPath:(NSIndexPath*)toIndexPath
                                     inStorage:(ANStorageModel*)storage;

+ (ANStorageUpdateModel*)reloadItem:(id)item inStorage:(ANStorageModel*)storage;
+ (ANStorageUpdateModel*)reloadItems:(NSArray*)items inStorage:(ANStorageModel*)storage;

+ (NSIndexSet*)createSectionIfNotExist:(NSUInteger)sectionNumber inStorage:(ANStorageModel*)storage;

@end
