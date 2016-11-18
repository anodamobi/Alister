//
//  ANEXibController.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEXibController.h"
#import "ANEXibCell.h"

@implementation ANEXibController

- (instancetype)initWithTableView:(UITableView*)tableView
{
    self = [super initWithTableView:tableView];
    if (self)
    {
        [self configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            [configurator registerCellClass:[ANEXibCell class] forModelClass:[ANEXibCellViewModel class]];
        }];
        
        UINib* nib = [UINib nibWithNibName:@"ANEXibCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"ANEXibCellViewModel<=>kANDefaultCellKind"];
    }
    
    return self;
}

- (void)updateWithStorage:(ANStorage*)storage
{
    [self attachStorage:storage];
}

@end
