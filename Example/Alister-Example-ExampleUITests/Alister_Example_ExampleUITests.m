//
//  Alister_Example_ExampleUITests.m
//  Alister-Example-ExampleUITests
//
//  Created by Oksana Kovalchuk on 9/6/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+Springboard.h"

@interface Alister_Example_ExampleUITests : XCTestCase

@end

@implementation Alister_Example_ExampleUITests

- (void)setUp
{
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown
{
    [self updateAppName:@"Alister-Example_Example"];
    
    [self deleteApp];
    [super tearDown];
}

- (void)testExample
{
    XCTAssertEqual(@1, @1);
}

@end
