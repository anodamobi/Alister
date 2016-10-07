//
//  ANViewController.m
//  Alister
//
//  Created by Oksana Kovalchuk on 06/30/2016.
//  Copyright (c) 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANViewController.h"
#import <Alister/ANStorage.h>
#import "ANTableController.h"
#import "ANExampleTableViewCell.h"

@interface ANViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANTableController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

@implementation ANViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.storage = [ANStorage new];
        self.controller = [ANTableController controllerWithTableView:self.tableView];
        [self.controller attachStorage:self.storage];
        
        [self.controller configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            [configurator registerCellClass:[ANExampleTableViewCell class] forSystemClass:[NSString class]];
        }];
        
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            
            [storageController addItem:@"Test"];
            [storageController addItem:@"Test"];
            [storageController addItem:@"Test"];
            [storageController addItem:@"Test"];
            [storageController addItem:@"Test"];
            [storageController addItem:@"Test"];
            [storageController addItem:@"Test"];
        }];
    }
    
    return self;
}

- (void)loadView
{
    
    self.view = self.tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.storage = [ANStorage new];
//    self.controller = [ANTableController controllerWithTableView:self.tableView];
//    [self.controller attachStorage:self.storage];
//    
//    [self.controller configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
//        [configurator registerCellClass:[ANExampleTableViewCell class] forSystemClass:[NSString class]];
//    }];
//    
////    [self.storage updateWithAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
////        [storageController addItem:@"Test"];
////        [storageController addItem:@"Test"];
////        [storageController addItem:@"Test"];
////        [storageController addItem:@"Test"];
////        [storageController addItem:@"Test"];
////        [storageController addItem:@"Test"];
////        [storageController addItem:@"Test"];
////    }];
//    
//    __weak typeof(self) welf = self;
//    
//    [self.controller configureItemSelectionBlock:^(id model, NSIndexPath* indexPath) {
//        NSLog(@"selected");
//    }];
//    
//    [self.controller addUpdatesFinsihedTriggerBlock:^{
//        [strongSelf.controller tableView:strongSelf.tableView
//                           didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    }];
//    
//    
//    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
//        [storageController addItem:@"i"];
//    }];

    
    
//    for (NSUInteger i = 0; i < 10; i++)
//    {
//        UITableView* table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        ANStorage* storage = [ANStorage new];
//        ANTableController* tc = [ANTableController controllerWithTableView:table];
//        [tc attachStorage:storage];
//    }
}

@end
