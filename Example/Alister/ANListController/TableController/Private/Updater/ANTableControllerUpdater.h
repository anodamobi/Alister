//
//  ANTableControllerUpdater.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerQueueProcessor.h"

@protocol ANListControllerConfigurationModelInterface;

@protocol ANTableControllerUpdaterDelegate <ANListControllerQueueProcessorDelegate>

- (UITableView*)tableView;

@end

@interface ANTableControllerUpdater : ANListControllerQueueProcessor

@property (nonatomic, weak) id<ANTableControllerUpdaterDelegate> delegate;

@end
