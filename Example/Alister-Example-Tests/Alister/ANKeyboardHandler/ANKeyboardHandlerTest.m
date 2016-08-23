//
//  ANKeyboardHandlerTest.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/12/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "ANKeyboardHandler.h"
#import "ANTestKeyboardHandlerDelegate.h"
#import "ANTestableTextField.h"
#import "ANTestableTouch.h"

@interface ANKeyboardHandler ()

- (void)handleKeyboardWithNotification:(NSNotification*)aNotification;

- (CGFloat)_bottomOffsetWithScrollView:(UIScrollView*)scrollView
                     withResponderView:(UIView*)view
                       withVisibleArea:(CGFloat)viewAreaHeight;

- (void)_handleKeyboardAnimationWithDuration:(CGFloat)duration animatedBlock:(void(^)())animationBlock;

- (UIView*)findViewThatIsFirstResponderInParent:(UIView*)parent;

- (void)keyboardWillShow:(NSNotification*)aNotification;

- (void)keyboardWillHide:(NSNotification*)aNotification;

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch;

- (void)_dispatchBlockToMain:(void(^)(void))block;

- (void)hideKeyboard;

@property (nonatomic, strong) UITapGestureRecognizer* tapRecognizer;

@end

@interface ANKeyboardHandlerTest : XCTestCase

@property (nonatomic, strong) ANKeyboardHandler* handler;
@property (nonatomic, strong) UIScrollView* scrollView;

@end

@implementation ANKeyboardHandlerTest

- (void)setUp
{
    [super setUp];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.handler = [ANKeyboardHandler handlerWithTarget:self.scrollView];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_handlerWithTarget_positive_targetIsValid
{
    //given
    void(^testBlock)() = ^{
        [ANKeyboardHandler handlerWithTarget:self.scrollView];
    };

    //then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_handlerWithTarget_negative_targetIsNil_raisesExeption
{
    //given
    void(^testBlock)() = ^{
        [ANKeyboardHandler handlerWithTarget:nil];
    };
    
    //then
    expect(testBlock).to.raiseAny();
}

- (void)test_handlerWithTarget_negative_targetIsNotScroll_raisesExeption
{
    //given
    void(^testBlock)() = ^{
        [ANKeyboardHandler handlerWithTarget:(UIScrollView*)[NSString new]];
    };
    
    //then
    expect(testBlock).to.raiseAny();
}

- (void)test_handleKeyboardWithNotification_positive_calledAfterNotification
{
    //given
    id mockedKeyboard = OCMPartialMock(self.handler);
    OCMExpect([mockedKeyboard handleKeyboardWithNotification:[OCMArg any]]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification
                                                        object:nil];
    //then
    OCMVerifyAll(mockedKeyboard);
}

- (void)test_handleKeyboardAnimationWithDuration_positive_calledAfterNotification
{
    //given
    id mockedKeyboard = OCMPartialMock(self.handler);
    OCMExpect([mockedKeyboard _handleKeyboardAnimationWithDuration:0 animatedBlock:[OCMArg any]]);
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification
                                                        object:nil];
    //then
    OCMVerifyAll(mockedKeyboard);
}

- (void)test_setupDelegate_positive_delegateMethodNotEmpty
{
    //given
    ANTestKeyboardHandlerDelegate* delegate = [ANTestKeyboardHandlerDelegate new];
    id mockedDelegate = OCMPartialMock(delegate);
    self.handler.delegate = mockedDelegate;
    
    expect(self.handler.delegate).notTo.beNil();
    
    OCMExpect([mockedDelegate keyboardWillUpdateToVisible:YES withNotification:[OCMArg any]]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification
                                                        object:nil];
    //then
    OCMVerifyAll(mockedDelegate);
}

- (void)test_bottomOffsetWithScrollView_positive_returnZeroIfViewIsVisible
{
    //given
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGFloat textViewTopOffset = 300;
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                           textViewTopOffset,
                                                                           CGRectGetWidth([UIScreen mainScreen].bounds),
                                                                           40)];
    
    CGSize contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds),
                                     CGRectGetHeight([UIScreen mainScreen].bounds));
    
    [scrollView setContentSize:contentSize];
    [scrollView addSubview:textField];
    
    CGFloat visibleheight = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    CGFloat offset = [self.handler _bottomOffsetWithScrollView:scrollView
                                             withResponderView:textField
                                               withVisibleArea:visibleheight];
    //then
    expect(offset == 0).to.beTruthy();
}

- (void)test_bottomOffsetWithScrollView_positive_expectedOffsetIsTheSameAsCalculated
{
    //given
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGFloat textViewTopOffset = 300;
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                           textViewTopOffset,
                                                                           CGRectGetWidth([UIScreen mainScreen].bounds),
                                                                           40)];
    
    CGSize contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds),
                                    CGRectGetHeight([UIScreen mainScreen].bounds));
    
    [scrollView setContentSize:contentSize];
    [scrollView addSubview:textField];
    
    CGFloat visibleheight = 220;
    
    CGFloat offset = [self.handler _bottomOffsetWithScrollView:scrollView
                                             withResponderView:textField
                                               withVisibleArea:visibleheight];
    
    CGFloat padding = (visibleheight - 40) / 2;
    CGFloat expectedOffset = textViewTopOffset - padding - scrollView.contentInset.top;
    //then
    expect(expectedOffset == offset).to.beTruthy();
}

