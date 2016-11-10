//
//  ANListControllerSearchManagerSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/9/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerSearchManager.h"
#import "ANSearchControllerDelegateFixture.h"
#import "ANStorage.h"

SpecBegin(ANListControllerSearchManager)

__block ANListControllerSearchManager* manager = nil;
__block UISearchBar* searchBar = nil;
__block ANSearchControllerDelegateFixture* delegate = nil;

NSString* scope0PredicateFormat = @"self BEGINSWITH[cd] %@";
NSString* scope1PredicateFormat = @"self CONTAINS[cd] %@";

ANListControllerSearchPredicateBlock searchPredicateConfigBlock = ^NSPredicate* (NSString* searchString, NSInteger scope) {
    
    NSPredicate* predicate = nil;
    if (searchString)
    {
        if (scope == 0)
        {
            predicate = [NSPredicate predicateWithFormat:scope0PredicateFormat, searchString];
        }
        else if (scope == 1)
        {
            predicate = [NSPredicate predicateWithFormat:scope1PredicateFormat, searchString];
        }
    }
    return predicate;
};


beforeEach(^{
    manager = [ANListControllerSearchManager new];
    searchBar = [UISearchBar new];
    delegate = [ANSearchControllerDelegateFixture new];
});

describe(@"at default state", ^{
    
    it(@"not searching", ^{
        expect(manager.isSearching).beFalsy();
    });
    
    it(@"searchingStorage is nil", ^{
        expect(manager.searchingStorage).beNil();
    });
    
    it(@"no search bar attached", ^{
        expect(manager.searchBar).beNil();
    });
    
    it(@"predicate is nil", ^{
        expect(manager.searchPredicateConfigBlock).beNil();
    });
    
    it(@"delegate is nil", ^{
        expect(manager.delegate).beNil();
    });
});

describe(@"searchBar", ^{
    
    beforeEach(^{
        manager.searchBar = searchBar;
    });
    
    it(@"has delegates", ^{
        expect(searchBar.delegate).notTo.beNil();
    });
    
    it(@"if user start enter text isSearching will be yes", ^{
        searchBar.text = [ANTestHelper randomString];
        [manager searchBar:searchBar textDidChange:searchBar.text];
        expect(manager.isSearching).beTruthy();
    });
    
    it(@"if user changes scope isSearching will be true", ^{
        [manager searchBar:searchBar selectedScopeButtonIndexDidChange:2];
        expect(manager.isSearching).beTruthy();
    });
    
    it(@"if user cancels search isSearching will be false", ^{
        [manager searchBar:searchBar selectedScopeButtonIndexDidChange:2];
        [manager searchBarCancelButtonClicked:searchBar];
        expect(manager.isSearching).beFalsy();
    });
    
    it(@"if user cancels search search bar text and scope should be default", ^{
        
        [manager searchBar:searchBar selectedScopeButtonIndexDidChange:2];
        [manager searchBar:searchBar textDidChange:[ANTestHelper randomString]];
        
        [manager searchBarCancelButtonClicked:searchBar];
        
        expect(searchBar.text.length).equal(0);
        expect(searchBar.selectedScopeButtonIndex).equal(0);
    });
});


describe(@"ANListControllerSearchManagerDelegate called", ^{

    beforeEach(^{
        manager.searchBar = searchBar;
        manager.delegate = delegate;
        manager.searchPredicateConfigBlock = searchPredicateConfigBlock;
    });
    
    it(@"if start searching will create new filtered storage", ^{
        searchBar.text = [ANTestHelper randomString];
        [manager searchBar:searchBar textDidChange:searchBar.text];
        
        expect(delegate.lastGeneratedStorage).notTo.beNil();
        expect(delegate.allGeneratedStoragesArray).haveCount(1);
    });
    
    it(@"if changed search scope will create new storage", ^{
        
        searchBar.text = [ANTestHelper randomString];
        [manager searchBar:searchBar textDidChange:searchBar.text];
        [manager searchBar:searchBar selectedScopeButtonIndexDidChange:1];
        
        expect(delegate.allGeneratedStoragesArray).haveCount(2);
        [delegate.allGeneratedStoragesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            expect(obj).notTo.beKindOf([NSNull class]);
        }];
    });
    
    it(@"if search string is empty should generate equal storage", ^{
        pending(@"Pending");
    });
    
    it(@"created storage filtered with predicate block", ^{
        //create predicate with setted block
        //create dupplicated storage
        //compare 2 storages
        //add method isEqual to storage
        pending(@"Pending");
    });
    
    it(@"if predicate is nil no storage will be created", ^{
        pending(@"Pending");
    });
    
    it(@"if user selects cancel button notfity delegate about cancel search event", ^{
        pending(@"Pending");
    });
    
    it(@"if user didn't change text or scope - not create new storage", ^{
        pending(@"Pending");
    });
    

    
    
});

