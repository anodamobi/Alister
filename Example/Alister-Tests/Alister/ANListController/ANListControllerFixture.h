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

@interface ANListControllerFixture : ANListController <ANListControllerSearchManagerDelegate, ANListControllerUpdateServiceDelegate>

@property (nonatomic, strong) ANListControllerItemsHandler* itemsHandler;
@property (nonatomic, strong) id updateService;
@property (nonatomic, strong) id searchManager;

@end
