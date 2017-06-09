//
//  ANListController.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListController.h"
#import "ANListViewInterface.h"
#import "ANListControllerSearchManager.h"
#import "ANKeyboardHandler.h"
#import "ANListControllerItemsHandler.h"
#import "ANListControllerUpdateService.h"
#import "ANListControllerUpdateOperation.h"

@interface ANListController () <ANListControllerSearchManagerDelegate, ANListControllerUpdateServiceDelegate>

@property (nonatomic, weak) ANStorage* storage;
@property (nonatomic, strong) id<ANListViewInterface> listView;

@property (nonatomic, strong) ANListControllerItemsHandler* itemsHandler;
@property (nonatomic, strong) ANListControllerUpdateService* updateService;

@property (nonatomic, copy) ANListControllerItemSelectionBlock selectionBlock;
@property (nonatomic, copy) ANListControllerUpdatesFinishedTriggerBlock updatesFinishedTrigger;

@property (nonatomic, strong) ANListControllerSearchManager* searchManager;

@end

@implementation ANListController

- (instancetype)initWithListView:(id<ANListViewInterface>)listView
{
    self = [super init];
    if (self)
    {
        self.listView = listView;
    }
    return self;
}

- (void)dealloc
{
    [self.listView setDelegate:nil];
    [self.listView setDataSource:nil];

    self.storage.updatesHandler = nil;
    self.storage = nil;
}


#pragma mark - Public

- (void)attachStorage:(ANStorage*)storage
{
    self.storage = storage;
    [self _attachStorage:storage];
}

- (void)attachSearchBar:(UISearchBar*)searchBar
{
    self.searchManager.searchBar = searchBar;
}


#pragma mark - ANListControllerUpdateServiceDelegate

- (void)allUpdatesFinished
{
    if (self.updatesFinishedTrigger)
    {
        self.updatesFinishedTrigger();
    }
}


#pragma mark - SearchManager 

- (void)searchControllerDidCancelSearch
{
    self.storage.updatesHandler = self.updateService;
}

- (void)searchControllerCreatedStorage:(ANStorage*)searchStorage
{
    [self _attachStorage:searchStorage];
}


#pragma mark - Search 

- (void)performSearchWithString:(NSString*)string scope:(NSInteger)scope
{
    [self.searchManager searchPredicateConfigBlock]
}

#pragma mark - Blocks

- (void)configureCellsWithBlock:(ANListControllerCellConfigurationBlock)block
{
    if (block)
    {
        block(self.itemsHandler);
    }
}

- (void)configureItemSelectionBlock:(ANListControllerItemSelectionBlock)block
{
    self.selectionBlock = [block copy];
}

- (void)addUpdatesFinishedTriggerBlock:(ANListControllerUpdatesFinishedTriggerBlock)block
{
    self.updatesFinishedTrigger = [block copy];
}

- (void)updateSearchingPredicateBlock:(ANListControllerSearchPredicateBlock)block
{
    self.searchManager.searchPredicateConfigBlock = block;
}


#pragma mark - Private

- (ANStorage*)currentStorage
{
    return [self.searchManager isSearching] ? self.searchManager.searchingStorage : self.storage;
}

- (void)setListView:(id<ANListViewInterface>)listView
{
    [listView setDelegate:self];
    [listView setDataSource:self];
    _listView = listView;
}

- (void)_attachStorage:(ANStorage*)storage
{
    storage.updatesHandler = self.updateService;
    [self.updateService storageNeedsReloadWithIdentifier:storage.identifier animated:NO];
    
    [storage updateHeaderKind:[self.listView defaultHeaderKind]
                   footerKind:[self.listView defaultFooterKind]];
}

- (ANListControllerSearchManager*)searchManager
{
    if (!_searchManager)
    {
        _searchManager = [ANListControllerSearchManager new];
        _searchManager.delegate = self;
    }
    return _searchManager;
}

- (ANListControllerItemsHandler*)itemsHandler
{
    if (!_itemsHandler)
    {
        _itemsHandler = [[ANListControllerItemsHandler alloc] initWithListView:self.listView
                                                                mappingService:nil]; //TODO: remove mapping service param
    }
    return _itemsHandler;
}

- (ANListControllerUpdateService*)updateService
{
    if (!_updateService)
    {
        _updateService = [[ANListControllerUpdateService alloc] initWithListView:self.listView];
        _updateService.delegate = self;
    }
    return _updateService;
}

@end
