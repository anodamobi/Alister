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

- (id)headerModelForSectionIndex:(NSUInteger)index;
- (id)footerModelForSectionIndex:(NSUInteger)index;

- (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionIndex;

- (BOOL)isEmpty;

- (NSString*)footerSupplementaryKind;
- (NSString*)headerSupplementaryKind;

@end
