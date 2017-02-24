//
//  ANETableXibSwitchCellViewModel.m
//  Alister-Example
//
//  Created by ANODA on 2/15/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

#import "ANETableXibSwitchCellViewModel.h"

@interface ANETableXibSwitchCellViewModel ()

@property (nonatomic, assign) ANESegmentState type;

@end

@implementation ANETableXibSwitchCellViewModel

- (void)updateWithSegmentState:(ANESegmentState)type
{
    self.type = type;
}

- (void)switchStateChangedTo:(ANESegmentState)type
{
    [self updateWithSegmentState:type];
    [self.delegate switchModel:self switchStateChangeTo:type];
}

@end
