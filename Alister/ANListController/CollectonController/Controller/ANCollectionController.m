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
#import "ANConstants.h"

#ifdef USE_TIMEOUT_VALIDATOR
#import "ANActionTimeOutValidator.h"


@interface ANCollectionController ()

@property (nonatomic, strong) ANActionTimeOutValidator* timeOutValidator;

@end

#endif

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


#pragma mark - Supplementary

- (UICollectionReusableView*)collectionView:(__unused UICollectionView*)collectionView
          viewForSupplementaryElementOfKind:(NSString*)kind
                                atIndexPath:(NSIndexPath*)indexPath
{
    id model = [self.currentStorage supplementaryModelOfKind:kind forSectionIndex:indexPath.section];
    return (UICollectionReusableView*)[self.itemsHandler supplementaryViewForModel:model
                                                                              kind:kind
                                                                      forIndexPath:indexPath];
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
#ifdef USE_TIMEOUT_VALIDATOR
    [self.timeOutValidator handleTimeoutWithDelayInSeconds:ANListDefaultActionTimeOut completion:^{
        #endif
        if (self.selectionBlock)
        {
            id model = [self.currentStorage objectAtIndexPath:indexPath];
            self.selectionBlock(model, indexPath);
        }
 #ifdef USE_TIMEOUT_VALIDATOR
    } skipBlock:nil];
#endif
}


#pragma mark - Private

- (BOOL)_isExistMappingForSection:(NSInteger)section kind:(NSString*)kind
{
    id model = [self.currentStorage supplementaryModelOfKind:kind forSectionIndex:section];
    return (model != nil);
}

//- (NSString*)_handleStorageKind:(NSString*)existingKind
//{
//    if ([existingKind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//        existingKind = ANListDefaultHeaderKind;
//    }
//    else if ([existingKind isEqualToString:UICollectionElementKindSectionFooter])
//    {
//        existingKind = ANListDefaultFooterKind;
//    }
//    
//    return existingKind;
//}


#pragma mark - Lazy Load

#ifdef USE_TIMEOUT_VALIDATOR
- (ANActionTimeOutValidator*)timeOutValidator
{
    if (!_timeOutValidator)
    {
        _timeOutValidator = [[ANActionTimeOutValidator alloc] initWithTimeoutDelay:ANListDefaultActionTimeOut];
    }
    return _timeOutValidator;
}
#endif

@end
