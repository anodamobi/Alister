//
//  ANStorageSupplementaryManager.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageSupplementaryManager.h"
#import "ANStorageUpdateModel.h"
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageSectionModel.h>
#import "ANStorageUpdater.h"
#import "ANStorageLoader.h"

@implementation ANStorageSupplementaryManager

+ (ANStorageUpdateModel*)updateSectionHeaderModel:(id)headerModel
                                  forSectionIndex:(NSInteger)sectionIndex
                                        inStorage:(ANStorageModel*)storage
{
    NSAssert(storage.headerKind, @"you need to register header model before");
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if ((sectionIndex != NSNotFound) && (sectionIndex >= 0))
    {
        NSIndexSet* set = [ANStorageUpdater createSectionIfNotExist:sectionIndex inStorage:storage];
        [update addInsertedSectionIndexes:set];
        //    if (!set.count) // if no insert we need to reload section
        //    {
        //        [update addUpdatedSectionIndex:sectionIndex];
        //    }
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
        [section updateSupplementaryModel:headerModel forKind:storage.headerKind];
    }
    return update;
}

+ (ANStorageUpdateModel*)updateSectionFooterModel:(id)footerModel
                                  forSectionIndex:(NSInteger)sectionIndex
                                        inStorage:(ANStorageModel*)storage
{
    NSAssert(storage.footerKind, @"you need to register footer model before");
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    
    if ((sectionIndex != NSNotFound) && (sectionIndex >= 0))
    {
        NSIndexSet* set = [ANStorageUpdater createSectionIfNotExist:sectionIndex inStorage:storage];
        [update addInsertedSectionIndexes:set];
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
        [section updateSupplementaryModel:footerModel forKind:storage.footerKind];
    }
    return update;
}

+ (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionIndex inStorage:(ANStorageModel*)storage
{
    ANStorageSectionModel* sectionModel = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
    return [sectionModel supplementaryModelOfKind:kind];
}

@end
