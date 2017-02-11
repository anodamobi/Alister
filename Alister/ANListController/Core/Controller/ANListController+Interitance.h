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

@class ANListControllerItemsHandler;

@interface ANListController (Interitance)

- (ANStorage*)storage;
- (id<ANListViewInterface>)listView;
- (ANListControllerItemSelectionBlock)selectionBlock;
- (ANListControllerItemsHandler*)itemsHandler;
- (void)setItemsHandler:(ANListControllerItemsHandler*)itemsHandler;

- (instancetype)initWithListView:(id<ANListViewInterface>)listView;
- (void)storageWasAttached:(ANStorage*)storage;

@end
