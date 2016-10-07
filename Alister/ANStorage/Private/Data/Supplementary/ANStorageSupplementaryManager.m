//
//  ANStorageSupplementaryManager.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageSupplementaryManager.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"
#import "ANStorageUpdater.h"
#import "ANStorageLoader.h"

@implementation ANStorageSupplementaryManager

+ (ANStorageUpdateModel*)updateSectionHeaderModel:(id)headerModel
                                  forSectionIndex:(NSUInteger)sectionIndex
                                        inStorage:(ANStorageModel*)storage
                                             kind:(NSString*)kind
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    
    NSIndexSet* set = [ANStorageUpdater createSectionIfNotExist:sectionIndex inStorage:storage];
    [update addInsertedSectionIndexes:set];
//    if (!set.count) // if no insert we need to reload section
//    {
//        [update addUpdatedSectionIndex:sectionIndex];
//    }
    ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
    [section updateSupplementaryModel:headerModel forKind:kind];
    return update;
}

+ (ANStorageUpdateModel*)updateSectionFooterModel:(id)footerModel
                                  forSectionIndex:(NSUInteger)sectionIndex
                                        inStorage:(ANStorageModel*)storage
                                             kind:(NSString*)kind
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    
    NSIndexSet* set = [ANStorageUpdater createSectionIfNotExist:sectionIndex inStorage:storage];
    [update addInsertedSectionIndexes:set];
    ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
    [section updateSupplementaryModel:footerModel forKind:kind];
    return update;
}

+ (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionNumber inStorage:(ANStorageModel*)storage
{
    ANStorageSectionModel* sectionModel = [ANStorageLoader sectionAtIndex:sectionNumber inStorage:storage];
    return [sectionModel supplementaryModelOfKind:kind];
}

@end
