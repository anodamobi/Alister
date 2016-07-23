//
//  ANStorageLoader.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageModel;
@class ANStorageSectionModel;

@interface ANStorageLoader : NSObject

+ (id)itemAtIndexPath:(NSIndexPath*)indexPath inStorage:(ANStorageModel*)storage;
+ (NSIndexPath*)indexPathForItem:(id)item inStorage:(ANStorageModel*)storage;

+ (NSArray*)itemsInSection:(NSUInteger)sectionNumber inStorage:(ANStorageModel*)storage;
+ (NSArray*)indexPathArrayForItems:(NSArray*)items inStorage:(ANStorageModel*)storage;

+ (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex inStorage:(ANStorageModel*)storage;

@end
