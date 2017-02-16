//
//  ADActionTimeoutValidator.m
//  ANODA
//
//  Created by ANODA on 3/18/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANActionTimeOutValidator.h"

static CGFloat const kADActionTimeOutValidatorDefaultDelay = 1;

@interface ANActionTimeOutValidator ()

@property (nonatomic, assign) CGFloat delay;
@property (nonatomic, strong) NSDate *initialDate;
@property (nonatomic, assign) BOOL isFirstRequest;

@end

@implementation ANActionTimeOutValidator

- (instancetype)init
{
    return [self initWithTimeoutDelay:kADActionTimeOutValidatorDefaultDelay];
}

- (instancetype)initWithTimeoutDelay:(CGFloat)delay
{
    self = [super init];
    {
        self.delay = delay;
        self.initialDate = [NSDate date];
        self.isFirstRequest = YES;
    }
    return self;
}

- (BOOL)isActionEnabled
{
    NSTimeInterval timeInterval = [self.initialDate timeIntervalSinceDate:[NSDate date]];
    CGFloat value = fabs(timeInterval);
    BOOL isEnabled = (value > self.delay);
    if (isEnabled)
    {
        self.initialDate = [NSDate date];
    }
    return isEnabled;
}

- (void)reset
{
    self.initialDate = [[NSDate alloc] initWithTimeIntervalSince1970:1000];
}

- (void)handleTimeoutWithDelayInSeconds:(CGFloat)delay completion:(ANCodeBlock)completion skipBlock:(ANCodeBlock)skipBlock
{
    self.delay = delay;
    if (self.isFirstRequest)
    {
        self.initialDate = [NSDate date];
        self.isFirstRequest = NO;
        if (completion)
        {
            completion();
        }
    }
    else
    {
        if ([self isActionEnabled] && completion)
        {
            completion();
        }
        else if (skipBlock)
        {
            skipBlock();
        }
    }
}

@end
