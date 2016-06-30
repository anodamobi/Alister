//
//  ANStorageRemover.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageModel;
@class ANStorageUpdateModel;

@interface ANStorageRemover : NSObject

+ (ANStorageUpdateModel*)removeItem:(id)item fromStorage:(ANStorageModel*)storage;

+ (ANStorageUpdateModel*)removeItemsAtIndexPaths:(NSArray*)indexPaths fromStorage:(ANStorageModel*)storage;
+ (ANStorageUpdateModel*)removeItems:(NSArray *)items fromStorage:(ANStorageModel*)storage;

+ (ANStorageUpdateModel*)removeSections:(NSIndexSet*)indexSet fromStorage:(ANStorageModel*)storage;

+ (ANStorageUpdateModel*)removeAllItemsFromStorage:(ANStorageModel*)storage;

@end
