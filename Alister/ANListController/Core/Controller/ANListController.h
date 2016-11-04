//
//  ANListController.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANStorage.h"
#import "ANListControllerReusableInterface.h"
#import "ANListControllerConfigurationModel.h"
#import "Alister.h" //TODO:

@class ANKeyboardHandler;

@interface ANListController : NSObject

@property (nonatomic, strong) ANKeyboardHandler* keyboardHandler;

@property (nonatomic, assign) BOOL shouldHandleKeyboard;
@property (nonatomic, strong, readonly) ANStorage* currentStorage;


- (void)attachStorage:(ANStorage*)storage;

- (void)configureCellsWithBlock:(ANListControllerCellConfigurationBlock)block;
- (void)configureItemSelectionBlock:(ANListControllerItemSelectionBlock)block;


- (void)updateConfigurationModelWithBlock:(ANListConfigurationModelUpdateBlock)block;
- (void)addUpdatesFinishedTriggerBlock:(ANListControllerUpdatesFinishedTriggerBlock)block;

- (void)updateSearchingPredicateBlock:(ANListControllerSearchPredicateBlock)block;

- (void)attachSearchBar:(UISearchBar*)searchBar;

@end
