//
//  ANCollectionController.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionController.h"
#import "ANListControllerUpdateViewInterface.h"
#import "ANStorage.h"
#import "ANCollectionControllerManager.h"
#import "ANListControllerSearchManager.h"
#import "ANListControllerWrapperInterface.h"
#import "ANListControllerCollectionViewWrapper.h"
#import "ANListController+Interitance.h"

@class ANListControllerTableViewWrapper;
@class ANListControllerCollectionViewWrapper;

@interface ANCollectionController () <ANCollectionControllerManagerDelegate, ANListControllerCollectionViewWrapperDelegate>

@property (nonatomic, strong) id<ANListControllerWrapperInterface> listViewWrapper;

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
        
        manager.configurationModel.defaultFooterSupplementary = UICollectionElementKindSectionFooter;
        manager.configurationModel.defaultHeaderSupplementary = UICollectionElementKindSectionHeader;
        manager.configurationModel.reloadAnimationKey = @"UICollectionViewReloadDataAnimationKey";
        
        self.manager = manager;
    }
    return self;
}

- (void)resetStorage
{
    self.storage = [ANStorage new];
}

- (ANCollectionControllerManager*)collectionManager
{
    return self.manager;
}

- (void)setCollectionView:(UICollectionView * _Nullable)collectionView
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

- (UICollectionReusableView*)collectionView:(UICollectionView*)collectionView
          viewForSupplementaryElementOfKind:(NSString*)kind
                                atIndexPath:(NSIndexPath*)indexPath
{
    return [self.collectionManager supplementaryViewForIndexPath:indexPath kind:kind];
}

- (CGSize)collectionView:(UICollectionView*)collectionView
                  layout:(UICollectionViewFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)sectionNumber
{
    return [self.collectionManager referenceSizeForHeaderInSection:(NSUInteger)sectionNumber
                                                        withLayout:collectionViewLayout];
}

- (CGSize)collectionView:(UICollectionView*)collectionView
                  layout:(UICollectionViewFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)sectionNumber
{
    return [self.collectionManager referenceSizeForFooterInSection:(NSUInteger)sectionNumber
                                                        withLayout:collectionViewLayout];
}


#pragma mark - UICollectionView datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return (NSInteger)[self.currentStorage sections].count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectionNumber
{
    id <ANStorageSectionModelInterface> sectionModel = [self.currentStorage sectionAtIndex:(NSUInteger)sectionNumber];
    return (NSInteger)[sectionModel numberOfObjects];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self.currentStorage objectAtIndexPath:indexPath];;
    return [self.collectionManager cellForModel:model atIndexPath:indexPath];
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

@end
