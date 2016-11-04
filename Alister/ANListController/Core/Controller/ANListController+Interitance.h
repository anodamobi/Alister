//
//  ANListController+Interitance.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListController.h"
#import "ANListControllerItemsHandler.h"

@protocol ANListViewInterface;

@class ANListControllerSearchManager;
@class ANListControllerItemsHandler;
@class ANListControllerQueueProcessor;

@interface ANListController (Interitance)

- (ANStorage*)storage;
- (id<ANListViewInterface>)listView;
- (ANListControllerItemSelectionBlock)selectionBlock;
- (ANListControllerItemsHandler*)itemsHandler;
- (ANListControllerQueueProcessor*)updateProcessor;

- (instancetype)initWithListView:(id<ANListViewInterface>)listView;

@end