describe(@"predicateBlock", ^{
    
    beforeEach(^{
        manager.searchBar = searchBar;
        manager.delegate = delegate;
        manager.searchPredicateConfigBlock = searchPredicateConfigBlock;
    });
    
    it(@"create predicate block get called when search started", ^{
        
        waitUntilTimeout(0.3, ^(DoneCallback done) {

            manager.searchPredicateConfigBlock = ^NSPredicate* (NSString* __unused searchString, NSInteger __unused scope) {
                done();
                return nil;
            };
        });
        
        searchBar.text = [ANTestHelper randomString];
        searchBar.selectedScopeButtonIndex = [ANTestHelper randomNumber].integerValue + 1;
        [manager searchBar:searchBar textDidChange:searchBar.text];
    });
    
    it(@"received correct parameters", ^{
        __block NSString* searchStringItem = @"test";
        __block NSInteger scopeItem = 2;
        
        waitUntilTimeout(0.3, ^(DoneCallback done) {
            
            manager.searchPredicateConfigBlock = ^NSPredicate* (NSString* __unused searchString, NSInteger __unused scope) {
                done();
                
                expect(searchString).equal(searchStringItem);
                expect(scope).equal(scopeItem);
                
                return nil;
            };
        });
        
        searchBar.text = searchStringItem;
        searchBar.selectedScopeButtonIndex = scopeItem;
        
        [manager searchBar:searchBar textDidChange:searchStringItem];
    });
    
    it(@"will create nil storage if predicate block is nil", ^{
        
        manager.searchPredicateConfigBlock = nil;
        
        [manager searchBar:searchBar textDidChange:[ANTestHelper randomString]];
        
        expect(delegate.lastGeneratedStorage).beNil();
        expect(delegate.allGeneratedStoragesArray).haveCount(1);
    });
    
    it(@"searchStorage contains only filtered elements", ^{
        
        NSString* searchString = @"test";
        searchBar.text = searchString;
        [manager searchBar:searchBar textDidChange:searchBar.text];
        
        NSPredicate* predicate = manager.searchPredicateConfigBlock(searchBar.text, searchBar.selectedScopeButtonIndex);
        
        [delegate.storage.sections enumerateObjectsUsingBlock:^(ANStorageSectionModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSArray* expectedObjects = [obj.objects filteredArrayUsingPredicate:predicate];
            ANStorageSectionModel* actualSeaction = delegate.lastGeneratedStorage.sections[idx];
            
            expect(expectedObjects).equal(actualSeaction.objects);
        }];
    });
});


SpecEnd


//

//describe(@"searchStorageForSearchString: inSearchScope:", ^{
//    

//    it(@"successfully created when string is nil", ^{
//        ANStorage* searchStorage = [storage searchStorageForSearchString:nil inSearchScope:0];
//        expect(searchStorage).notTo.beNil();
//    });

//    it(@"filters by predicate ", ^{
//        NSArray* itemsForScope1 = @[@"test", @"test1", @"test2", @"test4"];
//        NSArray* items = [itemsForScope1 arrayByAddingObjectsFromArray:@[@"anoda", @"tiger", @"tooth",
//                                                                         @"tool", @"something", @"anything"]];
//        
//        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
//            [storageController addItems:items];
//        }];
//        
//
//    });
//});
//
//


