//
//  ANTableControllerUpdateOperation.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANStorageUpdateCollectionOperationInterface.h"

@class ANStorageUpdateModel;

@protocol ANListControllerConfigurationModelInterface;

@protocol ANTableControllerUpdateOperationDelegate <NSObject>

- (UITableView*)tableView;
- (id<ANListControllerConfigurationModelInterface>)configurationModel;
- (void)storageNeedsReloadWithIdentifier:(NSString*)identifier;

@end

@interface ANTableControllerUpdateOperation : NSOperation <ANStorageUpdateCollectionOperationInterface>

@property (nonatomic, weak) id<ANTableControllerUpdateOperationDelegate> delegate;

@end
