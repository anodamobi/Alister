//
//  ANEListViewsNibSupportVC.m
//  Alister-Example
//
//  Created by ANODA on 2/15/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

#import "ANEListViewsNibSupportVC.h"
#import "ANStorage.h"
#import "ANTableController.h"
#import "ANETableXibSwitchCell.h"
#import "ANETableXibSegmentCell.h"
#import "ANEListViewsNibSupportConstants.h"
#import "ANEListViewsNibSupportView.h"
#import "ANCollectionController.h"
#import "ANEDataGenerator.h"

@interface ANEListViewsNibSupportVC ()
<
    ANETableXibSwitchCellViewModelDelegate,
    ANETableXibSegmentCellViewModelDelegate
>

@property (nonatomic, strong) ANStorage* tableStorage;
@property (nonatomic, strong) ANTableController* tableController;
@property (nonatomic, strong) ANStorage* collectionStorage;
@property (nonatomic, strong) ANCollectionController* collectionController;
@property (nonatomic, strong) ANEListViewsNibSupportView* contentView;

@end

@implementation ANEListViewsNibSupportVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.contentView = [ANEListViewsNibSupportView new];
        [self _setupTableComponents];
        [self _setupCollectionComponents];
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
    [self _fillStorages];
}


#pragma mark - ANETableXibSegmentCellViewModelDelegate

- (void)segmentModel:(ANETableXibSegmentCellViewModel*)model segmentStateChangedTo:(ANESegmentState)type
{
    ANETableXibSwitchCellViewModel* switchModel = [self _switchModel];
    [switchModel updateWithSegmentState:type];
    [self _reloadTableStorageWithModel:switchModel];
}


#pragma mark - ANETableXibSwitchCellViewModelDelegate

- (void)switchModel:(ANETableXibSwitchCellViewModel*)model switchStateChangeTo:(ANESegmentState)type
{
    ANETableXibSegmentCellViewModel* segmentModel = [self _segmentModel];
    [segmentModel updateWithSegmentState:type];
    [self _reloadTableStorageWithModel:segmentModel];
}


#pragma mark - Storage

- (void)_setupTableComponents
{
    self.tableStorage = [ANStorage new];
    self.tableController = [[ANTableController alloc] initWithTableView:self.contentView.tableView];
    [self.tableController attachStorage:self.tableStorage];
    [self.tableController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        UINib* switchCellNib = [UINib nibWithNibName:@"ANETableXibSwitchCell" bundle:nil];
        UINib* segmentCellNib = [UINib nibWithNibName:@"ANETableXibSegmentCell" bundle:nil];
        
        [configurator registerCellWithNib:switchCellNib
                            forModelClass:[ANETableXibSwitchCellViewModel class]];
        
        [configurator registerCellWithNib:segmentCellNib
                            forModelClass:[ANETableXibSegmentCellViewModel class]];
    }];
}

- (void)_setupCollectionComponents
{
    self.collectionStorage = [ANStorage new];
    self.collectionController = [[ANCollectionController alloc] initWithCollectionView:self.contentView.collectionView];
    [self.collectionController attachStorage:self.collectionStorage];
    [self.collectionController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        
        UINib* activityCellNib = [UINib nibWithNibName:@"ANEActivityCollectionCell" bundle:nil];
        [configurator registerCellWithNib:activityCellNib forModelClass:[NSString class]];
        
        UINib* headerNib = [UINib nibWithNibName:@"ANCollectionXibHeader" bundle:nil];
        [configurator registerHeaderWithNib:headerNib forModelClass:[NSNumber class]];
        
        UINib* footerNib = [UINib nibWithNibName:@"ANECollectionXibFooter" bundle:nil];
        [configurator registerFooterWithNib:footerNib forModelClass:[NSObject class]];
    }];
}

- (void)_fillStorages
{
    [self.tableStorage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
        ANETableXibSwitchCellViewModel* switchModel = [ANETableXibSwitchCellViewModel new];
        ANETableXibSegmentCellViewModel* segmentModel = [ANETableXibSegmentCellViewModel new];
        segmentModel.delegate = self;
        switchModel.delegate = self;
        
        [storageController addItem:switchModel toSection:ANEListViewsNibSectionSwitch];
        [storageController addItem:segmentModel toSection:ANEListViewsNibSectionSegment];
    }];
    
    NSArray* collectionItems = [ANEDataGenerator generateStringsArrayWithCapacity:12];
    [self.collectionStorage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        
        [storageController addItems:collectionItems];
        [storageController updateSectionHeaderModel:@2 forSectionIndex:0];
        [storageController updateSectionFooterModel:[NSObject new] forSectionIndex:0];
    }];
}

- (void)_reloadTableStorageWithModel:(id)model
{
    [self.tableStorage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController reloadItem:model];
    }];
}


#pragma mark - Helper Methods

- (ANETableXibSwitchCellViewModel*)_switchModel
{
    return [self.tableStorage objectAtIndexPath:[self _indexPathForSection:ANEListViewsNibSectionSwitch]];
}

- (ANETableXibSegmentCellViewModel*)_segmentModel
{
    return [self.tableStorage objectAtIndexPath:[self _indexPathForSection:ANEListViewsNibSectionSegment]];
}

- (NSIndexPath*)_indexPathForSection:(ANEListViewsNibSection)section
{
    return [NSIndexPath indexPathForRow:0 inSection:section];
}

@end