//
//- (void)test_delegate_positive_setupedDelegateNotNil
//{
//    //given
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    searchManager.delegate = self;
//    
//    //then
//    expect(searchManager.delegate).notTo.beNil();
//}
//
//- (void)test_isSearching_positive_returnedYesWithValidValues
//{
//    //given
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    searchManager.currentSearchString = @"search string";
//    searchManager.currentSearchScope = 2;
//    
//    //then
//    expect([searchManager isSearching]).to.beTruthy();
//}
//
//
//#pragma mark - Filter method test
//
//- (void)test_searchControllerRequiresStorageWithSearchString_positive_delegateSearchCalled
//{
//    //given
//    id mockedDelegate = OCMPartialMock(self);
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    searchManager.delegate = mockedDelegate;
//    NSString* searchString = @"search string";
//    NSInteger scopeNumber = 2;
//    searchManager.currentSearchString = @"";
//    
//    OCMExpect([mockedDelegate searchControllerRequiresStorageWithSearchString:[OCMArg any] andScope:scopeNumber]);
//    
//    //when
//    [searchManager _filterItemsForSearchString:searchString inScope:scopeNumber reload:NO];
//    
//    //then
//    OCMVerifyAll(mockedDelegate);
//}
//
//- (void)test_handleSearchWithCurrentSearchingValue_positive_delegateSearchControllerDidCancel
//{
//    //given
//    id mockedDelegate = OCMPartialMock(self);
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    searchManager.delegate = mockedDelegate;
//    searchManager.currentSearchString = @"";
//    searchManager.currentSearchScope = -1;
//    OCMExpect([mockedDelegate searchControllerDidCancelSearch]);
//    
//    //when
//    [searchManager _handleSearchWithCurrentSearchingValue:YES];
//    
//    //then
//    OCMVerifyAll(mockedDelegate);
//}
//
//- (void)test_handleSearchWithCurrentSearchingValue_positive_seachControllerRequiresStorageCalled
//{
//    //given
//    id mockedDelegate = OCMPartialMock(self);
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    searchManager.delegate = mockedDelegate;
//    searchManager.currentSearchString = @"search";
//    searchManager.currentSearchScope = 2;
//    OCMExpect([mockedDelegate searchControllerRequiresStorageWithSearchString:searchManager.currentSearchString
//                                                                     andScope:searchManager.currentSearchScope]);
//    
//    //when
//    [searchManager _handleSearchWithCurrentSearchingValue:NO];
//    
//    //then
//    OCMVerifyAll(mockedDelegate);
//}
//
//
//#pragma mark - UISearchBarDelegate methods tests
//
//- (void)test_filterItemsCalled_positive_calledFromDelegateMethodTextDidEndChange
//{
//    //given
//    NSString* searchString = @"search";
//    NSInteger scope = -1;
//    UISearchBar* searchBar = [UISearchBar new];
//    searchBar.text = searchString;
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    id mockedSearchManager = OCMPartialMock(searchManager);
//    OCMExpect([mockedSearchManager _filterItemsForSearchString:searchString inScope:scope reload:NO]);
//    
//    //when
//    [mockedSearchManager searchBar:searchBar textDidChange:searchString];
//    
//    //then
//    OCMVerifyAll(mockedSearchManager);
//}
//
//- (void)test_selectedScopeButtonIndexDidChange_positive_filterItemsForSearchStringCalled
//{
//    //given
//    NSString* searchString = @"search";
//    NSInteger scope = -1;
//    UISearchBar* searchBar = [UISearchBar new];
//    searchBar.text = searchString;
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    id mockedSearchManager = OCMPartialMock(searchManager);
//    OCMExpect([mockedSearchManager _filterItemsForSearchString:searchString inScope:scope reload:NO]);
//    
//    //when
//    [mockedSearchManager searchBar:searchBar selectedScopeButtonIndexDidChange:scope];
//    
//    //then
//    OCMVerifyAll(mockedSearchManager);
//}
//
//- (void)test_searchBarCancelButtonClicked_positive_filterItemsForSearchStringCalled
//{
//    //given
//    NSInteger scope = -1;
//    UISearchBar* searchBar = [UISearchBar new];
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    id mockedManager = OCMPartialMock(searchManager);
//    OCMExpect([mockedManager _filterItemsForSearchString:nil inScope:scope reload:NO]);
//    
//    //when
//    [searchManager searchBarCancelButtonClicked:searchBar];
//    
//    //then
//    OCMVerifyAll(mockedManager);
//}
//
//- (void)test_searchBarSearchButtonClicked_positive_searchBarResignFirstResponderCalled
//{
//    //given
//    UISearchBar* searchBar = [UISearchBar new];
//    id mockedSearchBar = OCMPartialMock(searchBar);
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    OCMExpect([mockedSearchBar resignFirstResponder]);
//    
//    //when
//    [searchManager searchBarSearchButtonClicked:mockedSearchBar];
//    
//    //then
//    OCMVerifyAll(mockedSearchBar);
//}
//
//- (void)test_searchBarSearchButtonClicked_positive_setShowsCancelButtonCalled
//{
//    //given
//    UISearchBar* searchBar = [UISearchBar new];
//    id mockedSearchBar = OCMPartialMock(searchBar);
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    OCMExpect([mockedSearchBar setShowsCancelButton:NO animated:YES]);
//    
//    //when
//    [searchManager searchBarSearchButtonClicked:mockedSearchBar];
//    
//    //then
//    OCMVerifyAll(mockedSearchBar);
//}
//
//- (void)test_searchBarTextDidBeginEditing_positive_setShowsCancelButtonCalledWithPositiveValue
//{
//    //given
//    UISearchBar* searchBar = [UISearchBar new];
//    id mockedSearchBar = OCMPartialMock(searchBar);
//    ANListControllerSearchManager* searchManager = [ANListControllerSearchManager new];
//    OCMExpect([mockedSearchBar setShowsCancelButton:YES animated:YES]);
//    
//    //when
//    [searchManager searchBarTextDidBeginEditing:mockedSearchBar];
//    
//    //then
//    OCMVerifyAll(mockedSearchBar);
//}
//
//
//#pragma mark - ANListControllerSearchManagerDelegate
//
//- (void)searchControllerDidCancelSearch
//{
//    
//}
//
//- (void)searchControllerRequiresStorageWithSearchString:(__unused NSString*)searchString
//                                               andScope:(__unused NSInteger)scope
//{
//    
//}
