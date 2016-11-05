//
//  ANListControllerSearchMangerTests.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/25/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANListControllerSearchManager.h"

@interface ANListControllerSearchManager ()

@property (nonatomic, copy) NSString* currentSearchString;
@property (nonatomic, assign) NSInteger currentSearchScope;

- (void)_filterItemsForSearchString:(NSString*)searchString inScope:(NSInteger)scopeNumber reload:(BOOL)shouldReload;
- (void)_handleSearchWithCurrentSearchingValue:(BOOL)isSearching;

@end

@interface ANListControllerSearchManagerTest : XCTestCase <ANListControllerSearchManagerDelegate>

@end

@implementation ANListControllerSearchManagerTest

describe(@"searchStorageForSearchString: inSearchScope:", ^{
    
    beforeEach(^{
        storage.storagePredicateBlock = ^NSPredicate* (NSString* searchString, NSInteger scope) {
            
            NSPredicate* predicate = nil;
            if (searchString)
            {
                if (scope == -1)
                {
                    predicate = [NSPredicate predicateWithFormat:@"ANY self BEGINSWITH[cd] %@", searchString];
                }
                else if (scope == 0)
                {
                    predicate = [NSPredicate predicateWithFormat:@"self CONTAINS[cd] %@", searchString];
                }
            }
            
            return predicate;
        };
    });
    
    it(@"successfully created", ^{
        ANStorage* searchStorage = [storage searchStorageForSearchString:@"test" inSearchScope:0];
        expect(searchStorage).notTo.beNil();
    });
    
    it(@"successfully created when string is nil", ^{
        ANStorage* searchStorage = [storage searchStorageForSearchString:nil inSearchScope:0];
        expect(searchStorage).notTo.beNil();
    });
    
    it(@"no assert if string is nil", ^{
        void(^block)() = ^() {
            [storage searchStorageForSearchString:nil inSearchScope:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"filters by predicate ", ^{
        NSArray* itemsForScope1 = @[@"test", @"test1", @"test2", @"test4"];
        NSArray* items = [itemsForScope1 arrayByAddingObjectsFromArray:@[@"anoda", @"tiger", @"tooth",
                                                                         @"tool", @"something", @"anything"]];
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:items];
        }];
        
        NSString* searchString = @"test";
        ANStorage* searchStorage = [storage searchStorageForSearchString:searchString inSearchScope:0];
        expect(searchStorage.sections).haveCount(1);
        
        [[searchStorage itemsInSection:0] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger __unused idx, BOOL * _Nonnull __unused stop) {
            expect(obj).beginWith(searchString);
        }];
        
        expect([searchStorage itemsInSection:0]).haveCount(itemsForScope1.count);
        expect([searchStorage sections]).haveCount(1);
    });
});


describe(@"storagePredicateBlock", ^{
    
    it(@"called when searching storage created", ^{
        waitUntil(^(void (^done)(void)) {
            storage.storagePredicateBlock = ^NSPredicate* (NSString* __unused searchString,
                                                           NSInteger __unused scope) {
                done();
                
                return nil;
            };
            
            [storage searchStorageForSearchString:nil inSearchScope:0];
        });
    });
    
    it(@"received correct parameters", ^{
        __block NSString* searchStringItem = @"test";
        __block NSInteger scopeItem = 2;
        
        waitUntil(^(void (^done)(void)) {
            storage.storagePredicateBlock = ^NSPredicate* (NSString* __unused searchString, NSInteger __unused scope) {
                done();
                
                expect(searchString).equal(searchStringItem);
                expect(scope).equal(scopeItem);
                
                return nil;
            };
            [storage searchStorageForSearchString:searchStringItem inSearchScope:scopeItem];
        });
    });
    
    it(@"no assert when block is nil", ^{
        void(^block)() = ^() {
            [storage searchStorageForSearchString:nil inSearchScope:0];
        };
        expect(block).notTo.raiseAny();
    });
});


- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_currentSearchScope_positive_hasNoScopeAfterCreation
{
    //given
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    
    //then
    expect(searchManager.currentSearchScope).to.beLessThan(0);
}

- (void)test_delegate_positive_setupedDelegateNotNil
{
    //given
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    searchManager.delegate = self;
    
    //then
    expect(searchManager.delegate).notTo.beNil();
}

- (void)test_isSearching_positive_returnedYesWithValidValues
{
    //given
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    searchManager.currentSearchString = @"search string";
    searchManager.currentSearchScope = 2;
    
    //then
    expect([searchManager isSearching]).to.beTruthy();
}


#pragma mark - Filter method test

- (void)test_searchControllerRequiresStorageWithSearchString_positive_delegateSearchCalled
{
    //given
    id mockedDelegate = OCMPartialMock(self);
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    searchManager.delegate = mockedDelegate;
    NSString* searchString = @"search string";
    NSInteger scopeNumber = 2;
    searchManager.currentSearchString = @"";
    
    OCMExpect([mockedDelegate searchControllerRequiresStorageWithSearchString:[OCMArg any] andScope:scopeNumber]);
    
    //when
    [searchManager _filterItemsForSearchString:searchString inScope:scopeNumber reload:NO];
    
    //then
    OCMVerifyAll(mockedDelegate);
}

