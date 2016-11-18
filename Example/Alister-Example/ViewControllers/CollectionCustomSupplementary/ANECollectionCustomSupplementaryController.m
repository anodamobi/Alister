//
//  ANECollectionCustomSupplementaryController.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionCustomSupplementaryController.h"
#import "ANECollectionViewCell.h"
#import "ANECollectionHeaderView.h"
#import "ANECollectionFooterView.h"
#import "ANECollectionFooterViewModel.h"

@implementation ANECollectionCustomSupplementaryController

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super initWithCollectionView:collectionView];
    if (self)
    {
        [self configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            
            [configurator registerCellClass:[ANECollectionViewCell class]
                              forModelClass:[NSString class]];
            
//            [configurator registerSupplementaryClass:[ANECollectionHeaderView class]
//                                       forModelClass:[NSString class]
//                                                kind:UICollectionElementKindSectionHeader];
            
            [configurator registerSupplementaryClass:[ANECollectionFooterView class]
                                       forModelClass:[ANECollectionFooterViewModel class]
                                                kind:UICollectionElementKindSectionFooter];
        }];
    }
    
    return self;
}

- (void)updateWithStorage:(ANStorage*)storage
{
    [self attachStorage:storage];
}

@end
