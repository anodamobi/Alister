//
//  ANEListViewsNibSupportVC.m
//  Alister-Example
//
//  Created by ANODA on 2/15/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

#import "ANEListViewsNibSupportVC.h"
#import "ANStorage.h"
#import "ANTableView.h"
#import "ANTableController.h"

@interface ANEListViewsNibSupportVC ()

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANTableView* tableView;
@property (nonatomic, strong) ANTableController* tableController;

@end

@implementation ANEListViewsNibSupportVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.storage = [ANStorage new];
        self.tableView = [ANTableView new];
        self.tableController = [[ANTableController alloc] initWithTableView:self.tableView];
        [self.tableController attachStorage:self.storage];
        [self.tableController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            
            [configurator registerCellForNibName:@"ANETableXibCell"
                                        inBundle:[NSBundle mainBundle]
                                   forModelClass:[NSString class]];
        }];
    }
    
    return self;
}

@end
