//
//  ANKeyboardHandler.h
//
//  Created by Oksana Kovalchuk on 17/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

//#import "ANHelperFunctions.h"

typedef void(^ANKeyboardAnimationBlock)(CGFloat keyboardHeightDelta);
typedef void(^ANKeyboardStateBlock)(BOOL isVisible);

@protocol ANKeyboardHandlerDelegate <NSObject>

@optional

- (void)keyboardWillUpdateToVisible:(BOOL)isVisible withNotification:(NSNotification*)notification;

@end

@interface ANKeyboardHandler : NSObject

@property (nonatomic, assign, getter=isEnabled) BOOL enabled;
@property (nonatomic, weak) id<ANKeyboardHandlerDelegate> delegate;
@property (nonatomic, copy) ANKeyboardAnimationBlock animationBlock;
@property (nonatomic, copy) ANKeyboardStateBlock animationCompletion;

+ (instancetype)handlerWithTarget:(UIScrollView*)target;

- (void)hideKeyboard;

@end
