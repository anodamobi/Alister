//
//  ANECustomSupplementaryVC.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomSupplementaryVC.h"
#import "ANStorage.h"
#import "ANECustomSupplementaryController.h"
#import "ANEDefaultSupplementaryVC.h"
#import "ANEDataGenerator.h"

@interface ANECustomSupplementaryVC () <ANECustomHeaderViewModelDelegate, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANECustomSupplementaryController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

@implementation ANECustomSupplementaryVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.storage = [ANStorage new];
        
        self.controller = [ANECustomSupplementaryController controllerWithTableView:self.tableView];
        
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
    
    ANECustomHeaderViewModel* headerViewModel = [ANECustomHeaderViewModel viewModelWithSegmentTitles:@[@"Title 1", @"Title 2"]];
    headerViewModel.delegate = self;
    
    NSString* footerString = [ANEDataGenerator loremIpsumString];
    NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:footerString];
    ANECustomFooterViewModel* footerViewModel = [ANECustomFooterViewModel viewModelWithAttrString:attrString];
    
    [self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
//        [storageController addItems:firstSectionItems];
        [storageController updateSectionFooterModel:footerViewModel forSectionIndex:0];
        [storageController updateSectionHeaderModel:headerViewModel forSectionIndex:0];
        
        [storageController addItems:secondSectionItems toSection:1];
//        [storageController updateSectionFooterModel:@"I'm footer section 1" forSectionIndex:1];
//        [storageController updateSectionHeaderModel:@"I'm header section 1" forSectionIndex:1];
        
        [storageController addItems:thirsSectionItems toSection:2];
//        [storageController updateSectionFooterModel:@"I'm footer section 2" forSectionIndex:2];
//        [storageController updateSectionHeaderModel:@"I'm header section 2" forSectionIndex:2];
    }];
    
    [self.controller updateWithStorage:self.storage];
}

- (void)headerViewModelIndexUpdatedTo:(NSUInteger)index onModel:(__unused ANECustomHeaderViewModel*)model
{
    NSLog(@"index selected on header model - %lu", (unsigned long)index);
}

@end
