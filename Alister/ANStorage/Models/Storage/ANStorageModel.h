//
//  ANStorageModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageSectionModel;

@interface ANStorageModel : NSObject

- (NSArray*)itemsInSection:(NSUInteger)section;
- (NSArray*)sections;

- (id)itemAtIndexPath:(NSIndexPath*)indexPath;
- (id)sectionAtIndex:(NSUInteger)index;

- (void)addSection:(ANStorageSectionModel*)section;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)removeAllSections;

@end
