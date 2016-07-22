//
//  ANListControllerCollectionViewWrapper.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerCollectionViewWrapper.h"

@interface ANListControllerCollectionViewWrapper ()

@end

@implementation ANListControllerCollectionViewWrapper

+ (instancetype)wrapperWithDelegate:(id<ANListControllerCollectionViewWrapperDelegate>)delegate
{
    ANListControllerCollectionViewWrapper* wrapper = [self new];
    wrapper.delegate = delegate;
    return wrapper;
}

- (UIScrollView*)view
{
    return [self.delegate collectionView];
}

- (void)registerSupplementaryClass:(Class)supplementaryClass
                   reuseIdentifier:(NSString*)reuseIdentifier
                              kind:(NSString*)kind
{
    NSAssert(kind, @"You must specify supplementary kind");
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(supplementaryClass, @"You must specify supplementary class");
    
    NSParameterAssert([supplementaryClass isSubclassOfClass:[UICollectionReusableView class]]);
    
    [self.delegate.collectionView registerClass:supplementaryClass
            forSupplementaryViewOfKind:kind
                   withReuseIdentifier:reuseIdentifier];
}

- (void)registerCellClass:(Class)cellClass forReuseIdentifier:(NSString*)identifier
{
    NSAssert(cellClass, @"You must specify cell class");
    NSAssert(identifier, @"You must specify reuse identifier");
    
    [self.delegate.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (id<ANListControllerUpdateViewInterface>)cellForReuseIdentifier:(NSString*)reuseIdentifier atIndexPath:(NSIndexPath*)indexPath
{
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(indexPath, @"You must specify reuse indexPath");
    
    return [self.delegate.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForReuseIdentifer:(NSString*)reuseIdentifier
                                                     kind:(NSString*)kind
                                              atIndexPath:(NSIndexPath*)indexPath
{
    NSAssert(kind, @"You must specify kind");
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(indexPath, @"You must specify reuse indexPath");
    
    return [self.delegate.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                   withReuseIdentifier:reuseIdentifier
                                                          forIndexPath:indexPath];
}

@end
