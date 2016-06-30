//
//  ANCollectionController.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListController.h"

@interface ANCollectionController : ANListController
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic, weak, readonly) UICollectionView* collectionView;

#pragma mark - View's related

+ (instancetype)controllerWithCollectionView:(UICollectionView*)collectionView;

- (instancetype)initWithCollectionView:(UICollectionView*)collectionView;

- (void)resetStorage;

@end
