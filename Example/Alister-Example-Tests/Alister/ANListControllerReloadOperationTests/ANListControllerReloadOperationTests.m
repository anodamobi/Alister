//
//  ANListControllerReloadOperationTests.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/23/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "ANListControllerReloadOperation.h"
#import <UIKit/UIKit.h>
#import "ANListControllerReloadOperationDelegate.h"

@interface ANListControllerReloadOperationTests : XCTestCase

@property (nonatomic, strong) NSOperationQueue* currentQueue;
@property (nonatomic, strong) ANListControllerReloadOperation* operation;
@property (nonatomic, strong) ANListControllerReloadOperationDelegate* delegate;

@end

@implementation ANListControllerReloadOperationTests

- (void)setUp {
    [super setUp];
    self.currentQueue = [NSOperationQueue new];
    self.currentQueue.maxConcurrentOperationCount = 1;
    self.currentQueue.name = @"Testable queue";
    self.operation = [ANListControllerReloadOperation new];
    self.delegate = [ANListControllerReloadOperationDelegate new];
}

- (void)tearDown {
    self.currentQueue = nil;
    self.operation = nil;
    self.delegate = nil;
    [super tearDown];
}

- (void)test_main_positive_mainCalled
{
    //given
    id mockedOperation = OCMPartialMock(self.operation);
    OCMExpect([mockedOperation main]);

    [self.currentQueue addOperation:self.operation];
    [self.currentQueue waitUntilAllOperationsAreFinished];
    
    
    //then
    OCMVerifyAll(mockedOperation);
}

- (void)test_delegateAfterAssignNotNil_positive_delegateNoNil
{
    //given
    self.operation.delegate = self.delegate;
    
    //then
    expect(self.operation.delegate).notTo.beNil();
    expect(self.operation.delegate).equal(self.delegate);
}

- (void)test_shouldAnimateCalledAnimationBlock_positive_calledDelegateMethodsFromAnimatedBlock
{
    //given
    id mockedDelegate = OCMPartialMock(self.delegate);
    self.operation.delegate = mockedDelegate;
    self.operation.shouldAnimate = YES;
    OCMExpect([mockedDelegate configurationModel]);
    [self.currentQueue addOperation:self.operation];
    [self.currentQueue waitUntilAllOperationsAreFinished];
    
    //then
    OCMVerifyAll(mockedDelegate);
}

@end
