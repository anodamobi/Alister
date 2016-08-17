//
//  ANKeyboardHandlerTest.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/12/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANKeyboardHandler.h"
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

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

- (void)test_handlerNotifiesDelegate_positive
{
    //given
//    id delegateMock = OCMProtocolMock(@protocol(ANKeyboardHandlerDelegate));
//    self.handler.delegate = delegateMock;
//    
//    //when
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification
//                                                        object:nil];
//    //then
    
}


//@protocol ANKeyboardHandlerDelegate <NSObject>
//
//@optional
//
//- (void)keyboardWillUpdateToVisible:(BOOL)isVisible withNotification:(NSNotification*)notification;
//
//@end
//
//@interface ANKeyboardHandler : NSObject
//
//@property (nonatomic, assign, getter=isEnabled) BOOL enabled;
//@property (nonatomic, weak) id<ANKeyboardHandlerDelegate> delegate;
//@property (nonatomic, copy) ANKeyboardAnimationBlock animationBlock;
//@property (nonatomic, copy) ANKeyboardStateBlock animationCompletion;
//
//+ (instancetype)handlerWithTarget:(UIScrollView*)target;
//
//- (void)hideKeyboard;

@end
