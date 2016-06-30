//
//  ANAppDelegate.m
//  Alister
//
//  Created by Oksana Kovalchuk on 06/30/2016.
//  Copyright (c) 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANAppDelegate.h"
#import "ANViewController.h"

@implementation ANAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [ANViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