- (void)test_handleSearchWithCurrentSearchingValue_positive_delegateSearchControllerDidCancel
{
    //given
    id mockedDelegate = OCMPartialMock(self);
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    searchManager.delegate = mockedDelegate;
    searchManager.currentSearchString = @"";
    searchManager.currentSearchScope = -1;
    OCMExpect([mockedDelegate searchControllerDidCancelSearch]);
    
    //when
    [searchManager _handleSearchWithCurrentSearchingValue:YES];
    
    //then
    OCMVerifyAll(mockedDelegate);
}

- (void)test_handleSearchWithCurrentSearchingValue_positive_seachControllerRequiresStorageCalled
{
    //given
    id mockedDelegate = OCMPartialMock(self);
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    searchManager.delegate = mockedDelegate;
    searchManager.currentSearchString = @"search";
    searchManager.currentSearchScope = 2;
    OCMExpect([mockedDelegate searchControllerRequiresStorageWithSearchString:searchManager.currentSearchString
                                                                     andScope:searchManager.currentSearchScope]);
    
    //when
    [searchManager _handleSearchWithCurrentSearchingValue:NO];
    
    //then
    OCMVerifyAll(mockedDelegate);
}


#pragma mark - UISearchBarDelegate methods tests

- (void)test_filterItemsCalled_positive_calledFromDelegateMethodTextDidEndChange
{
    //given
    NSString* searchString = @"search";
    NSInteger scope = -1;
    UISearchBar* searchBar = [UISearchBar new];
    searchBar.text = searchString;
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    id mockedSearchManager = OCMPartialMock(searchManager);
    OCMExpect([mockedSearchManager _filterItemsForSearchString:searchString inScope:scope reload:NO]);
    
    //when
    [mockedSearchManager searchBar:searchBar textDidChange:searchString];
    
    //then
    OCMVerifyAll(mockedSearchManager);
}

- (void)test_selectedScopeButtonIndexDidChange_positive_filterItemsForSearchStringCalled
{
    //given
    NSString* searchString = @"search";
    NSInteger scope = -1;
    UISearchBar* searchBar = [UISearchBar new];
    searchBar.text = searchString;
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    id mockedSearchManager = OCMPartialMock(searchManager);
    OCMExpect([mockedSearchManager _filterItemsForSearchString:searchString inScope:scope reload:NO]);
    
    //when
    [mockedSearchManager searchBar:searchBar selectedScopeButtonIndexDidChange:scope];
    
    //then
    OCMVerifyAll(mockedSearchManager);
}

- (void)test_searchBarCancelButtonClicked_positive_filterItemsForSearchStringCalled
{
    //given
    NSInteger scope = -1;
    UISearchBar* searchBar = [UISearchBar new];
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    id mockedManager = OCMPartialMock(searchManager);
    OCMExpect([mockedManager _filterItemsForSearchString:nil inScope:scope reload:NO]);
    
    //when
    [searchManager searchBarCancelButtonClicked:searchBar];
    
    //then
    OCMVerifyAll(mockedManager);
}

- (void)test_searchBarSearchButtonClicked_positive_searchBarResignFirstResponderCalled
{
    //given
    UISearchBar* searchBar = [UISearchBar new];
    id mockedSearchBar = OCMPartialMock(searchBar);
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    OCMExpect([mockedSearchBar resignFirstResponder]);
    
    //when
    [searchManager searchBarSearchButtonClicked:mockedSearchBar];
    
    //then
    OCMVerifyAll(mockedSearchBar);
}

- (void)test_searchBarSearchButtonClicked_positive_setShowsCancelButtonCalled
{
    //given
    UISearchBar* searchBar = [UISearchBar new];
    id mockedSearchBar = OCMPartialMock(searchBar);
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    OCMExpect([mockedSearchBar setShowsCancelButton:NO animated:YES]);
    
    //when
    [searchManager searchBarSearchButtonClicked:mockedSearchBar];
    
    //then
    OCMVerifyAll(mockedSearchBar);
}

- (void)test_searchBarTextDidBeginEditing_positive_setShowsCancelButtonCalledWithPositiveValue
{
    //given
    UISearchBar* searchBar = [UISearchBar new];
    id mockedSearchBar = OCMPartialMock(searchBar);
    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
    OCMExpect([mockedSearchBar setShowsCancelButton:YES animated:YES]);
    
    //when
    [searchManager searchBarTextDidBeginEditing:mockedSearchBar];
    
    //then
    OCMVerifyAll(mockedSearchBar);
}


#pragma mark - ANListControllerSearchManagerDelegate

- (void)searchControllerDidCancelSearch
{
	
}

- (void)searchControllerRequiresStorageWithSearchString:(__unused NSString*)searchString
                                               andScope:(__unused NSInteger)scope
{
	
}

@end
