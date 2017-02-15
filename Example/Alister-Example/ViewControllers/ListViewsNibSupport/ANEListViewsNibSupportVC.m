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
#import "ANETableXibSwitchCell.h"
#import "ANETableXibSegmentCell.h"

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
            
            UINib* xibCellNib = [UINib nibWithNibName:@"ANETableXibSwitchCell" bundle:nil];
            UINib* segmentCellNib = [UINib nibWithNibName:@"ANETableXibSegmentCell" bundle:nil];
            
            [configurator registerCellWithNib:xibCellNib
                                forModelClass:[ANETableXibSwitchCellViewModel class]];
            
            [configurator registerCellWithNib:segmentCellNib
                                forModelClass:[ANETableXibSegmentCellViewModel class]];
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
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
        ANETableXibSwitchCellViewModel* switchModel = [ANETableXibSwitchCellViewModel new];
        ANETableXibSegmentCellViewModel* segmentModel = [ANETableXibSegmentCellViewModel new];
        
        [storageController addItem:switchModel];
        [storageController addItem:segmentModel];
    }];
}

@end
