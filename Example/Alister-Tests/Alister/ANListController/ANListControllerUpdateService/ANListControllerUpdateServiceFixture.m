//
//  ANListControllerUpdateServiceFixture.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/16/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerUpdateServiceFixture.h"

@implementation ANListControllerUpdateServiceFixture

- (instancetype)initWithListView:(id<ANListViewInterface>)listView
{
    self = [super initWithListView:listView];
    if (self)
    {
        self.queue = [NSOperationQueueFixture new];
    }
    return self;
}

@end
