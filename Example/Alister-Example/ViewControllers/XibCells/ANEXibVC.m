//
//  ANEXibVC.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEXibVC.h"
#import "ANStorage.h"
#import "ANEXibController.h"
#import "ANEDataGenerator.h"
#import "ANEXibCellViewModel.h"

@interface ANEXibVC ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANEXibController* controller;

@end

@implementation ANEXibVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.storage = [ANStorage new];
        
        self.controller = [ANEXibController controllerWithTableView:self.tableView];
        [self.controller updateWithStorage:self.storage];
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
    
    NSArray* generatedItems = [ANEDataGenerator generateUsernames];
    
    NSMutableArray* viewModels = [NSMutableArray new];
    
    [generatedItems enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, __unused NSUInteger idx, __unused  BOOL * _Nonnull stop) {
        
        BOOL isActiveState = arc4random_uniform(2);
        ANEXibCellViewModel* model = [ANEXibCellViewModel viewModelWithUsername:obj
                                                                 andActiveState:isActiveState];
        [viewModels addObject:model];
    }];
    
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItems:viewModels];
    }];
}

@end
