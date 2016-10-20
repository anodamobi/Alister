//
//  ANEDefaultSupplementaryViewController.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEDefaultSupplementaryVC.h"
#import "ANStorage.h"
#import "ANTableController.h"
#import "ANELabelTableViewCell.h"
#import "ANBaseTableFooterView.h"
#import "ANBaseTableHeaderView.h"
#import "ANEDataGenerator.h"

@interface ANEDefaultSupplementaryVC ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANTableController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

@implementation ANEDefaultSupplementaryVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.storage = [ANStorage new];
        
        self.controller = [ANTableController controllerWithTableView:self.tableView];
        self.tableView.sectionHeaderHeight = kDefaultHeaderFooterHeight;
        self.tableView.sectionFooterHeight = kDefaultHeaderFooterHeight;
        
        [self.controller attachStorage:self.storage];
        
        [self.controller configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            
            [configurator registerCellClass:[ANELabelTableViewCell class]
                             forSystemClass:[NSString class]];
            
            [configurator registerFooterClass:[ANBaseTableFooterView class]
                               forSystemClass:[NSString class]];
            
            [configurator registerHeaderClass:[ANBaseTableHeaderView class]
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
    
    NSArray* firstSectionItems = [ANEDataGenerator generateStringsArray];
    NSArray* secondSectionItems = [ANEDataGenerator generateStringsArray];
    NSArray* thirsSectionItems = [ANEDataGenerator generateStringsArray];
    
    [self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
        [storageController addItems:firstSectionItems];
        [storageController updateSectionFooterModel:NSLocalizedString(@"I'm footer section 0", nil) forSectionIndex:0];
        [storageController updateSectionHeaderModel:@"I'm header section 0" forSectionIndex:0];
        
        [storageController addItems:secondSectionItems toSection:1];
        [storageController updateSectionFooterModel:@"I'm footer section 1" forSectionIndex:1];
        [storageController updateSectionHeaderModel:@"I'm header section 1" forSectionIndex:1];
        
        [storageController addItems:thirsSectionItems toSection:2];
        [storageController updateSectionFooterModel:@"I'm footer section 2" forSectionIndex:2];
        [storageController updateSectionHeaderModel:@"I'm header section 2" forSectionIndex:2];
    }];
}

@end
