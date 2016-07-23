//
//  ANKeyboardHandler.m
//
//  Created by Oksana Kovalchuk on 17/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANKeyboardHandler.h"

@interface ANKeyboardHandler () <UIGestureRecognizerDelegate>
{
    struct {
        BOOL shouldNotifityKeyboardState : YES;
    } _delegateExistingMethods;
}
@property (nonatomic, weak) UIScrollView* target;
@property (nonatomic, strong) UITapGestureRecognizer* tapRecognizer;
@property (nonatomic, assign) BOOL isKeyboardVisible; //sometimes IOS send unbalanced show/hide notifications
@property (nonatomic, assign) UIEdgeInsets defaultContentInsets;

@end

@implementation ANKeyboardHandler

+ (instancetype)handlerWithTarget:(id)target
{
    return [[self alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(UIScrollView*)scrollView
{
    self = [super init];
    if (self)
    {
        NSAssert([scrollView isKindOfClass:[UIScrollView class]],
                 @"You can't handle keyboard on class %@\n It must me UIScrollView subclass", NSStringFromClass([scrollView class]));
        
        self.target = scrollView;
        [self setupKeyboard];
        self.enabled = YES;
    }
    return self;
}

- (void)setDelegate:(id<ANKeyboardHandlerDelegate>)delegate
{
    _delegate = delegate;
    BOOL shouldNotify = ([delegate respondsToSelector:@selector(keyboardWillUpdateToVisible:withNotification:)]);
    _delegateExistingMethods.shouldNotifityKeyboardState = shouldNotify;
}

- (void)setupKeyboard
{
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    self.tapRecognizer.delegate = self;
    UIScrollView* target = self.target;
    [target addGestureRecognizer:self.tapRecognizer];
    self.tapRecognizer.cancelsTouchesInView = NO;
    self.defaultContentInsets = target.contentInset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)dealloc
{
    [self.target removeGestureRecognizer:self.tapRecognizer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    if (!self.isKeyboardVisible)
    {
        self.isKeyboardVisible = YES;
        [self handleKeyboardWithNotification:aNotification];
    }
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    if (self.isKeyboardVisible)
    {
        self.isKeyboardVisible = NO;
        [self handleKeyboardWithNotification:aNotification];
    }
}

- (UIView*)findViewThatIsFirstResponderInParent:(UIView*)parent
{
    if (parent.isFirstResponder)
    {
        return parent;
    }
    
    for (UIView *subView in parent.subviews)
    {
        UIView *firstResponder = [self findViewThatIsFirstResponderInParent:subView];
        if (firstResponder != nil)
        {
            return firstResponder;
        }
    }
    
    return nil;
}

- (void)handleKeyboardWithNotification:(NSNotification*)aNotification
{
    NSDictionary* info = aNotification.userInfo;
    CGFloat kbHeight = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    UIView* responder = [self findViewThatIsFirstResponderInParent:self.target];
    
    UIEdgeInsets contentInsets = [self _updatedInsetsWithKeyboardHeight:kbHeight];
    
    void (^animationBlock)(void) = ^{
        
        [self _dispatchBlockToMain:^{
            if (self.isEnabled)
            {
                UIScrollView* target = self.target;
                target.contentInset = contentInsets;
                target.scrollIndicatorInsets = contentInsets;
                if (responder)
                {
                    CGRect visibleRect = [target convertRect:responder.frame fromView:responder.superview];
                    [target scrollRectToVisible:visibleRect animated:NO];
                }
            }
            if (self.animationBlock)
            {
                self.animationBlock(kbHeight);
            }
        }];
    };
    
    [UIView animateWithDuration:duration animations:animationBlock completion:^(__unused BOOL finished) {
        if (self.animationCompletion)
        {
            self.animationCompletion(self.isKeyboardVisible);
        }
    }];
}

- (void)hideKeyboard
{
    [self.target endEditing:YES];
}

- (UIEdgeInsets)_updatedInsetsWithKeyboardHeight:(CGFloat)keyboardHeight
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (self.isKeyboardVisible)
    {
        UIScrollView* target = self.target;
        insets = UIEdgeInsetsMake(target.contentInset.top,
                                  0.0,
                                  target.contentInset.bottom + keyboardHeight,
                                  0.0);
    }
    else
    {
        insets = self.defaultContentInsets;
    }
    return insets;
}

#pragma mark - UIGesture delegate

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    if ([touch.view isKindOfClass:[UIControl class]])
    {
        [self hideKeyboard];
        return NO;
    }
    return YES;
}

- (void)_dispatchBlockToMain:(void(^)(void))block
{
    if (block)
    {
        if ([NSThread isMainThread])
        {
            block();
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    }
}

@end
