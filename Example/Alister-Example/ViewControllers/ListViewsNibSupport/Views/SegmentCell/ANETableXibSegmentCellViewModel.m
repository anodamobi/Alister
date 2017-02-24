//
//  ANETableXibSegmentCellViewModel.m
//  Alister-Example
//
//  Created by ANODA on 2/15/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

#import "ANETableXibSegmentCellViewModel.h"

@interface ANETableXibSegmentCellViewModel ()

@property (nonatomic, assign) ANESegmentState type;

@end

@implementation ANETableXibSegmentCellViewModel

- (void)updateWithSegmentState:(ANESegmentState)type
{
    self.type = type;
}

- (void)segmentStateChanged:(ANESegmentState)type
{
    [self updateWithSegmentState:type];
    [self.delegate segmentModel:self segmentStateChangedTo:type];
}

@end
