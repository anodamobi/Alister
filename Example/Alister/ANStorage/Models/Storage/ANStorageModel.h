//
//  ANStorageModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@import Foundation;

@interface ANStorageModel : NSObject

- (id)itemAtIndexPath:(NSIndexPath*)indexPath;
- (NSArray*)itemsInSection:(NSUInteger)section;

//sections
- (NSArray*)sections;
- (id)sectionAtIndex:(NSUInteger)index;
- (void)addSection:(id)section;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)removeAllSections;

@end
