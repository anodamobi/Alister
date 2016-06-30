//
//  ANTableControllerUpdater.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANStorageUpdatingInterface.h"

@protocol ANListControllerConfigurationModelInterface;

@protocol ANTableControllerUpdaterDelegate <NSObject>

- (UITableView*)tableView;
- (id<ANListControllerConfigurationModelInterface>)configurationModel;
- (void)reloadFinished;

@end

@interface ANTableControllerUpdater : NSObject <ANStorageUpdatingInterface>

@property (nonatomic, weak) id<ANTableControllerUpdaterDelegate> delegate;

@end
