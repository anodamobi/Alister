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
#import "ANECustomSupplementaryVC.h"
#import "ANEBottomStickedFooterVC.h"
#import "ANEReorderingVC.h"
#import "ANESearchBarVC.h"
#import "ANEXibVC.h"
#import "ANECollectionViewVC.h"
#import "ANECollectionCustomSupplementaryVC.h"

typedef NS_ENUM(NSInteger, ANEMainSection)
{
    ANEMainSectionGroupedDefaultSupplementaries,
    ANEMainSectionCustomSupplementaries,
    ANEMainSectionBottomStickedFooter,
    ANEMainSectionReordering,
    ANEMainSectionXibCells,
    ANEMainSectionSearchBar,
    ANEMainSectionPlainCollectionView,
    ANEMainSectionCollectionCustomSupplementary
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
            [configurator registerCellClass:[ANELabelTableViewCell class] forModelClass:[NSString class]];
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
        [storageController addItem:@"Plain collection view"];
        [storageController addItem:@"Collection with custom header and footer"];
    }];
    
    [self.controller configureItemSelectionBlock:^(__unused id model, NSIndexPath* indexPath) {
        switch (indexPath.row)
        {
            case ANEMainSectionGroupedDefaultSupplementaries:
            {
                ANEDefaultSupplementaryVC* vc = [ANEDefaultSupplementaryVC new];
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            } break;
            
            case ANEMainSectionCustomSupplementaries:
            {
                ANECustomSupplementaryVC* vc = [ANECustomSupplementaryVC new];
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            } break;
                
            case ANEMainSectionBottomStickedFooter:
            {
                ANEBottomStickedFooterVC* vc = [ANEBottomStickedFooterVC new];
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            } break;
                
            case ANEMainSectionReordering:
            {
                ANEReorderingVC* vc = [ANEReorderingVC new];
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            } break;
            case ANEMainSectionXibCells:
            {
                ANEXibVC* vc = [ANEXibVC new];
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            } break;
            case ANEMainSectionSearchBar:
            {
                ANESearchBarVC* vc = [ANESearchBarVC new];
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            } break;
            case ANEMainSectionPlainCollectionView:
            {
                ANECollectionViewVC* vc = [ANECollectionViewVC new];
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            } break;
            case ANEMainSectionCollectionCustomSupplementary:
            {
                ANECollectionCustomSupplementaryVC* vc = [ANECollectionCustomSupplementaryVC new];
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            } break;
            default: break;
        }
    }];
}

@end
