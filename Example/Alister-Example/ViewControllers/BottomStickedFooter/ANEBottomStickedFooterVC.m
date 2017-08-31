//
//  ANEBottomStickedFooterVC.m
//  Alister-Example
//
//  Created by ANODA on 10/19/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEBottomStickedFooterVC.h"
#import "ANTableView.h"
#import "ANStorage.h"
#import "ANTableController.h"
#import "ANELabelTableViewCell.h"
#import "ANEDataGenerator.h"
#import "ANEButtonFooterView.h"

static CGFloat const kDefaultBottomViewHeight = 100;

@interface ANEBottomStickedFooterVC ()

@property (nonatomic, strong) ANTableView* tableView;
@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANTableController* controller;
@property (nonatomic, strong) ANEButtonFooterView* footerView;

@end

@implementation ANEBottomStickedFooterVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tableView = [[ANTableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStyleGrouped];
        
        self.storage = [ANStorage new];
        
        self.controller = [ANTableController controllerWithTableView:self.tableView];
        [self.controller attachStorage:self.storage];
        
        [self.controller configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            
            [configurator registerCellClass:[ANELabelTableViewCell class]
                             forModelClass:[NSString class]];
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
    NSArray* firstSectionItems = [ANEDataGenerator bottomStickedItems];
    
    [self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
        [storageController addItems:firstSectionItems];
    }];
    
    [self.footerView.actionButton addTarget:self
                                     action:@selector(bottomButtonSelected)
                           forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addStickyFooter:self.footerView
                    withFixedHeight:kDefaultBottomViewHeight];
}


#pragma mark - Actions

- (void)bottomButtonSelected
{
    NSLog(@"bottomButtonSelected");
}


#pragma mark - Lazy Load

- (ANEButtonFooterView*)footerView
{
    if (!_footerView)
    {
        _footerView = [ANEButtonFooterView new];
    }
    
    return _footerView;
}

@end
