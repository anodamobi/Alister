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

@end

@implementation ANTableControllerReloadOperation

#pragma mark - Override

- (void)main
{
    if (!self.isCancelled)
    {
        id<ANTableControllerReloadOperationDelegate> delegate = self.delegate;
        [delegate.tableView reloadData];
        if (self.shouldAnimate)
        {
            CATransition* animation = [CATransition animation];
            [animation setType:kCATransitionFromBottom];
            [animation setSubtype:kCATransitionFromBottom];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [animation setFillMode:kCAFillModeBoth];
            [animation setDuration:[delegate configurationModel].reloadAnimationDuration];
            [delegate.tableView.layer addAnimation:animation forKey:[delegate configurationModel].reloadAnimationKey];
        }
    }
}

@end
