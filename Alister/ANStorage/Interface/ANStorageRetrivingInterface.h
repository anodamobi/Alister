//
//  ANStorageRetrivingInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageSectionModel;

NS_ASSUME_NONNULL_BEGIN

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
- (NSArray* _Nonnull)sections;


/**
 Returns specified object from storage. Can be nil if index path is not exist in storage

 @param indexPath for item in storage

 @return item by indexPath
 */
- (id _Nonnull)objectAtIndexPath:(NSIndexPath* _Nonnull)indexPath;


/**
 Returns specified section

 @param sectionIndex to retrive from storage

 @return ANStorageSectionModel* from storage
 */
- (ANStorageSectionModel*  _Nonnull)sectionAtIndex:(NSInteger)sectionIndex;


/**
 Returns all items from specified section
 Can be nil if section is not exist ot empty if no items there.
 
 @param sectionIndex for load items

 @return NSArray* from specified section
 */
- (NSArray* _Nonnull)itemsInSection:(NSInteger)sectionIndex;


/**
 Returns indexPath for item in storage. Will return nil if item not found

 @param item item in storage, can be nit but then method will return nil immidiately

 @return indexPath* for item in stirage
 */
- (NSIndexPath* _Nonnull)indexPathForItem:(id _Nonnull)item;


#pragma mark - Supplementaries

/**
 Convention method for UITableView to retrieve header viewModel specified for section.
 Can be nil if not set or section is not exist

 @param index section index to retrive header viewModel

 @return specified viewModel from storage
 */
- (id _Nonnull)headerModelForSectionIndex:(NSInteger)index;


/**
 Convention method for UITableView to retrieve footer viewModel specified for section.
 Can be nil if not set or section is not exist
 
 @param index section index to retrive footer viewModel
 
 @return specified viewModel from storage
 */
- (id _Nonnull)footerModelForSectionIndex:(NSInteger)index;


/**
 Convention method for UICollectionView to retrieve it supplementaty viewModels
 Can be nil if section not exist or supplementary was never set
 
 @param kind         supplementary kind from UICollectionView
 @param sectionIndex for section where this viewModel should be found

 @return viewModel from storage
 */
- (id _Nonnull)supplementaryModelOfKind:(NSString* _Nonnull)kind forSectionIndex:(NSInteger)sectionIndex;

//TODO: doc
- (NSString* _Nonnull)headerSupplementaryKind;
- (NSString* _Nonnull)footerSupplementaryKind;

@end

NS_ASSUME_NONNULL_END
