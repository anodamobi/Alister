//
//  ANESearchBarController.m
//  Alister-Example
//
//  Created by ANODA on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANESearchBarController.h"
#import "ANELabelTableViewCell.h"

@implementation ANESearchBarController

- (instancetype)initWithTableView:(UITableView*)tableView
{
    self = [super initWithTableView:tableView];
    if (self)
    {
        [self configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            
            [configurator registerCellClass:[ANELabelTableViewCell class]
                              forModelClass:[NSString class]];
        }];
    }
    
    return self;
}

@end
