//
//  ANESearchBarVC.m
//  Alister-Example
//
//  Created by ANODA on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANESearchBarVC.h"
#import "ANTableView.h"
#import "ANStorage.h"
#import "ANEDataGenerator.h"
#import "ANESearchBarView.h"
#import "ANTableController.h"
#import "ANELabelTableViewCell.h"

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
        self.contentView = [ANESearchBarView new];
        self.controller = [ANTableController controllerWithTableView:self.contentView.tableView];
        
        [self.controller configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            [configurator registerCellClass:[ANELabelTableViewCell class]
                              forModelClass:[NSString class]];
        }];
        
        [self.controller attachStorage:self.storage];
        [self.controller attachSearchBar:self.contentView.searchBar];
        [self.controller updateSearchingPredicateBlock:[self _predicateBlock]];
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
    NSArray* items = [ANEDataGenerator generateUsernames];
    
    [self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItems:items];
    }];
}


#pragma mark - Private

- (ANListControllerSearchPredicateBlock)_predicateBlock
{
    return ^NSPredicate* (NSString* searchString, NSInteger __unused scope) {
        
        NSPredicate* predicate = nil;
        if (searchString)
        {
            predicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", searchString];
        }
        
        return predicate;
    };
}

@end
