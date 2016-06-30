//
//  ANListController+Interitance.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListController.h"
#import "ANListControllerManagerInterface.h"

@class ANListControllerSearchManager;
@protocol ANListControllerWrapperInterface;

@interface ANListController (Interitance)

@property (nonatomic, strong) ANStorage* searchingStorage;
@property (nonatomic, strong) ANListControllerSearchManager* searchManager;
@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, copy) ANListControllerItemSelectionBlock selectionBlock;
@property (nonatomic, strong) id<ANListControllerWrapperInterface> listViewWrapper;
@property (nonatomic, strong) id<ANListControllerManagerInterface> manager;

@end
