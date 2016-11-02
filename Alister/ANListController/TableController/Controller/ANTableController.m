//
//  ANTableViewController.m
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANTableController.h"
#import "ANStorageMovedIndexPathModel.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageSectionModelInterface.h"
#import "ANTableControllerManager.h"
#import "ANStorageUpdatingInterface.h"
#import <Alister/ANStorage.h>
#import "ANListControllerSearchManager.h"
#import "ANListControllerTableViewWrapper.h"
#import "ANListController+Interitance.h"

#import <Alister/ANStorage.h>
#import <Alister/ANStorageSectionModel.h>
#import "ANListControllerQueueProcessor.h"
#import "ANListControllerItemsHandler.h"
#import "ANListControllerConfigurationModel.h"
#import "ANTableControllerUpdateOperation.h"
#import "ANListControllerMappingService.h"

@interface ANTableController () <ANTableControllerManagerDelegate, ANListControllerTableViewWrapperDelegate, ANListControllerItemsHandlerDelegate, ANListControllerQueueProcessorDelegate>

@property (nonatomic, strong) id<ANListControllerWrapperInterface> listViewWrapper;

@property (nonatomic, strong) ANListControllerItemsHandler* cellItemsHandler;
@property (nonatomic, strong) ANListControllerQueueProcessor* updateProcessor;
@property (nonatomic, strong) ANListControllerConfigurationModel* configurationModel;

@end

@implementation ANTableController

+ (instancetype)controllerWithTableView:(UITableView*)tableView
{
    return [[self alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView*)tableView
{
    self = [super init];
    if (self)
    {
        self.tableView = tableView;
        self.listViewWrapper = [ANListControllerTableViewWrapper wrapperWithDelegate:self]; //TODO: only tableView
        
        ANTableControllerManager* manager = [ANTableControllerManager new];
        manager.delegate = self;
        manager.configurationModel.reloadAnimationKey = @"UITableViewReloadDataAnimationKey";
        self.manager = manager;
        
        self.cellItemsHandler = [[ANListControllerItemsHandler alloc] initWithMappingService:[ANListControllerMappingService new]];
        self.cellItemsHandler.delegate = self;
        
        self.updateProcessor = [ANListControllerQueueProcessor new];
        self.updateProcessor.delegate = self;
        self.updateProcessor.updateOperationClass = [ANTableControllerUpdateOperation class];
        
        self.configurationModel = [ANListControllerConfigurationModel defaultModel];
    }
    return self;
}

- (id<ANListControllerReusableInterface>)reusableViewsHandler
{
    return self.cellItemsHandler;
}

- (id<ANStorageUpdatingInterface>)updateHandler
{
    return self.updateProcessor;
}

- (UIView<ANListViewInterface>*)listView
{
    return (UIView<ANListViewInterface>*)[self tableView];
}

//- (id<ANListControllerWrapperInterface>)listViewWrapper
//{
//    return [self.delegate listViewWrapper];
//}
//
//- (void)allUpdatesFinished
//{
//    [self.delegate allUpdatesWereFinished];
//}



- (void)setupHeaderFooterDefaultKindOnStorage:(ANStorage*)storage
{
    [storage updateHeaderKind:@"ANTableViewElementSectionHeader" footerKind:@"ANTableViewElementSectionFooter"];
}

- (ANTableControllerManager*)tableManager
{
    return self.manager;
}

- (void)setTableView:(UITableView*)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
}

- (void)dealloc
{
    UITableView* tableView = self.tableView;
    tableView.delegate = nil;
    tableView.dataSource = nil;
    self.tableView = nil;
    self.storage.listController = nil;
    self.storage = nil;
}


#pragma mark - Supplementaries

- (NSString*)tableView:(__unused UITableView*)tableView titleForHeaderInSection:(NSInteger)sectionIndex
{
    return [self _titleForSupplementaryIndex:(NSUInteger)sectionIndex
                                        kind:self.currentStorage.headerSupplementaryKind];
}

- (NSString*)tableView:(__unused UITableView*)tableView titleForFooterInSection:(NSInteger)sectionIndex
{
    return [self _titleForSupplementaryIndex:(NSUInteger)sectionIndex
                                        kind:self.currentStorage.footerSupplementaryKind];
}

- (UIView*)tableView:(__unused UITableView*)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    return [self _supplementaryViewForIndex:(NSUInteger)sectionIndex
                                       kind:self.currentStorage.headerSupplementaryKind];
}

