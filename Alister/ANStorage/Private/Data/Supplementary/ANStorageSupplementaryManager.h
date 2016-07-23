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

+ (ANStorageUpdateModel*)updateSectionHeaderModel:(id)headerModel
                                  forSectionIndex:(NSUInteger)sectionIndex
                                        inStorage:(ANStorageModel*)storage
                                             kind:(NSString*)kind;

+ (ANStorageUpdateModel*)updateSectionFooterModel:(id)footerModel
                               forSectionIndex:(NSUInteger)sectionIndex
                                     inStorage:(ANStorageModel*)storage
                                             kind:(NSString*)kind;

+ (id)supplementaryModelOfKind:(NSString*)kind
               forSectionIndex:(NSUInteger)sectionNumber
                     inStorage:(ANStorageModel*)storage;

@end
