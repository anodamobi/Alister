//
//  ANStorageModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@import Foundation;

@interface ANStorageModel : NSObject

- (NSArray*)sections;

- (void)addSection:(id)section;

- (id)sectionAtIndex:(NSUInteger)index;

- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)removeAllSections;

@end