- (UIView*)tableView:(__unused UITableView*)tableView viewForFooterInSection:(NSInteger)sectionIndex
{
    return [self _supplementaryViewForIndex:(NSUInteger)sectionIndex
                                       kind:self.currentStorage.footerSupplementaryKind];
}

- (CGFloat)tableView:(__unused UITableView*)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return [self _heightForSupplementaryIndex:(NSUInteger)sectionIndex
                                         kind:self.currentStorage.headerSupplementaryKind];
}

- (CGFloat)tableView:(__unused UITableView*)tableView heightForFooterInSection:(NSInteger)sectionIndex
{
    return [self _heightForSupplementaryIndex:(NSUInteger)sectionIndex
                                         kind:self.currentStorage.footerSupplementaryKind];
}


#pragma mark - UITableView Protocols Implementation

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView*)tableView
{
    return (NSInteger)[self.currentStorage sections].count;
}

- (NSInteger)tableView:(__unused UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    id <ANStorageSectionModelInterface> sectionModel = [self.currentStorage sectionAtIndex:(NSUInteger)section];
    return (NSInteger)[sectionModel numberOfObjects];
}

- (UITableViewCell*)tableView:(__unused UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    id model = [self.currentStorage objectAtIndexPath:indexPath];;
    return [self _cellForModel:model atIndexPath:indexPath];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectionBlock)
    {
        id model = [self.currentStorage objectAtIndexPath:indexPath];
        self.selectionBlock(model, indexPath);
    }
}

- (void)tableView:(__unused UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)sourceIndexPath
      toIndexPath:(NSIndexPath*)destinationIndexPath
{
    [self.currentStorage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController moveItemWithoutUpdateFromIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }];
}


#pragma mark - Private


- (NSString*)_titleForSupplementaryIndex:(NSUInteger)index kind:(NSString*)kind
{
    id model = [self _supplementaryModelForIndex:index kind:kind];
    if ([model isKindOfClass:[NSString class]])
    {
        UIView* view = [self _supplementaryViewForIndex:index kind:kind];
        if (!view)
        {
            return model;
        }
    }
    return nil;
}

- (UIView*)_supplementaryViewForIndex:(NSUInteger)index kind:(NSString*)kind
{
    id model = [self _supplementaryModelForIndex:index kind:kind];
    return (UIView*)[self.cellItemsHandler supplementaryViewForModel:model kind:kind forIndexPath:nil];
}

- (id)_supplementaryModelForIndex:(NSUInteger)index kind:(NSString*)kind
{
    BOOL isHeader = [kind isEqualToString:[self.currentStorage headerSupplementaryKind]];
    BOOL value = isHeader ?
    self.configurationModel.shouldDisplayHeaderOnEmptySection :
    self.configurationModel.shouldDisplayFooterOnEmptySection;
    ANStorage* storage = self.currentStorage;
    
    if ((storage.sections.count && [[storage sectionAtIndex:index] numberOfObjects]) || value)
    {
        if (isHeader)
        {
            return [storage headerModelForSectionIndex:index];
        }
        else
        {
            return [storage footerModelForSectionIndex:index];
        }
    }
    return nil;
}

- (CGFloat)_heightForSupplementaryIndex:(NSUInteger)index kind:(NSString*)kind
{
    //apple bug HACK: for plain tables, for bottom section separator visibility
    
    BOOL isHeader = [kind isEqualToString:[self.currentStorage headerSupplementaryKind]];
    
    BOOL shouldMaskSeparator = ((self.tableView.style == UITableViewStylePlain) && !isHeader);
    
    CGFloat minHeight = shouldMaskSeparator ? 0.1f : CGFLOAT_MIN;
    id model = [self _supplementaryModelForIndex:index kind:kind];
    if (model)
    {
        BOOL isTitleStyle = ([self _titleForSupplementaryIndex:index kind:kind] != nil);
        if (isTitleStyle)
        {
            return UITableViewAutomaticDimension;
        }
        else
        {
            return isHeader ? self.tableView.sectionHeaderHeight : self.tableView.sectionFooterHeight;
        }
    }
    else
    {
        return minHeight;
    }
}

- (UITableViewCell*)_cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath
{
    return (UITableViewCell*)[self.cellItemsHandler cellForModel:model atIndexPath:indexPath];
}

@end
