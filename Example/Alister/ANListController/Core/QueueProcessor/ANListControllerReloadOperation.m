//
//  ANListControllerReloadOperation.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerReloadOperation.h"
#import "ANListControllerConfigurationModel.h"
#import "ANListViewInterface.h"

@implementation ANListControllerReloadOperation

#pragma mark - Override

- (void)main
{
    if (!self.isCancelled)
    {
        id<ANListControllerReloadOperationDelegate> delegate = self.delegate;
        if ([delegate.listView conformsToProtocol:@protocol(ANListViewInterface)])
        {
            [delegate.listView reloadData];
            if (self.shouldAnimate)
            {
                CATransition* animation = [CATransition animation];
                animation.type = kCATransitionFromBottom;
                animation.subtype = kCATransitionFromBottom;
                animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                animation.fillMode = kCAFillModeBoth;
                animation.duration = [delegate configurationModel].reloadAnimationDuration;
                [delegate.listView.layer addAnimation:animation forKey:[delegate configurationModel].reloadAnimationKey];
            }
        }
    }
}

@end
