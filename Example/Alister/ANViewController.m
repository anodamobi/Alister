//
//  ANViewController.m
//  Alister
//
//  Created by Oksana Kovalchuk on 06/30/2016.
//  Copyright (c) 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANViewController.h"
#import "ANStorage.h"
#import "ANTableController.h"
#import "ANExampleTableViewCell.h"

@interface ANViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANTableController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

@implementation ANViewController

- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.view = self.tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.storage = [ANStorage new];
    self.controller = [ANTableController controllerWithTableView:self.tableView];
    [self.controller attachStorage:self.storage];
    
    [self.controller configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANExampleTableViewCell class] forSystemClass:[NSString class]];
    }];
    
    [self.storage updateWithAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:@"Test"];
        [storageController addItem:@"Test"];
        [storageController addItem:@"Test"];
        [storageController addItem:@"Test"];
        [storageController addItem:@"Test"];
        [storageController addItem:@"Test"];
        [storageController addItem:@"Test"];
    }];
    
    __weak typeof(self) welf = self;
    
    [self.controller addUpdatesFinsihedTriggerBlock:^{

    }];
    
//    for (NSUInteger i = 0; i < 10; i++)
//    {
//        UITableView* table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        ANStorage* storage = [ANStorage new];
//        ANTableController* tc = [ANTableController controllerWithTableView:table];
//        [tc attachStorage:storage];
//    }
}

@end
