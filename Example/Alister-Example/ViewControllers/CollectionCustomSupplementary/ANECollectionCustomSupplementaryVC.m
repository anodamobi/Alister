//
//  ANECollectionCustomSupplementary.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionCustomSupplementaryVC.h"
#import "ANECollectionCustomSupplementaryController.h"
#import "ANStorage.h"
#import "ANEDataGenerator.h"
#import "ANECollectionFooterViewModel.h"

@interface ANECollectionCustomSupplementaryVC ()

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANECollectionCustomSupplementaryController* controller;
@property (nonatomic, strong) UICollectionView* collectionView;

@end

@implementation ANECollectionCustomSupplementaryVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.storage = [ANStorage new];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:[self _collectionLayout]];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        self.controller = [[ANECollectionCustomSupplementaryController alloc]
                           initWithCollectionView:self.collectionView];
        
        [self.controller attachStorage:self.storage];
    }
    
    return self;
}

- (void)loadView
{
    self.view = self.collectionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray* items = [ANEDataGenerator generateStringsArrayWithCapacity:5];
    ANECollectionFooterViewModel* footerModel = [ANECollectionFooterViewModel new];
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItems:items];
        [storageController updateSectionFooterModel:footerModel forSectionIndex:0];
    }];
}


#pragma mark - Helper Methods

- (UICollectionViewFlowLayout*)_collectionLayout
{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) / 2;
    
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.headerReferenceSize = CGSizeMake(width, 1000);
    layout.footerReferenceSize = CGSizeMake(width, 1000);
    layout.itemSize = CGSizeMake(width, width);
    
    return layout;
}

@end
