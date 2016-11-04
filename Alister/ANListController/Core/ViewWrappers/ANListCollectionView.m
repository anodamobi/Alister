//
//  ANListControllerCollectionViewWrapper.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListCollectionView.h"

@interface ANListCollectionView ()

@property (nonatomic, weak) UICollectionView* collectionView;

@end

@implementation ANListCollectionView

+ (instancetype)wrapperWithCollectionView:(UICollectionView *)collectionView
{
    ANListCollectionView* wrapper = [self new];
    wrapper.collectionView = collectionView;
    return wrapper;
}

- (UIScrollView*)view
{
    return self.collectionView;
}

- (NSString*)headerDefaultKind
{
    return UICollectionElementKindSectionHeader;
}

- (NSString*)footerDefaultKind
{
    return UICollectionElementKindSectionFooter;
}

- (CGFloat)reloadAnimationDuration
{
    return 0.25;
}

- (void)setDelegate:(id)delegate
{
    self.collectionView.delegate = delegate;
}

- (void)setDataSource:(id)dataSource
{
    self.collectionView.dataSource = dataSource;
}

- (NSString*)animationKey
{
    return @"UICollectionViewReloadDataAnimationKey";
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

- (void)registerSupplementaryClass:(Class)supplementaryClass
                   reuseIdentifier:(NSString*)reuseIdentifier
                              kind:(NSString*)kind
{
    NSAssert(kind, @"You must specify supplementary kind");
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(supplementaryClass, @"You must specify supplementary class");
    
    NSParameterAssert([supplementaryClass isSubclassOfClass:[UICollectionReusableView class]]);
    
    [self.collectionView registerClass:supplementaryClass
            forSupplementaryViewOfKind:kind
                   withReuseIdentifier:reuseIdentifier];
}

- (void)registerCellClass:(Class)cellClass forReuseIdentifier:(NSString*)identifier
{
    NSAssert(cellClass, @"You must specify cell class");
    NSAssert(identifier, @"You must specify reuse identifier");
    
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (id<ANListControllerUpdateViewInterface>)cellForReuseIdentifier:(NSString*)reuseIdentifier atIndexPath:(NSIndexPath*)indexPath
{
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(indexPath, @"You must specify reuse indexPath");
    
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForReuseIdentifer:(NSString*)reuseIdentifier
                                                                         kind:(NSString*)kind
                                                                  atIndexPath:(NSIndexPath*)indexPath
{
    NSAssert(kind, @"You must specify kind");
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(indexPath, @"You must specify reuse indexPath");
    
    return [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                   withReuseIdentifier:reuseIdentifier
                                                          forIndexPath:indexPath];
}

@end
