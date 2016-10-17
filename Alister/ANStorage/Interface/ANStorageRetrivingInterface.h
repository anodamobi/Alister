//
//  ANStorageRetrivingInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageSectionModel;


/**
 This is public convention protocol to retrive items from storage
 */
@protocol ANStorageRetrivingInterface <NSObject>


/**
 Returns does storage contain items or not. 
 !important Storage is empty if it has no rows, but it can has sections and be empty.

 @return BOOL is storage contain items
 */
- (BOOL)isEmpty;

/**
 Returns all sections from storage including empty

 @return NSArray of ANStorageSectionModel* with all sections from storage
 */
- (NSArray*)sections;


/**
 Returns specified object from storage. Can be nil if index path is not exist in storage

 @param indexPath for item in storage

 @return item by indexPath
 */
- (nullable id)objectAtIndexPath:(NSIndexPath*)indexPath;


/**
 Returns specified section

 @param sectionIndex to retrive from storage

 @return ANStorageSectionModel* from storage
 */
- (nullable ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex;


/**
 Returns all items from specified section
 Can be nil if section is not exist ot empty if no items there.
 
 @param sectionIndex for load items

 @return NSArray* from specified section
 */
- (nullable NSArray*)itemsInSection:(NSUInteger)sectionIndex;


/**
 Returns indexPath for item in storage. Will return nil if item not found

 @param item item in storage, can be nit but then method will return nil immidiately

 @return indexPath* for item in stirage
 */
- (nullable NSIndexPath*)indexPathForItem:(id)item;


#pragma mark - Supplementaries

/**
 Convention method for UITableView to retrieve header viewModel specified for section.
 Can be nil if not set or section is not exist

 @param index section index to retrive header viewModel

 @return specified viewModel from storage
 */
- (nullable id)headerModelForSectionIndex:(NSUInteger)index;


/**
 Convention method for UITableView to retrieve footer viewModel specified for section.
 Can be nil if not set or section is not exist
 
 @param index section index to retrive footer viewModel
 
 @return specified viewModel from storage
 */
- (nullable id)footerModelForSectionIndex:(NSUInteger)index;


/**
 Convention method for UICollectionView to retrieve it supplementaty viewModels
 Can be nil if section not exist or supplementary was never set
 
 @param kind         supplementary kind from UICollectionView
 @param sectionIndex for section where this viewModel should be found

 @return viewModel from storage
 */
- (nullable id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionIndex;


@end
