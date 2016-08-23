//
//  ANTestableTouch.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/23/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableTouch.h"


@interface ANTestableTouch ()

@property (nonatomic, strong) UIView* currentView;

@end

@implementation ANTestableTouch

+ (instancetype)touchWithView:(UIView*)view
{
    ANTestableTouch* touch = [self new];
    touch.currentView = view;
    return touch;
}

- (UIView *)view
{
    return self.currentView;
}

@end
