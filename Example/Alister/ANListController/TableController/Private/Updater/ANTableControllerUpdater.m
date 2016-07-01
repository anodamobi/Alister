//
//  ANTableControllerUpdater.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANTableControllerUpdater.h"
#import "ANTableControllerUpdateOperation.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageUpdateOperation.h"
#import "ANStorageUpdateControllerInterface.h"
#import "ANListControllerConfigurationModelInterface.h"
#import "ANTableControllerReloadOperation.h"

@interface ANTableControllerUpdater ()
<
    ANTableControllerUpdateOperationDelegate,
    ANTableControllerReloadOperationDelegate
>

@end

@implementation ANTableControllerUpdater

@synthesize delegate = _delegate;

- (UITableView*)tableView
{
    return [self.delegate tableView];
}

@end
