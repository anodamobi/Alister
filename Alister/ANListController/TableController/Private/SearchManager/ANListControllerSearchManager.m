//
//  ANTableControllerSearchManager.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerSearchManager.h"
#import "ANStorage.h"

typedef NS_ENUM(NSInteger, ANListControllerSearchScope)
{
    ANListControllerSearchScopeNone = -1,
};

@interface ANListControllerSearchManager () <UISearchBarDelegate>

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

- (void)dealloc
{
    self.searchBar.delegate = nil;
    self.searchingStorage.listController = nil;
}

- (void)setSearchBar:(UISearchBar*)searchBar
{
    searchBar.delegate = self;
    _searchBar = searchBar;
}

#pragma mark - Public

- (BOOL)isSearching
{
    BOOL isSearchStringNonEmpty = (self.currentSearchString && self.currentSearchString.length);
    return (isSearchStringNonEmpty || self.currentSearchScope > ANListControllerSearchScopeNone);
}


#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(__unused NSString*)searchText
{
    [self _filterItemsForSearchString:searchBar.text inScope:ANListControllerSearchScopeNone reload:NO];
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
        self.searchingStorage.listController = nil;
        [delegate searchControllerDidCancelSearch];
    }
    else
    {
        ANStorage* storage = delegate.storage;
        storage.listController = nil;
        
        _searchingStorage = [storage searchStorageForSearchString:self.currentSearchString
                                                        inSearchScope:self.currentSearchScope];
        
        [delegate searchControllerCreatedStorage:_searchingStorage];
    }
}


@end
