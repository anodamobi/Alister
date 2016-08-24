//
//  ANTestableListControllerUpdateOperationDelegate.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableListControllerUpdateOperationDelegate.h"
#import "ANTestableListView.h"

@implementation ANTestableListControllerUpdateOperationDelegate

- (UIView<ANListViewInterface>*)listView
{
    return [ANTestableListView new];
}

@end
