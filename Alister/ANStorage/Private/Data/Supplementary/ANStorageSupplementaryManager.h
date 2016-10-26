//
//  ANStorageSupplementaryManager.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageUpdateModel;
@class ANStorageModel;

/**
 Private class for register and retrive supplementary models from storage. 
 You shouldn't use this class directly in your code.
 */

@interface ANStorageSupplementaryManager : NSObject

+ (instancetype)supplementatyManagerWithStorageModel:(ANStorageModel*)model withDelegate:(id)delegate;


/**
 Convention method for tables to register header model. 
 You need to update headerKind property on storageModel before any updates
 
 @param headerModel  viewModel for header
 @param sectionIndex section index in UITableView
 
 @return ANStorageUpdateModel* generated update
 */

- (ANStorageUpdateModel*)updateSectionHeaderModel:(id)headerModel
                                  forSectionIndex:(NSInteger)sectionIndex;

/**
 Convention method for tables to register footer model
 You need to update footerKind property on storageModel before any updates
 
 @param headerModel  viewModel for footer
 @param sectionIndex section index in UITableView
 
 @return ANStorageUpdateModel* generated update
 */

- (ANStorageUpdateModel*)updateSectionFooterModel:(id)footerModel
                                  forSectionIndex:(NSUInteger)sectionIndex;

/**
 Returns supplemetary model for specified section and with specified kind

 @param kind         for model
 @param sectionIndex for section to return

 @return viewModel with specified kind
 */
- (id)supplementaryModelOfKind:(NSString*)kind
               forSectionIndex:(NSUInteger)sectionIndex;

@end
