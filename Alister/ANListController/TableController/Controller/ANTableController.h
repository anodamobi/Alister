//
//  ANTableViewController.h
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANListController.h"
#import "ANTableUpdateConfigurationModel.h"

@interface ANTableController : ANListController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak, readonly) UITableView* tableView;

@property (nonatomic, assign) BOOL shouldDisplayHeaderOnEmptySection;
@property (nonatomic, assign) BOOL shouldDisplayFooterOnEmptySection;

+ (instancetype)controllerWithTableView:(UITableView*)tableView;

- (instancetype)initWithTableView:(UITableView*)tableView;

- (void)updateDefaultUpdateAnimationModel:(ANTableUpdateConfigurationModel*)model;

@end
