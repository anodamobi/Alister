//
//  Alister_Example_ExampleUITests.m
//  Alister-Example-ExampleUITests
//
//  Created by Oksana Kovalchuk on 9/6/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+Springboard.h"
#import "SnapshotHelper.h"

@interface Alister_Example_ExampleUITests : XCTestCase

@property (nonatomic, strong) SnapshotHelper* snapshotHelper;

@end

@implementation Alister_Example_ExampleUITests

- (void)setUp
{
    [super setUp];
    
    self.continueAfterFailure = NO;
    
    XCUIApplication* app = [[XCUIApplication alloc] init];
    
    self.snapshotHelper = [[SnapshotHelper alloc] initWithApp:app];
    [app launch];
}

- (void)tearDown
{
    [self updateAppName:@"Alister-Example_Example"];
    
    self.snapshotHelper = nil;
    
    [self deleteApp];
    
    
    [super tearDown];
}

- (void)testExample
{
    [self.snapshotHelper snapshot:@"01LoginScreen" waitForLoadingIndicator:NO];
    
    XCTAssertEqual(@1, @1);
}

@end
