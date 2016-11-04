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
#import "ANListControllerQueueProcessor.h"

@interface ANListController ()
<
    ANListControllerSearchManagerDelegate,
    ANListControllerQueueProcessorDelegate
>

@property (nonatomic, weak) ANStorage* storage;
@property (nonatomic, strong) id<ANListViewInterface> listView;

@property (nonatomic, strong) ANListControllerItemsHandler* itemsHandler;
@property (nonatomic, strong) ANListControllerQueueProcessor* updateProcessor;

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
        self.searchManager = [ANListControllerSearchManager new];
        self.searchManager.delegate = self;
        
        self.itemsHandler = [[ANListControllerItemsHandler alloc] initWithListView:listView
                                                                    mappingService:nil];
        
        self.updateProcessor = [[ANListControllerQueueProcessor alloc] initWithListView:listView];
        self.updateProcessor.delegate = self;
        
        self.listView = listView;
    

//        [self _updateKeyboardHandlerWithConfigurationModel:[self configurationModel]]; //TODO:
    }
    return self;
}

- (void)setListView:(id<ANListViewInterface>)listView
{
    [listView setDelegate:self];
    [listView setDataSource:self];
    _listView = listView;
}

- (void)dealloc
{
    [self.listView setDelegate:nil];
    [self.listView setDataSource:nil];

    self.storage.listController = nil;
    self.storage = nil;
}

- (void)allUpdatesFinished
{
    if (self.updatesFinishedTrigger)
    {
        self.updatesFinishedTrigger();
    }
}

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

- (void)updateConfigurationModelWithBlock:(ANListConfigurationModelUpdateBlock)block
{
    if (block)
    {
        block(self.updateProcessor.configModel);
        [self _updateKeyboardHandlerWithConfigurationModel:self.updateProcessor.configModel];
    }
}

- (void)addUpdatesFinishedTriggerBlock:(ANListControllerUpdatesFinishedTriggerBlock)block
{
    self.updatesFinishedTrigger = [block copy];
}

- (void)attachStorage:(ANStorage*)storage
{
    self.storage = storage;
    [self _attachStorage:storage];
}

- (void)reloadStorageAnimated:(ANStorage*)storage
{
    [self.updateProcessor storageNeedsReloadWithIdentifier:storage.identifier animated:YES];
}

- (void)reloadStorageWithoutAnimation:(ANStorage*)storage
{
    [self.updateProcessor storageNeedsReloadWithIdentifier:storage.identifier animated:NO];
}

- (void)searchControllerDidCancelSearch
{
    self.storage.listController = [self updateProcessor];
}

- (void)searchControllerCreatedStorage:(ANStorage*)searchStorage
{
    [self _attachStorage:searchStorage];
    [self.updateProcessor storageNeedsReloadWithIdentifier:searchStorage.identifier animated:YES];
    
    searchStorage.listController = [self updateProcessor]; //TODO:
}

- (ANStorage*)currentStorage
{
    return [self.searchManager isSearching] ? self.searchManager.searchingStorage : self.storage;
}

- (void)attachSearchBar:(UISearchBar*)searchBar
{
    self.searchManager.searchBar = searchBar;
}

- (void)allUpdatesWereFinished
{
    if (self.updatesFinishedTrigger)
    {
        self.updatesFinishedTrigger();
    }
}

- (void)setupHeaderFooterDefaultKindOnStorage:(ANStorage*)storage
{
    NSAssert(NO, @"You need to override this method");
}

#pragma mark - Private

//TODO:
- (void)_updateKeyboardHandlerWithConfigurationModel:(ANListControllerConfigurationModel*)model
{
    BOOL shouldHandleKeyboard = [self shouldHandleKeyboard];
    if (shouldHandleKeyboard && !self.keyboardHandler)
    {
        self.keyboardHandler = [ANKeyboardHandler handlerWithTarget:[self.listView view]];
    }
    if (!shouldHandleKeyboard)
    {
        self.keyboardHandler = nil;
    }
}

- (void)_attachStorage:(ANStorage*)storage
{
    storage.listController = [self updateProcessor];
    [self setupHeaderFooterDefaultKindOnStorage:storage];
    [self.storage.listController storageNeedsReloadWithIdentifier:storage.identifier animated:NO];
}

@end