- (void)test_bottomOffsetWithScrollView_positive_expectedCalculatedOffsetInVisibleArea
{
    //given
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGFloat textViewTopOffset = 300;
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                           textViewTopOffset,
                                                                           CGRectGetWidth([UIScreen mainScreen].bounds),
                                                                           40)];
    
    CGSize contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds),
                                    CGRectGetHeight([UIScreen mainScreen].bounds));
    
    [scrollView setContentSize:contentSize];
    [scrollView addSubview:textField];
    
    CGFloat visibleheight = 220;
    
    CGFloat offset = [self.handler _bottomOffsetWithScrollView:scrollView
                                             withResponderView:textField
                                               withVisibleArea:visibleheight];
 
    CGFloat diff = visibleheight - offset;
    //then
    expect(diff > 0).to.beTruthy();
}

- (void)test_bottomOffsetWithScrollView_positive_textFieldContainTextWithCaretPosition
{
    //given
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGFloat textViewTopOffset = 300;
    CGRect rect = CGRectMake(0, textViewTopOffset, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    
    ANTestableTextField* textField = [[ANTestableTextField alloc] initWithFrame:rect];
    textField.text = @"test text test text";
    
    CGSize contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds),
                                    CGRectGetHeight([UIScreen mainScreen].bounds));
    
    [scrollView setContentSize:contentSize];
    [scrollView addSubview:textField];
    
    CGFloat visibleheight = 220;
    
    CGFloat offset = [self.handler _bottomOffsetWithScrollView:scrollView
                                             withResponderView:textField
                                               withVisibleArea:visibleheight];
    
    CGFloat diff = visibleheight - offset;
    //then
    expect(diff > 0).to.beTruthy();
}

- (void)test_findViewThatIsFirstResponderInParent_negative_viewNotInFocusShouldReturnNil
{
    //given
    ANTestableTextField* responderView = [ANTestableTextField viewWithResponderValue:NO];
    
    UIView* view = [self.handler findViewThatIsFirstResponderInParent:responderView];
    BOOL isViewsEqual = [view isEqual:responderView];
    //then
    expect(isViewsEqual).notTo.beTruthy();
}

- (void)test_findViewThatIsFirstResponderInParent_positive_focusedViewNotNil
{
    //given
    ANTestableTextField* responderView = [ANTestableTextField viewWithResponderValue:YES];
    UIView* view = [self.handler findViewThatIsFirstResponderInParent:responderView];
    BOOL isViewsEqual = [view isEqual:responderView];
    //then
    expect(isViewsEqual).to.beTruthy();
}

- (void)test_findViewThatIsFirstResponderInParent_positive_subviewIsResponder
{
    //given
    ANTestableTextField* responderView = [ANTestableTextField viewWithResponderValue:NO];
    ANTestableTextField* responderSubviewView = [ANTestableTextField viewWithResponderValue:YES];
    
    [responderView addSubview:responderSubviewView];
    
    UIView* view = [self.handler findViewThatIsFirstResponderInParent:responderView];
    BOOL isViewsEqual = [view isEqual:responderSubviewView];
    //then
    expect(isViewsEqual).to.beTruthy();
}

- (void)test_tapRecognizerValid_positive_tapRecognizerValidAndDelegateSelf
{
    //given
    ANKeyboardHandler* keyboardHandler = [ANKeyboardHandler handlerWithTarget:self.scrollView];
    expect(keyboardHandler.tapRecognizer).notTo.beNil();
    id delegate = keyboardHandler.tapRecognizer.delegate;
    BOOL isDelegatesEqualHandler = [delegate isEqual:keyboardHandler];
    
    //then
    expect(isDelegatesEqualHandler).to.beTruthy();
}

- (void)test_keyboardWillShow_positive_keyboardWillShowCalled
{
    //given
    id mockedKeyboardHandler = OCMPartialMock(self.handler);
      OCMExpect([mockedKeyboardHandler keyboardWillShow:[OCMArg any]]);
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification
                                                    object:nil];
    //then
    OCMVerifyAll(mockedKeyboardHandler);
}

- (void)test_keyboardWillHide_positivie_keyboardWillHideCalledAfterNotification
{
    //given
    id mockedKeyboardHandler = OCMPartialMock(self.handler);
    OCMExpect([mockedKeyboardHandler keyboardWillHide:[OCMArg any]]);
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification
                                                        object:nil];
    
    //then
    OCMVerifyAll(mockedKeyboardHandler);

}

- (void)test_dispatchBlockToMain_postivie_moveToMainThreadAfterBackground
{
    //then
    void (^testableBlock)() = ^{
        BOOL isMainThreed = [NSThread isMainThread];
        expect(isMainThreed).to.beTruthy();
    };

    //given
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.handler _dispatchBlockToMain:testableBlock];
    });
}

- (void)test_recognizerDelegate_positive_calledHideKeyboardFromRecognizerDelegate
{
    //given
    id mockedKeyboardHandler = OCMPartialMock(self.handler);
    ANTestableTouch* touch = [ANTestableTouch touchWithView:[UITextField new]];
    OCMExpect([mockedKeyboardHandler hideKeyboard]);
    [self.handler gestureRecognizer:self.handler.tapRecognizer shouldReceiveTouch:touch];
    
    //then
    OCMVerifyAll(mockedKeyboardHandler);
}

- (void)test_endEditing_positive_hideKeyboardCalledEndEditing
{
    id mockedScrollView = OCMPartialMock(self.scrollView);
    OCMExpect([mockedScrollView endEditing:YES]);
    [self.handler hideKeyboard];
    OCMVerifyAll(mockedScrollView);
}

@end
