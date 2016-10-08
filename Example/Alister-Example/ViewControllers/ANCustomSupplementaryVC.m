//
//  ANCustomSupplementaryVC.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANCustomSupplementaryVC.h"
#import <Alister/ANStorage.h>
#import <Alister/ANTableController.h>
#import "ANELabelTableViewCell.h"
#import "ANEDefaultSupplementaryVC.h"
#import "ANECustomHeaderView.h"

@interface ANCustomSupplementaryVC () <ANECustomHeaderViewModelDelegate>

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
            
            [configurator registerCellClass:[ANELabelTableViewCell class]
                             forSystemClass:[NSString class]];
            
            [configurator registerHeaderClass:[ANECustomHeaderView class]
                                forModelClass:[ANECustomHeaderViewModel class]];
        }];
    }
    
    return self;
}

- (void)loadView
{
    self.view = self.tableView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray* items = @[@"Test1", @"Test2", @"Test3", @"Test4"];
        
        ANECustomHeaderViewModel* headerViewModel = [ANECustomHeaderViewModel viewModelWithSegmentTitles:@[@"Title1", @"Title2"]];
        headerViewModel.delegate = self;
        
        [self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            
            [storageController addItems:items];
            [storageController setSectionFooterModel:@"I'm footer section 0" forSectionIndex:0];
            [storageController setSectionHeaderModel:@"I'm header section 0" forSectionIndex:0];
            
            [storageController addItems:items toSection:1];
            [storageController setSectionFooterModel:@"I'm footer section 1" forSectionIndex:1];
            [storageController setSectionHeaderModel:@"I'm header section 1" forSectionIndex:1];
        }]; 
        
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"";
    

}

- (void)headerViewModelIndexUpdatedTo:(NSUInteger)index onModel:(__unused ANECustomHeaderViewModel*)model
{
    NSLog(@"index selected on header model - %lu", (unsigned long)index);
}

@end
