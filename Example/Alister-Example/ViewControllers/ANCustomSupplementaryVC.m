//
//  ANCustomSupplementaryVC.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANCustomSupplementaryVC.h"
#import "ANStorage.h"
#import "ANTableController.h"
#import "ANExampleTableViewCell.h"
#import "ANEDefaultSupplementaryVC.h"

@interface ANCustomSupplementaryVC ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANTableController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

@implementation ANCustomSupplementaryVC

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
            
            [configurator registerCellClass:[ANExampleTableViewCell class]
                             forSystemClass:[NSString class]];
            

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
    
    self.title = @"";
    
    NSArray* items = @[@"Test1", @"Test2", @"Test3", @"Test4"];
    
    [self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
        [storageController addItems:items];
        [storageController setSectionFooterModel:@"I'm footer section 0" forSectionIndex:0];
        [storageController setSectionHeaderModel:@"I'm header section 0" forSectionIndex:0];
        
        [storageController addItems:items toSection:1];
        [storageController setSectionFooterModel:@"I'm footer section 1" forSectionIndex:1];
        [storageController setSectionHeaderModel:@"I'm header section 1" forSectionIndex:1];
    }];
}

@end