//
//  ANTestableListControllerReloadOperationDelegate.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableListControllerReloadOperationDelegate.h"
#import "ANTestableListView.h"
#import "ANListControllerConfigurationModel.h"

@implementation ANTestableListControllerReloadOperationDelegate


#pragma mark - ANListControllerReloadOperationDelegate

- (UIView<ANListViewInterface>*)listView
{
    ANTestableListView* testableListView = [ANTestableListView new];
    
    return testableListView;
}

- (ANListControllerConfigurationModel*)configurationModel
{
    return [ANListControllerConfigurationModel defaultModel];
}

@end
