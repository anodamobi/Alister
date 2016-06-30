//
//  ANCollectionControllerReloadOperation.m
//  ANODA
//
//  Created by Oksana Kovalchuk on 3/4/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionControllerReloadOperation.h"
#import "ANListControllerConfigurationModel.h"

@interface ANCollectionControllerReloadOperation ()

@property (nonatomic, assign) BOOL isAnimated;

@end

@implementation ANCollectionControllerReloadOperation

+ (instancetype)reloadOperationWithAnimation:(BOOL)shouldAnimate
{
    ANCollectionControllerReloadOperation* op = [self new];
    op.isAnimated = shouldAnimate;
    return op;
}


#pragma mark - Override

- (void)main
{
    if (!self.isCancelled)
    {
        [[self.delegate collectionView] reloadData];
        if (self.isAnimated)
        {
            CATransition* animation = [CATransition animation];
            [animation setType:kCATransitionFromBottom];
            [animation setSubtype:kCATransitionFromBottom];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [animation setFillMode:kCAFillModeBoth];
            [animation setDuration:[self.delegate configurationModel].reloadAnimationDuration];
            [self.delegate.collectionView.layer addAnimation:animation forKey:[self.delegate configurationModel].reloadAnimationKey];
        }
    }
}

@end
