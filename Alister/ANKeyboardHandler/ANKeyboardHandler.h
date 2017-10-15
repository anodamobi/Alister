//
//  ANKeyboardHandler.h
//
//  Created by Oksana Kovalchuk on 17/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

typedef void(^ANKeyboardAnimationBlock)(CGFloat keyboardHeightDelta);
typedef void(^ANKeyboardStateBlock)(BOOL isVisible);

@protocol ANKeyboardHandlerDelegate <NSObject>

@optional

- (void)keyboardWillUpdateStateTo:(BOOL)isVisible withNotification:(NSNotification*_Nonnull)notification;

@end

@interface ANKeyboardHandler : NSObject

@property (nonatomic, assign, getter=isEnabled) BOOL enabled;
@property (nonatomic, weak, nullable) id<ANKeyboardHandlerDelegate> delegate;
@property (nonatomic, copy, nullable) ANKeyboardAnimationBlock animationBlock;
@property (nonatomic, copy, nullable) ANKeyboardStateBlock animationCompletion;

+ (instancetype _Nonnull )handlerWithTarget:(UIScrollView*_Nonnull)target;

- (void)hideKeyboard;

@end
