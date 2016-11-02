//
//  ANCollectionController.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionController.h"
#import "ANListControllerUpdateViewInterface.h"
#import <Alister/ANStorage.h>
#import "ANCollectionControllerManager.h"
#import "ANListControllerSearchManager.h"
#import "ANListControllerWrapperInterface.h"
#import "ANListControllerCollectionViewWrapper.h"
#import "ANListController+Interitance.h"
#import "ANListControllerUpdateViewInterface.h"
#import <Alister/ANStorage.h>
#import "ANListControllerItemsHandler.h"
#import "ANListControllerConfigurationModel.h"
#import "ANListControllerQueueProcessor.h"
#import "ANCollectionControllerUpdateOperation.h"
#import "ANListControllerMappingService.h"

@class ANListControllerTableViewWrapper;
@class ANListControllerCollectionViewWrapper;

@interface ANCollectionController () <ANCollectionControllerManagerDelegate, ANListControllerCollectionViewWrapperDelegate,
ANListControllerItemsHandlerDelegate,
ANListControllerQueueProcessorDelegate
>

@property (nonatomic, strong) id<ANListControllerWrapperInterface> listViewWrapper;

@property (nonatomic, strong) ANListControllerItemsHandler* itemsHandler;
@property (nonatomic, strong) ANListControllerQueueProcessor* updateProcessor;
@property (nonatomic, strong) ANListControllerConfigurationModel* configurationModel;

@end

@implementation ANCollectionController

+ (instancetype)controllerWithCollectionView:(UICollectionView*)collectionView
{
    return [[self alloc] initWithCollectionView:collectionView];
}

- (instancetype)initWithCollectionView:(UICollectionView*)collectionView
{
    self = [super init];
    if (self)
    {
        self.collectionView = collectionView;
        self.listViewWrapper = [ANListControllerCollectionViewWrapper wrapperWithDelegate:self];
        
        ANCollectionControllerManager* manager = [ANCollectionControllerManager new];
        manager.delegate = self;
        
        manager.configurationModel.reloadAnimationKey = @"UICollectionViewReloadDataAnimationKey";
        
        self.manager = manager;
        
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
    return (UIView<ANListViewInterface>*)[self collectionView];
}

//- (void)allUpdatesFinished
//{
//    [self.delegate allUpdatesWereFinished];
//}
//
//- (id<ANListControllerWrapperInterface>)listViewWrapper
//{
//    return [self.delegate listViewWrapper];
//}

- (void)setupHeaderFooterDefaultKindOnStorage:(ANStorage*)storage
{
    [storage updateHeaderKind:UICollectionElementKindSectionHeader footerKind:UICollectionElementKindSectionFooter];
}

- (ANCollectionControllerManager*)collectionManager
{
    return self.manager;
}

- (void)setCollectionView:(UICollectionView*  _Nullable)collectionView
{
    collectionView.delegate = self;
    collectionView.dataSource = self;
    _collectionView = collectionView;
}

- (void)dealloc
{
    UICollectionView* collectionView = self.collectionView;
    collectionView.delegate = nil;
    collectionView.dataSource = nil;
}


#pragma mark - Supplementaries

- (UICollectionReusableView*)collectionView:(__unused UICollectionView*)collectionView
          viewForSupplementaryElementOfKind:(NSString*)kind
                                atIndexPath:(NSIndexPath*)indexPath
{
    return [self _supplementaryViewForIndexPath:indexPath kind:kind];
}

- (CGSize)collectionView:(__unused UICollectionView*)collectionView
                  layout:(UICollectionViewFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)sectionIndex
{
    return [self _referenceSizeForHeaderInSection:(NSUInteger)sectionIndex
                                                        withLayout:collectionViewLayout];
}

- (CGSize)collectionView:(__unused UICollectionView*)collectionView
                  layout:(UICollectionViewFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)sectionIndex
{
    return [self _referenceSizeForFooterInSection:(NSUInteger)sectionIndex
                                                        withLayout:collectionViewLayout];
}


#pragma mark - UICollectionView datasource

- (NSInteger)numberOfSectionsInCollectionView:(__unused UICollectionView*)collectionView
{
    return (NSInteger)[self.currentStorage sections].count;
}

- (NSInteger)collectionView:(__unused UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)sectionIndex
{
    id <ANStorageSectionModelInterface> sectionModel = [self.currentStorage sectionAtIndex:(NSUInteger)sectionIndex];
    return (NSInteger)[sectionModel numberOfObjects];
}

- (UICollectionViewCell*)collectionView:(__unused UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    id model = [self.currentStorage objectAtIndexPath:indexPath];
    return [self _cellForModel:model atIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.selectionBlock)
    {
        id model = [self.currentStorage objectAtIndexPath:indexPath];
        self.selectionBlock(model, indexPath);
    }
}


#pragma mark - Private

#pragma mark - Retriving

- (UICollectionViewCell*)_cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath
{
    return (UICollectionViewCell*)[self.itemsHandler cellForModel:model atIndexPath:indexPath];
}

- (UICollectionReusableView*)_supplementaryViewForIndexPath:(NSIndexPath*)indexPath kind:(NSString*)kind
{
    id model = [self.currentStorage supplementaryModelOfKind:kind forSectionIndex:(NSUInteger)indexPath.section];
    if (model)
    {
        return (UICollectionReusableView*)[self.itemsHandler supplementaryViewForModel:model
                                                                                  kind:kind
                                                                          forIndexPath:indexPath];
    }
    return nil;
}

- (CGSize)_referenceSizeForHeaderInSection:(NSUInteger)sectionIndex withLayout:(UICollectionViewFlowLayout*)layout
{
    BOOL isExist = [self _isExistMappingForSection:sectionIndex kind:self.currentStorage.headerSupplementaryKind];
    return isExist ? layout.headerReferenceSize : CGSizeZero;
}

- (CGSize)_referenceSizeForFooterInSection:(NSUInteger)sectionIndex withLayout:(UICollectionViewFlowLayout*)layout
{
    BOOL isExist = [self _isExistMappingForSection:sectionIndex kind:self.currentStorage.footerSupplementaryKind];
    return isExist ? layout.footerReferenceSize : CGSizeZero;
}

- (BOOL)_isExistMappingForSection:(NSUInteger)section kind:(NSString*)kind
{
    id model = [self.currentStorage supplementaryModelOfKind:kind forSectionIndex:section];
    return (model != nil);
}


@end
