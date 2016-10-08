//
//  ANViewController.m
//  Alister
//
//  Created by Oksana Kovalchuk on 06/30/2016.
//  Copyright (c) 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEMainVC.h"
#import "ANStorage.h"
#import "ANTableController.h"
#import "ANELabelTableViewCell.h"
#import "ANEDefaultSupplementaryVC.h"
#import "ANCustomSupplementaryVC.h"

typedef NS_ENUM(NSInteger, ANEMainSection)
{
    ANEMainSectionGroupedDefaultSupplementaries,
    ANEMainSectionCustomSupplementaries
};

@interface ANEMainVC ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANTableController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

@implementation ANEMainVC

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
            [configurator registerCellClass:[ANELabelTableViewCell class] forSystemClass:[NSString class]];
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
    
    self.title = NSLocalizedString(@"Alister", nil);
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
        [storageController addItem:@"Grouped table with default header and footer"];
        [storageController addItem:@"Plain table with custom headers and footers"];
        [storageController addItem:@"Table with bottom sticked footer"];
        [storageController addItem:@"Table reordering"];
        [storageController addItem:@"Table with xib cells"];
        [storageController addItem:@"Table with search bar and empty states"];
        [storageController addItem:@"Collection controller"];
    }];
    
    [self.controller configureItemSelectionBlock:^(__unused id model, NSIndexPath* indexPath) {
        switch (indexPath.row)
        {
            case ANEMainSectionGroupedDefaultSupplementaries:
            {
                ANEDefaultSupplementaryVC* vc = [ANEDefaultSupplementaryVC new];
                [self.navigationController pushViewController:vc animated:YES];
            } break;
            
            case ANEMainSectionCustomSupplementaries:
            {
                ANCustomSupplementaryVC* vc = [ANCustomSupplementaryVC new];
                [self.navigationController pushViewController:vc animated:YES];
            } break;
            default: break;
        }
    }];
}

@end
