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
#import "ANStorageValidator.h"

@interface ANStorageSupplementaryManager ()

@property (nonatomic, strong) ANStorageUpdater* updater; // TODO: init for it

@property (nonatomic, strong) ANStorageModel* storageModel;
@property (nonatomic, weak) id delegate;

@end

@implementation ANStorageSupplementaryManager

+ (instancetype)supplementatyManagerWithStorageModel:(id)model withDelegate:(id)delegate
{
    ANStorageSupplementaryManager* mananger = [self new];
    mananger.delegate = delegate;
    mananger.storageModel = model;
    
    return mananger;
}

- (ANStorageUpdateModel*)updateSectionHeaderModel:(id)headerModel
                                  forSectionIndex:(NSInteger)sectionIndex
                                        inStorage:(ANStorageModel*)storage
{
    return [self _updateSupplementaryOfKind:storage.headerKind
                                      model:headerModel
                            forSectionIndex:sectionIndex
                                  inStorage:storage];
}

- (ANStorageUpdateModel*)updateSectionFooterModel:(id)footerModel
                                  forSectionIndex:(NSInteger)sectionIndex
                                        inStorage:(ANStorageModel*)storage
{
    return [self _updateSupplementaryOfKind:storage.footerKind
                                      model:footerModel
                            forSectionIndex:sectionIndex
                                  inStorage:storage];
}

- (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionIndex inStorage:(ANStorageModel*)storage
{
    ANStorageSectionModel* sectionModel = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
    return [sectionModel supplementaryModelOfKind:kind];
}


#pragma mark - Private

//TODO: check is it need to be public for collectionView

- (ANStorageUpdateModel*)_updateSupplementaryOfKind:(NSString*)kind
                                              model:(id)model
                                    forSectionIndex:(NSUInteger)sectionIndex
                                          inStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    
    if (ANIsIndexValid(sectionIndex) && storage)
    {
        ANStorageSectionModel* section = nil;
        
        if (model)
        {
            NSIndexSet* set = [self.updater createSectionIfNotExist:sectionIndex];
            [update addInsertedSectionIndexes:set];
            section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
        }
        else
        {   // if section not exist we don't need to remove it's model,
            // so no new sections will be created and update will be empty
            section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
        }
        [section updateSupplementaryModel:model forKind:kind];
    }
    return update;

}

@end
