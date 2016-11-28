//
//  ANECollectionViewVC.h
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@class ANECollectionViewController;
@class ANStorage;

@interface ANECollectionViewVC : UIViewController

@property (nonatomic, strong, readonly) UICollectionView* collectionView;
@property (nonatomic, strong, readonly) ANECollectionViewController* controller;
@property (nonatomic, strong, readonly) ANStorage* storage;

@end
