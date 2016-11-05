//
//  ANCollectionController.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionController.h"
#import "ANListViewInterface.h"
#import "ANListCollectionView.h"
#import "ANListController+Interitance.h"

@implementation ANCollectionController

+ (instancetype)controllerWithCollectionView:(UICollectionView*)collectionView
{
    return [[self alloc] initWithCollectionView:collectionView];
}

- (instancetype)initWithCollectionView:(UICollectionView*)collectionView
{
    ANListCollectionView* listView = [ANListCollectionView wrapperWithCollectionView:collectionView];
    self = [super initWithListView:listView];
    if (self)
    {
        
    }
    return self;
}

- (UICollectionView *)collectionView
{
    return (UICollectionView*)self.listView.view;
}

- (void)setupHeaderFooterDefaultKindOnStorage:(ANStorage*)storage
{
    [storage updateHeaderKind:UICollectionElementKindSectionHeader footerKind:UICollectionElementKindSectionFooter];
}


#pragma mark - Supplementary

- (UICollectionReusableView*)collectionView:(__unused UICollectionView*)collectionView
          viewForSupplementaryElementOfKind:(NSString*)kind
                                atIndexPath:(NSIndexPath*)indexPath
{
    UICollectionReusableView* view = nil;
    id model = [self.currentStorage supplementaryModelOfKind:kind forSectionIndex:indexPath.section];
    if (model)
    {
        view = (UICollectionReusableView*)[self.itemsHandler supplementaryViewForModel:model
                                                                                  kind:kind
                                                                          forIndexPath:indexPath];
    }
    return view;
}

- (CGSize)collectionView:(__unused UICollectionView*)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)sectionIndex
{
    BOOL isExist = [self _isExistMappingForSection:sectionIndex
                                              kind:self.currentStorage.headerSupplementaryKind];
    
    return isExist ? ((UICollectionViewFlowLayout*)collectionViewLayout).headerReferenceSize : CGSizeZero;
}

- (CGSize)collectionView:(__unused UICollectionView*)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)sectionIndex
{
    BOOL isExist = [self _isExistMappingForSection:sectionIndex
                                              kind:self.currentStorage.footerSupplementaryKind];
    
    return isExist ? ((UICollectionViewFlowLayout*)collectionViewLayout).footerReferenceSize : CGSizeZero;
}


#pragma mark - UICollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(__unused UICollectionView*)collectionView
{
    return (NSInteger)[self.currentStorage sections].count;
}

- (NSInteger)collectionView:(__unused UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)sectionIndex
{
    id <ANStorageSectionModelInterface> sectionModel = [self.currentStorage sectionAtIndex:sectionIndex];
    return [sectionModel numberOfObjects];
}

- (UICollectionViewCell*)collectionView:(__unused UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    id model = [self.currentStorage objectAtIndexPath:indexPath];
    return (UICollectionViewCell*)[self.itemsHandler cellForModel:model atIndexPath:indexPath];
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

- (BOOL)_isExistMappingForSection:(NSInteger)section kind:(NSString*)kind
{
    id model = [self.currentStorage supplementaryModelOfKind:kind forSectionIndex:section];
    return (model != nil);
}

@end
