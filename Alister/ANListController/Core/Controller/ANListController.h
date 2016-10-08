//
//  ANListController.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import <Alister/ANStorage.h>
#import "ANListControllerReusableInterface.h"
#import "ANListControllerConfigurationModel.h"

@class ANKeyboardHandler;

typedef void(^ANListControllerItemSelectionBlock)(id model, NSIndexPath* indexPath);
typedef void(^ANListControllerCellConfigurationBlock)(id<ANListControllerReusableInterface> configurator);
typedef void(^ANListConfigurationModelUpdateBlock)(ANListControllerConfigurationModel* configurationModel);
typedef void (^ANListControllerUpdatesFinishedTriggerBlock)();

@interface ANListController : NSObject

@property (nonatomic, weak, readonly) UISearchBar* searchBar;
@property (nonatomic, strong) ANKeyboardHandler* keyboardHandler;

- (ANStorage*)currentStorage;

- (void)configureCellsWithBlock:(ANListControllerCellConfigurationBlock)block;
- (void)configureItemSelectionBlock:(ANListControllerItemSelectionBlock)block;
- (void)updateConfigurationModelWithBlock:(ANListConfigurationModelUpdateBlock)block;
- (void)addUpdatesFinsihedTriggerBlock:(ANListControllerUpdatesFinishedTriggerBlock)block;

- (void)attachSearchBar:(UISearchBar*)searchBar;
- (void)attachStorage:(ANStorage*)storage;

@end
