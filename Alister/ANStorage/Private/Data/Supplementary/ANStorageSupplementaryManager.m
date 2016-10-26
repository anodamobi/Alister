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

@property (nonatomic, strong) ANStorageUpdater* updater;
@property (nonatomic, weak) ANStorageModel* storageModel;
@property (nonatomic, weak) id<ANStorageUpdateOperationInterface> updateDelegate;

@end

@implementation ANStorageSupplementaryManager

+ (instancetype)supplementatyManagerWithStorageModel:(id)model updateDelegate:(id<ANStorageUpdateOperationInterface>)delegate
{
    ANStorageSupplementaryManager* mananger = [self new];
    mananger.updateDelegate = delegate;
    mananger.storageModel = model;
    
    mananger.updater = [ANStorageUpdater updaterWithStorageModel:model
                                                  updateDelegate:delegate];
    
    return mananger;
}

- (void)updateSectionHeaderModel:(id)headerModel forSectionIndex:(NSInteger)sectionIndex
{
    ANStorageUpdateModel* update = [self _updateSupplementaryOfKind:self.storageModel.headerKind
                                                              model:headerModel
                                                    forSectionIndex:sectionIndex];
    [self.updateDelegate collectUpdate:update];
}

- (void)updateSectionFooterModel:(id)footerModel forSectionIndex:(NSInteger)sectionIndex
{
    ANStorageUpdateModel* update = [self _updateSupplementaryOfKind:self.storageModel.footerKind
                                                              model:footerModel
                                                    forSectionIndex:sectionIndex];
    [self.updateDelegate collectUpdate:update];
}

#pragma mark - Private

//TODO: check is it need to be public for collectionView

- (ANStorageUpdateModel*)_updateSupplementaryOfKind:(NSString*)kind
                                              model:(id)model
                                    forSectionIndex:(NSUInteger)sectionIndex
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    
    if (ANIsIndexValid(sectionIndex) && self.storageModel)
    {
        ANStorageSectionModel* section = nil;
        
        if (model)
        {
            NSIndexSet* set = [self.updater createSectionIfNotExist:sectionIndex];
            [update addInsertedSectionIndexes:set];
            section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:self.storageModel];
        }
        else
        {   // if section not exist we don't need to remove it's model,
            // so no new sections will be created and update will be empty
            section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:self.storageModel];
        }
        [section updateSupplementaryModel:model forKind:kind];
    }
    
    return update;
}

- (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionIndex
{
    ANStorageSectionModel* sectionModel = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:self.storageModel];
    return [sectionModel supplementaryModelOfKind:kind];
}

@end
