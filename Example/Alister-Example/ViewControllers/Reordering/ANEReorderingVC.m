//
//  ANEReorderingVC.m
//  Alister-Example
//
//  Created by ANODA on 10/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEReorderingVC.h"
#import <Alister/ANStorage.h>
#import "ANELabelTableViewCell.h"
#import "ANEReorderingController.h"
#import "ANEDataGenerator.h"

@interface ANEReorderingVC ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANEReorderingController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

@implementation ANEReorderingVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.storage = [ANStorage new];
        
        self.controller = [ANEReorderingController controllerWithTableView:self.tableView];
        [self.controller updateWithStorage:self.storage];
        self.controller.tableView.editing = YES;
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
    
    self.title = @"";
    
    NSArray* firstSectionItems = [ANEDataGenerator generateStringsArray];
    NSArray* secondSectionItems = [ANEDataGenerator generateStringsArray];
    NSArray* thirsSectionItems = [ANEDataGenerator generateStringsArray];
    
    [self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
        [storageController addItems:firstSectionItems];
        [storageController updateSectionHeaderModel:@"I'm header section 0" forSectionIndex:0];
        
        [storageController addItems:secondSectionItems toSection:1];
        [storageController updateSectionHeaderModel:@"I'm header section 1" forSectionIndex:1];
        
        [storageController addItems:thirsSectionItems toSection:2];
        [storageController updateSectionHeaderModel:@"I'm header section 2" forSectionIndex:2];
    }];
}

@end
