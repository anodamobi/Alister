//
//  ANTableControllerReloadOperation.m
//  PetrolApp
//
//  Created by Oksana Kovalchuk on 2/15/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANTableControllerReloadOperation.h"
#import "ANListControllerConfigurationModel.h"

@interface ANTableControllerReloadOperation ()

@property (nonatomic, assign) BOOL isAnimated;


@end

@implementation ANTableControllerReloadOperation

+ (instancetype)reloadOperationWithAnimation:(BOOL)shouldAnimate
{
    ANTableControllerReloadOperation* op = [self new];
    op.isAnimated = shouldAnimate;
    return op;
}


#pragma mark - Override

- (void)main
{
    if (!self.isCancelled)
    {
        [[self.delegate tableView] reloadData];
        if (self.isAnimated)
        {
            CATransition* animation = [CATransition animation];
            [animation setType:kCATransitionFromBottom];
            [animation setSubtype:kCATransitionFromBottom];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [animation setFillMode:kCAFillModeBoth];
            [animation setDuration:[self.delegate configurationModel].reloadAnimationDuration];
            [self.delegate.tableView.layer addAnimation:animation forKey:[self.delegate configurationModel].reloadAnimationKey];
        }
    }
}

@end
