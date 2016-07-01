//
//  ANListControllerQueueProcessor.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageUpdatingInterface.h"
#import "ANListViewInterface.h"

@protocol ANListControllerConfigurationModelInterface;

@protocol ANListControllerQueueProcessorDelegate <NSObject>

- (id<ANListControllerConfigurationModelInterface>)configurationModel;
- (void)allUpdatesFinished;
- (UIView<ANListViewInterface>*)listView;

@end

@interface ANListControllerQueueProcessor : NSObject <ANStorageUpdatingInterface>

@property (nonatomic, weak) id<ANListControllerQueueProcessorDelegate> delegate;
@property (nonatomic, strong) Class updateOperationClass;
@property (nonatomic, strong) Class reloadOperationClass;

@end
