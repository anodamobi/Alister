//
//  ANCollectionControllerManager.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionControllerManager.h"
#import "ANListControllerUpdateViewInterface.h"
#import "ANStorage.h"
#import "ANCollectionControllerUpdater.h"
#import "ANListControllerItemsHandler.h"
#import "ANListControllerConfigurationModel.h"

@interface ANCollectionControllerManager () <ANListControllerItemsHandlerDelegate, ANCollectionControllerUpdaterDelegate>

@property (nonatomic, strong) ANListControllerItemsHandler* factory;
@property (nonatomic, strong) ANCollectionControllerUpdater* updateController;
@property (nonatomic, strong) ANListControllerConfigurationModel* configurationModel;

@end

@implementation ANCollectionControllerManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.factory = [ANListControllerItemsHandler handlerWithDelegate:self];
        
        self.updateController = [ANCollectionControllerUpdater new];
        self.updateController.delegate = self;
        
        self.configurationModel = [ANListControllerConfigurationModel defaultModel];
    }
    return self;
}

- (id<ANListControllerReusableInterface>)reusableViewsHandler
{
    return self.factory;
}

- (id<ANStorageUpdatingInterface>)updateHandler
{
    return self.updateController;
}

- (UICollectionView *)collectionView
{
    return [self.delegate collectionView];
}

- (id<ANListControllerWrapperInterface>)listViewWrapper
{
    return [self.delegate listViewWrapper];
}


#pragma mark - Retriving

- (UICollectionViewCell*)cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath
{
    return (UICollectionViewCell*)[self.factory cellForModel:model atIndexPath:indexPath];
}

- (UICollectionReusableView*)supplementaryViewForIndexPath:(NSIndexPath*)indexPath kind:(NSString*)kind
{
    id model = [self.delegate.currentStorage supplementaryModelOfKind:kind forSectionIndex:indexPath.section];
    if (model)
    {
        return (UICollectionReusableView*)[self.factory supplementaryViewForModel:model kind:kind forIndexPath:indexPath];
    }
    return nil;
}

- (CGSize)referenceSizeForHeaderInSection:(NSInteger)sectionNumber withLayout:(UICollectionViewFlowLayout*)layout
{
    BOOL isExist = [self _isExistMappingForSection:sectionNumber kind:self.configurationModel.defaultHeaderSupplementary];
    return isExist ? layout.headerReferenceSize : CGSizeZero;
}

- (CGSize)referenceSizeForFooterInSection:(NSInteger)sectionNumber withLayout:(UICollectionViewFlowLayout*)layout
{
    BOOL isExist = [self _isExistMappingForSection:sectionNumber kind:self.configurationModel.defaultFooterSupplementary];
    return isExist ? layout.footerReferenceSize : CGSizeZero;
}


#pragma mark - Private

- (BOOL)_isExistMappingForSection:(NSInteger)section kind:(NSString*)kind
{
    id model = [self.delegate.currentStorage supplementaryModelOfKind:kind forSectionIndex:section];
    return (model != nil);
}

@end
