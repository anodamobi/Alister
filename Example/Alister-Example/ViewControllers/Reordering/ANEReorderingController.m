//
//  ANEReorderingController.m
//  Alister-Example
//
//  Created by ANODA on 10/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEReorderingController.h"
#import "ANELabelTableViewCell.h"
#import "ANBaseTableHeaderView.h"

@implementation ANEReorderingController

- (instancetype)initWithTableView:(UITableView*)tableView
{
    self = [super initWithTableView:tableView];
    if (self)
    {
        [self configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            
            [configurator registerCellClass:[ANELabelTableViewCell class]
                             forModelClass:[NSString class]];
            
            [configurator registerHeaderClass:[ANBaseTableHeaderView class]
                               forModelClass:[NSString class]];
        }];
    }
    
    return self;
}

- (void)updateWithStorage:(ANStorage*)storage;
{
    [self attachStorage:storage];
}


#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView*)__unused tableView editingStyleForRowAtIndexPath:(NSIndexPath*)__unused indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView*)__unused tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath*)__unused indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView*)__unused tableview canMoveRowAtIndexPath:(NSIndexPath*)__unused indexPath
{
    return YES;
}

@end
