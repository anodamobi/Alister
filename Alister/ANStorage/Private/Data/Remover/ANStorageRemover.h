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

//single
+ (ANStorageUpdateModel*)removeItem:(id)item fromStorage:(ANStorageModel*)storage;
+ (ANStorageUpdateModel*)removeItemsAtIndexPaths:(NSSet*)indexPaths fromStorage:(ANStorageModel*)storage;
+ (ANStorageUpdateModel*)removeItems:(NSSet*)items fromStorage:(ANStorageModel*)storage;
//section
+ (ANStorageUpdateModel*)removeSections:(NSIndexSet*)indexSet fromStorage:(ANStorageModel*)storage;
//all
+ (ANStorageUpdateModel*)removeAllItemsAndSectionsFromStorage:(ANStorageModel*)storage;

@end
