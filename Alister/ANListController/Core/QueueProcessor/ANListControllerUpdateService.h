//
//  ANListControllerQueueProcessor.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageUpdateEventsDelegate.h"
#import "ANListViewInterface.h"
#import "ANListControllerUpdateServiceInterface.h"

@protocol ANListControllerUpdateServiceDelegate <NSObject>

- (void)allUpdatesFinished;

@end

@interface ANListControllerUpdateService : NSObject <ANStorageUpdateEventsDelegate, ANListControllerUpdateServiceInterface>

@property (nonatomic, strong, readonly) id<ANListViewInterface> listView;
@property (nonatomic, weak) id<ANListControllerUpdateServiceDelegate> delegate;

- (instancetype)initWithListView:(id<ANListViewInterface>)listView;

@end
