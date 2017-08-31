//
//  ANECollectionViewController.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionViewController.h"
#import "ANECollectionViewCell.h"

@implementation ANECollectionViewController

- (instancetype)initWithCollectionView:(UICollectionView*)collectionView
{
    self = [super initWithCollectionView:collectionView];
    if (self)
    {
        [self configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            
            [configurator registerCellClass:[ANECollectionViewCell class]
                              forModelClass:[NSString class]];
        }];
    }
    
    return self;
}

@end
