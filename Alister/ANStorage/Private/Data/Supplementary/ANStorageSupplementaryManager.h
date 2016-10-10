//
//  ANStorageSupplementaryManager.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageModel;
@class ANStorageUpdateModel;

@interface ANStorageSupplementaryManager : NSObject

/**
 Convention method for tables to register header model. 
 You need to update headerKind property on storageModel before any updates
 
 @param headerModel  viewModel for header
 @param sectionIndex section index in UITableView
 @param storage      current storage model
 
 @return ANStorageUpdateModel* generated update
 */

+ (ANStorageUpdateModel*)updateSectionHeaderModel:(id)headerModel
                                  forSectionIndex:(NSInteger)sectionIndex
                                        inStorage:(ANStorageModel*)storage;

/**
 Convention method for tables to register footer model
 You need to update footerKind property on storageModel before any updates
 
 @param headerModel  viewModel for footer
 @param sectionIndex section index in UITableView
 @param storage      current storage model
 
 @return ANStorageUpdateModel* generated update
 */

+ (ANStorageUpdateModel*)updateSectionFooterModel:(id)footerModel
                                  forSectionIndex:(NSUInteger)sectionIndex
                                        inStorage:(ANStorageModel*)storage;

+ (id)supplementaryModelOfKind:(NSString*)kind
               forSectionIndex:(NSUInteger)sectionNumber
                     inStorage:(ANStorageModel*)storage;

@end
