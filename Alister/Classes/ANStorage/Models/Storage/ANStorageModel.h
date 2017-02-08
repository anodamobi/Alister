//
//  ANStorageModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageSectionModel.h"

/**
 Private class for storing in objects in memory.
 You should not use or call this class directly.
 */
@interface ANStorageModel : NSObject

/**
 This uses only for object difference inside storage. //TODO:
 */
@property (nonatomic, copy) NSString* footerKind;


/**
 This uses only for object difference inside storage.
 */
@property (nonatomic, copy) NSString* headerKind;


/**
 Returns array of items for the specified section index

 @param section section index which objects should be returned

 @return array of items from specified section
 */
- (NSArray*)itemsInSection:(NSInteger)section;


/**
 Returns array of all sections

 @return Nsarray with ANStorageSectionModels inside
 */
- (NSArray*)sections;

//TODO: doc
- (NSInteger)numberOfSections;

/**
 Returns specified object by indexPath. 
 By index.section - will find section and then by indexPath.row will return object from section items array. 
 If item at specified indexPath not exists will return nil.

 @param indexPath indexPath for item

 @return item at specified indexPath or nil if item is not found in storage
 */
- (id)itemAtIndexPath:(NSIndexPath*)indexPath;


/**
 Returns section model by index

 @param index index for section

 @return ANStorageSectionModel* object from storage
 */
- (ANStorageSectionModel*)sectionAtIndex:(NSInteger)index;


/**
 Adds new section in the end of sections array

 @param section section object to add
 */
- (void)addSection:(ANStorageSectionModel*)section;


/**
 Removes section at specified index from storage

 @param index index for section to remove
 */
- (void)removeSectionAtIndex:(NSInteger)index;


/**
 Removes all sections and as a result all items from the storage. 
 After this update storage will be empty.
 */
- (void)removeAllSections;


/**
 Returns BOOL flag that indicates does storage has items or not.
 Exising sections are not included, only items

 @return BOOL flag does storage have items or not.
 */
- (BOOL)isEmpty;

@end
