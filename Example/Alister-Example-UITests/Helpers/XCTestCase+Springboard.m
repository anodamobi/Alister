//
//  XCTestCase+Springboard.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 9/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "XCTestCase+Springboard.h"

static XCUIApplication* springboard = nil;
static NSString* appName = nil;

@implementation XCTestCase (Springboard)

- (void)updateAppName:(NSString*)appNameValue
{
    appName = appNameValue;
}

- (void)deleteApp
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        springboard = [[XCUIApplication alloc] initPrivateWithPath:nil bundleID:@"com.apple.springboard"];
    });

    [[[XCUIApplication alloc] init] terminate];
    
    [springboard resolve];
    
    XCUIElementQuery* icons = [springboard icons];
    XCUIElement* icon = icons[appName];
    
    if (icon.exists)
    {
        CGRect iconFrame = icon.frame;
        CGRect springboardFrame = springboard.frame;
        [icon pressForDuration:1.3];
        
        
        [[springboard coordinateWithNormalizedOffset:CGVectorMake((CGRectGetMinX(iconFrame) + 3) / CGRectGetMaxX(springboardFrame),
                                                                  (CGRectGetMinY(iconFrame) + 3) / CGRectGetMaxY(springboardFrame))] tap];
        
        XCUIElement* alert = [[springboard alerts] buttons][@"Delete"];
        
        [self expectationForPredicate:[NSPredicate predicateWithFormat:@"exists == 1"]
                  evaluatedWithObject:alert
                              handler:nil];
        
        [self waitForExpectationsWithTimeout:0.3 handler:nil];
        
        [alert tap];
    }
}

@end
