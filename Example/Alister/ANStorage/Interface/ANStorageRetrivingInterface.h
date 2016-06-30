//
//  ANStorageRetrivingInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageSectionModel;

@protocol ANStorageRetrivingInterface <NSObject>

- (NSArray*)sections;
- (id)objectAtIndexPath:(NSIndexPath*)indexPath;

- (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex;

- (NSArray*)itemsInSection:(NSUInteger)sectionIndex;
- (id)itemAtIndexPath:(NSIndexPath*)indexPath;
- (NSIndexPath*)indexPathForItem:(id)item;

- (id)headerModelForSectionIndex:(NSInteger)index;
- (id)footerModelForSectionIndex:(NSInteger)index;

- (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionNumber;

- (BOOL)isEmpty;

@end
