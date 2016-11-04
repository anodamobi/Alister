//
//  ANListControllerQueueProcessor.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageUpdateEventsDelegate.h"
#import "ANListViewInterface.h"

@protocol ANListControllerConfigurationModelInterface;

@protocol ANListControllerQueueProcessorDelegate <NSObject>

- (void)allUpdatesFinished;

@end

@interface ANListControllerQueueProcessor : NSObject <ANStorageUpdateEventsDelegate>

@property (nonatomic, weak) id<ANListControllerQueueProcessorDelegate> delegate;
@property (nonatomic, strong, readonly) id<ANListControllerConfigurationModelInterface> configModel;

- (instancetype)initWithListView:(id<ANListViewInterface>)listView;

- (void)registerUpdateOperationClass:(Class)operationClass;

@end
