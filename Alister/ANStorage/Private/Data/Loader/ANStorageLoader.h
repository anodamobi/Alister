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

+ (NSArray*)itemsInSection:(NSUInteger)sectionIndex inStorage:(ANStorageModel*)storage;
+ (NSArray*)indexPathArrayForItems:(NSArray*)items inStorage:(ANStorageModel*)storage;

+ (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex inStorage:(ANStorageModel*)storage;

/**
 Returns supplemetary model for specified section and with specified kind
 
 @param kind         for model
 @param sectionIndex for section to return
 
 @return viewModel with specified kind
 */

+ (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionIndex inStorage:(ANStorageModel*)storage;

@end
