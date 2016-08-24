//
//  ANListControllerReloadOperationDelegate.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerReloadOperationDelegate.h"
#import "ANTestableListView.h"

@implementation ANListControllerReloadOperationDelegate

#pragma mark - ANListControllerReloadOperationDelegate

- (UIView<ANListViewInterface>*)listView
{
    ANTestableListView* testableListView = [ANTestableListView new];
    return testableListView;
}

- (ANListControllerConfigurationModel*)configurationModel
{
    return nil;
}

@end
