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
    
    NSArray* firstSection = [ANEDataGenerator generateStringsArrayWithCapacity:3];
    NSArray* secondSection = [ANEDataGenerator generateStringsArrayWithCapacity:4];
    NSArray* thirdSection = [ANEDataGenerator generateStringsArrayWithCapacity:6];

    NSString* headerTitle = NSLocalizedString(@"header.title-label.text", nil);
    NSString* footerTitle = NSLocalizedString(@"footer.title-label.text", nil);
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItems:firstSection toSection:0];
        [storageController updateSectionHeaderModel:headerTitle forSectionIndex:0];
        [storageController updateSectionFooterModel:footerTitle forSectionIndex:0];
        
        [storageController addItems:secondSection toSection:1];
        [storageController updateSectionHeaderModel:headerTitle forSectionIndex:1];
        [storageController updateSectionFooterModel:footerTitle forSectionIndex:1];
        
        [storageController addItems:thirdSection toSection:2];
        [storageController updateSectionHeaderModel:headerTitle forSectionIndex:2];
        [storageController updateSectionFooterModel:footerTitle forSectionIndex:2];
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
    layout.headerReferenceSize = CGSizeMake(width, width);
    layout.footerReferenceSize = CGSizeMake(width, width);
    layout.itemSize = CGSizeMake(width, width);
    
    return layout;
}

@end
