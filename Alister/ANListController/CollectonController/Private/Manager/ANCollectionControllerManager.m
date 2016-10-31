//
//  ANCollectionControllerManager.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionControllerManager.h"
#import "ANListControllerUpdateViewInterface.h"
#import <Alister/ANStorage.h>
#import "ANListControllerItemsHandler.h"
#import "ANListControllerConfigurationModel.h"
#import "ANListControllerQueueProcessor.h"
#import "ANCollectionControllerUpdateOperation.h"
#import "ANListControllerMappingService.h"

@interface ANCollectionControllerManager ()
<
    ANListControllerItemsHandlerDelegate,
    ANListControllerQueueProcessorDelegate
>

@property (nonatomic, strong) ANListControllerItemsHandler* itemsHandler;
@property (nonatomic, strong) ANListControllerQueueProcessor* updateProcessor;
@property (nonatomic, strong) ANListControllerConfigurationModel* configurationModel;

@end

@implementation ANCollectionControllerManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.itemsHandler = [[ANListControllerItemsHandler alloc] initWithMappingService:[ANListControllerMappingService new]];
        self.itemsHandler.delegate = self;
        
        self.updateProcessor = [ANListControllerQueueProcessor new];
        self.updateProcessor.delegate = self;
        self.updateProcessor.updateOperationClass = [ANCollectionControllerUpdateOperation class];
        
        self.configurationModel = [ANListControllerConfigurationModel defaultModel];
    }
    return self;
}

- (id<ANListControllerReusableInterface>)reusableViewsHandler
{
    return self.itemsHandler;
}

- (id<ANStorageUpdatingInterface>)updateHandler
{
    return self.updateProcessor;
}

- (UIView<ANListViewInterface>*)listView
{
    return (UIView<ANListViewInterface>*)[self.delegate collectionView];
}

- (void)allUpdatesFinished
{
    [self.delegate allUpdatesWereFinished];
}

- (id<ANListControllerWrapperInterface>)listViewWrapper
{
    return [self.delegate listViewWrapper];
}


#pragma mark - Retriving

- (UICollectionViewCell*)cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath
{
    return (UICollectionViewCell*)[self.itemsHandler cellForModel:model atIndexPath:indexPath];
}

- (UICollectionReusableView*)supplementaryViewForIndexPath:(NSIndexPath*)indexPath kind:(NSString*)kind
{
    id model = [self.delegate.currentStorage supplementaryModelOfKind:kind forSectionIndex:(NSUInteger)indexPath.section];
    if (model)
    {
        return (UICollectionReusableView*)[self.itemsHandler supplementaryViewForModel:model
                                                                                  kind:kind
                                                                          forIndexPath:indexPath];
    }
    return nil;
}

- (CGSize)referenceSizeForHeaderInSection:(NSUInteger)sectionIndex withLayout:(UICollectionViewFlowLayout*)layout
{
    BOOL isExist = [self _isExistMappingForSection:sectionIndex kind:self.configurationModel.defaultHeaderSupplementary];
    return isExist ? layout.headerReferenceSize : CGSizeZero;
}

- (CGSize)referenceSizeForFooterInSection:(NSUInteger)sectionIndex withLayout:(UICollectionViewFlowLayout*)layout
{
    BOOL isExist = [self _isExistMappingForSection:sectionIndex kind:self.configurationModel.defaultFooterSupplementary];
    return isExist ? layout.footerReferenceSize : CGSizeZero;
}


#pragma mark - Private

- (BOOL)_isExistMappingForSection:(NSUInteger)section kind:(NSString*)kind
{
    id model = [self.delegate.currentStorage supplementaryModelOfKind:kind forSectionIndex:section];
    return (model != nil);
}

@end
