//
//  ANListControllerReloadOperation.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerReloadOperation.h"
#import "ANListViewInterface.h"
#import "ANListControllerUpdateServiceInterface.h"

@implementation ANListControllerReloadOperation

#pragma mark - Override

- (void)main
{
    if (!self.isCancelled)
    {
        id<ANListControllerUpdateServiceInterface> delegate = self.delegate;
        [delegate.listView reloadData];
        if (self.shouldAnimate)
        {
            CATransition* animation = [CATransition animation];
            animation.type = kCATransitionFromBottom;
            animation.subtype = kCATransitionFromBottom;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.fillMode = kCAFillModeBoth;
            animation.duration = delegate.listView.reloadAnimationDuration;
            [delegate.listView.view.layer addAnimation:animation forKey:[delegate listView].animationKey];
        }
    }
}

@end
