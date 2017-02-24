//
//  ADActionTimeoutValidator.h
//  ANODA
//
//  Created by ANODA on 3/18/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

typedef void (^ANCodeBlock)(void);

@interface ANActionTimeOutValidator : NSObject

/**
 *  custom init with delay.
 *
 *  @param delay delay in seconds
 *
 *  @return ADActionTimeoutValidator instance
 */
- (instancetype)initWithTimeoutDelay:(CGFloat)delay;

/**
 *  check is action enabled.
 *
 *  @return return bool value, that meaning is time delay expired or not.
 */

- (BOOL)isActionEnabled;


/**
 *  reset current time delay
 */
- (void)reset;

/**
 *  required method for user timeout validator
 *
 *  @param delay      delay in seconds
 *  @param completion block that execute when action enabled
 *  @param skipBlock  block that execute when action disabled, time delay has not expired
 */
- (void)handleTimeoutWithDelayInSeconds:(CGFloat)delay
                             completion:(ANCodeBlock)completion
                              skipBlock:(ANCodeBlock)skipBlock;

@end
