//
//  ANListControllerFixture.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/8/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListController.h"
#import "ANListController+Interitance.h"
#import "ANListControllerSearchManager.h"
#import "ANListControllerUpdateService.h"

@interface ANListController () <ANListControllerSearchManagerDelegate, ANListControllerUpdateServiceDelegate>

@property (nonatomic, weak) ANStorage* storage;
@property (nonatomic, strong) id<ANListViewInterface> listView;

@property (nonatomic, strong) ANListControllerItemsHandler* itemsHandler;
@property (nonatomic, strong) ANListControllerUpdateService* updateService;

@property (nonatomic, copy) ANListControllerItemSelectionBlock selectionBlock;
@property (nonatomic, copy) ANListControllerUpdatesFinishedTriggerBlock updatesFinishedTrigger;

@property (nonatomic, strong) ANListControllerSearchManager* searchManager;

@end

@interface ANListControllerFixture : ANListController <ANListControllerSearchManagerDelegate, ANListControllerUpdateServiceDelegate>

@end
