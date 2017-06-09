//
//  ANTableControllerSearchManager.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerSearchManager.h"
#import "ANStorage.h"
#import "ANListControllerLog.h"

@interface ANListControllerSearchManager ()

@property (nonatomic, copy) NSString* currentSearchString;
@property (nonatomic, assign) NSInteger currentSearchScope;

@end

@implementation ANListControllerSearchManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.currentSearchScope = ANListControllerSearchScopeNone;
    }
    return self;
}

- (instancetype)initWithDelegate:(id<ANListControllerSearchManagerDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    self.searchBar.delegate = nil;
    self.searchingStorage.updatesHandler = nil;
}

- (void)setSearchBar:(UISearchBar*)searchBar
{
    searchBar.delegate = self;
    searchBar.selectedScopeButtonIndex = ANListControllerSearchScopeNone;
    _searchBar = searchBar;
}

- (void)setDelegate:(id<ANListControllerSearchManagerDelegate>)delegate
{
    if ([delegate conformsToProtocol:@protocol(ANListControllerSearchManagerDelegate)] || !delegate)
    {
        _delegate = delegate;
    }
    else
    {
        ANListControllerLog(@"Delegate must conform to protocol %@",
                            NSStringFromProtocol(@protocol(ANListControllerSearchManagerDelegate)));
        _delegate = nil;
    }
}


#pragma mark - Public

- (BOOL)isSearching
{
    BOOL isSearchStringNonEmpty = (self.currentSearchString && self.currentSearchString.length);
    return (isSearchStringNonEmpty || self.currentSearchScope > ANListControllerSearchScopeNone);
}

- (void)performSearchWithString:(NSString*)string scope:(NSInteger)scope
{
    [self _filterItemsForSearchString:searchBar.text inScope:searchBar.selectedScopeButtonIndex reload:NO];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(__unused NSString*)searchText
{
    [self _filterItemsForSearchString:searchBar.text inScope:searchBar.selectedScopeButtonIndex reload:NO];
}

- (void)searchBar:(UISearchBar*)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self _filterItemsForSearchString:searchBar.text inScope:selectedScope reload:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];
    [self _filterItemsForSearchString:nil inScope:ANListControllerSearchScopeNone reload:NO];
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar*)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

#pragma mark - Private

- (void)_filterItemsForSearchString:(NSString*)searchString inScope:(NSInteger)scopeNumber reload:(BOOL)shouldReload
{
    BOOL isSearching = [self isSearching];
    BOOL isNothingChanged = ([searchString isEqualToString:self.currentSearchString]) &&
                            (scopeNumber == self.currentSearchScope);
    
    if (!isNothingChanged || shouldReload)
    {
        self.currentSearchScope = scopeNumber;
        self.currentSearchString = searchString;
        
        [self _handleSearchWithCurrentSearchingValue:isSearching];
    }
}

- (void)_handleSearchWithCurrentSearchingValue:(BOOL)isSearching
{
    id<ANListControllerSearchManagerDelegate> delegate = self.delegate;
    
    if (isSearching && ![self isSearching])
    {
        self.searchingStorage.updatesHandler = nil;
        [delegate searchControllerDidCancelSearch];
    }
    else
    {
        ANStorage* storage = delegate.storage;
        storage.updatesHandler = nil;
        
        _searchingStorage = [self _searchStoragefromStorage:storage
                                            forSearchString:self.currentSearchString
                                              inSearchScope:self.currentSearchScope];

        [delegate searchControllerCreatedStorage:_searchingStorage];
    }
}

- (ANStorage*)_searchStoragefromStorage:(ANStorage*)storage
                        forSearchString:(NSString*)searchString
                          inSearchScope:(NSInteger)searchScope
{
    //storage.isSearchingType = YES; TODO:
    
    ANStorage* searchStorage = nil;
    
    NSPredicate* predicate;
    if (self.searchPredicateConfigBlock)
    {
        predicate = self.searchPredicateConfigBlock(searchString, searchScope);
    }
    if (predicate)
    {
        searchStorage = [ANStorage new];
        
        [searchStorage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            
            [storage.sections enumerateObjectsUsingBlock:^(ANStorageSectionModel* obj, NSUInteger idx, __unused BOOL* stop) {
                NSArray* filteredObjects = [obj.objects filteredArrayUsingPredicate:predicate];
                [storageController addItems:filteredObjects toSection:(NSInteger)idx];
            }];
        }];
    }
    else
    {
        ANListControllerLog(@"No predicate was created, so no searching. Check your setter for storagePredicateBlock");
    }
    return searchStorage;
}


@end
