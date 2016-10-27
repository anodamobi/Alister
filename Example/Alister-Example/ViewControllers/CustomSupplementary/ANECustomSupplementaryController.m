//
//  ANECustomSupplementaryController.m
//  Alister-Example
//
//  Created by ANODA on 10/19/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomSupplementaryController.h"
#import "ANELabelTableViewCell.h"

@implementation ANECustomSupplementaryController

- (instancetype)initWithTableView:(UITableView*)tableView
{
    self = [super initWithTableView:tableView];
    if (self)
    {
        [self configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            
            [configurator registerCellClass:[ANELabelTableViewCell class]
                             forModelClass:[NSString class]];
            
            [configurator registerHeaderClass:[ANECustomHeaderView class]
                                forModelClass:[ANECustomHeaderViewModel class]];
            
            [configurator registerFooterClass:[ANECustomFooterView class]
                                forModelClass:[ANECustomFooterViewModel class]];
        }];
    }
    
    return self;
}

- (void)updateWithStorage:(ANStorage*)storage;
{
    [self attachStorage:storage];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView*)__unused tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight = 25;
    id model = [self.currentStorage headerModelForSectionIndex:(NSUInteger)section];
    if ([model isKindOfClass:[ANECustomHeaderViewModel class]])
    {
        headerHeight = 40;
    }
    
    return headerHeight;
}

- (CGFloat)tableView:(UITableView*)__unused tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerHeight = 25;
    id model = [self.currentStorage footerModelForSectionIndex:(NSUInteger)section];
    if ([model isKindOfClass:[ANECustomFooterViewModel class]])
    {
        footerHeight = 40;
    }
    
    return footerHeight;
}

@end
