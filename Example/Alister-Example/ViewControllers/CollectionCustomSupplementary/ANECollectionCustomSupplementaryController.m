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
            
            [configurator registerFooterClass:[ANECollectionFooterView class]
                                forModelClass:[ANECollectionFooterViewModel class]];
        }];
    }
    
    return self;
}

@end
