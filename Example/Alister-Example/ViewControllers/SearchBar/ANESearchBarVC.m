//
//  ANESearchBarVC.m
//  Alister-Example
//
//  Created by ANODA on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANESearchBarVC.h"
#import <Alister/ANTableView.h>
#import <Alister/ANStorage.h>
#import <Alister/ANTableController.h>
#import "ANEDataGenerator.h"
#import "ANELabelTableViewCell.h"
#import "ANESearchBarView.h"

@interface ANESearchBarVC ()

@property (nonatomic, strong) ANESearchBarView* contentView;
@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANTableController* controller;

@end

@implementation ANESearchBarVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.storage = [ANStorage new];
        self.storage.storagePredicateBlock = ^NSPredicate* (NSString* searchString, NSInteger __unused scope) {

            NSPredicate* predicate = nil;
            if (searchString)
            {
                predicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", searchString];
            }
            
            return predicate;
        };
        
        self.contentView = [ANESearchBarView new];
        
        self.controller = [ANTableController controllerWithTableView:self.contentView.tableView];
        [self.controller attachStorage:self.storage];
        [self.controller attachSearchBar:self.contentView.searchBar];
        
        [self.controller configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            
            [configurator registerCellClass:[ANELabelTableViewCell class]
                              forModelClass:[NSString class]];
        }];
    }
    
    return self;
}

- (void)loadView
{
    self.view = self.contentView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"";
    NSArray* items = [ANEDataGenerator searchItems];
    
    [self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
        [storageController addItems:items];
    }];
}

@end
