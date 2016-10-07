//
//  ANAppDelegate.m
//  Alister
//
//  Created by Oksana Kovalchuk on 06/30/2016.
//  Copyright (c) 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANAppDelegate.h"
#import "ANEMainVC.h"

@implementation ANAppDelegate

- (BOOL)application:(__unused UIApplication*)application didFinishLaunchingWithOptions:(__unused NSDictionary*)launchOptions
{
    if (NSClassFromString(@"XCTestCase")) return YES;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:[ANEMainVC new]];
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
