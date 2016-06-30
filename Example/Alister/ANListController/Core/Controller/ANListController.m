//
//  ANListController.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListController.h"
#import "ANListControllerWrapperInterface.h"
#import "ANListControllerSearchManager.h"
#import "ANListController+Interitance.h"
#import "ANListControllerManagerInterface.h"
#import "ANKeyboardHandler.h"
#import "ANListControllerConfigurationModel.h"

@interface ANListController () <ANListControllerSearchManagerDelegate>

@property (nonatomic, strong) ANStorage* searchingStorage;
@property (nonatomic, strong) ANListControllerSearchManager* searchManager;
@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, copy) ANListControllerItemSelectionBlock selectionBlock;
@property (nonatomic, strong) id<ANListControllerWrapperInterface> listViewWrapper;
@property (nonatomic, strong) id<ANListControllerManagerInterface> manager;

@end

@implementation ANListController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.searchManager = [ANListControllerSearchManager new];
        self.searchManager.delegate = self;
    }
    return self;
}

- (void)configureCellsWithBlock:(ANListControllerCellConfigurationBlock)block
{
    if (block)
    {
        block([self.manager reusableViewsHandler]);
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
        block(self.manager.configurationModel);
        [self _updateKeyboardHandlerWithConfigurationModel:[self.manager configurationModel]];
    }
}

- (void)attachStorage:(ANStorage*)storage
{
    self.storage = storage;
    [self _attachStorage:storage];
}

- (void)dealloc
{
    self.searchBar.delegate = nil;
    self.storage.listController = nil;
    self.searchingStorage.listController = nil;
}

- (void)reloadStorageAnimated:(ANStorage*)storage
{
    [[self.manager updateHandler] storageNeedsReloadAnimatedWithIdentifier:storage.identifier];
}

- (void)searchControllerDidCancelSearch
{
    self.searchingStorage.listController = nil;
    self.storage.listController = [self.manager updateHandler];
}

- (void)setSearchingStorage:(ANStorage*)searchingStorage
{
    _searchingStorage = searchingStorage;
    [self _attachStorage:searchingStorage];
}

- (void)setManager:(id<ANListControllerManagerInterface>)manager
{
    _manager = manager;
    [self _updateKeyboardHandlerWithConfigurationModel:[manager configurationModel]];
}

- (void)searchControllerRequiresStorageWithSearchString:(NSString*)searchString andScope:(NSInteger)scope
{
    self.storage.listController = nil;
    
    self.searchingStorage = [self.storage searchStorageForSearchString:searchString
                                                        inSearchScope:scope];
    [self _attachStorage:self.searchingStorage];
    
    [[self.manager updateHandler] storageNeedsReloadAnimatedWithIdentifier:self.searchingStorage.identifier];
    
    self.searchingStorage.listController = [self.manager updateHandler];
}

- (ANStorage*)currentStorage
{
    return [self.searchManager isSearching] ? self.searchingStorage : self.storage;
}

- (void)attachSearchBar:(UISearchBar*)searchBar
{
    searchBar.delegate = self.searchManager;
    _searchBar = searchBar;
}


#pragma mark - Private

- (void)_updateKeyboardHandlerWithConfigurationModel:(ANListControllerConfigurationModel*)model
{
    BOOL shouldHandleKeyboard = [model shouldHandleKeyboard];
    if (shouldHandleKeyboard && !self.keyboardHandler)
    {
        self.keyboardHandler = [ANKeyboardHandler handlerWithTarget:[self.listViewWrapper view]];
    }
    if (!shouldHandleKeyboard)
    {
        self.keyboardHandler = nil;
    }
}

- (void)_attachStorage:(ANStorage*)storage
{
    storage.listController = [self.manager updateHandler];
    
    [storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController setSupplementaryHeaderKind:self.manager.configurationModel.defaultHeaderSupplementary];
        [storageController setSupplementaryFooterKind:self.manager.configurationModel.defaultFooterSupplementary];
    }];
    [self.storage.listController storageNeedsReloadWithIdentifier:storage.identifier];
}

@end
