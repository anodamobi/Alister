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

ANListControllerSearchPredicateBlock searchPredicateConfigBlock = ^NSPredicate* (NSString* searchString, NSInteger scope) {
    
    NSPredicate* predicate = nil;
    if (searchString)
    {
        predicate = [NSPredicate predicateWithFormat:scope0PredicateFormat, searchString];
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


describe(@"delegate", ^{
    
    it(@"sets delegate successfully when conform to protocol", ^{
        manager.delegate = delegate;
        expect(manager.delegate).equal(delegate);
    });
    
    it(@"doesn't update delegate when it not conform to protocol", ^{
        id delegateNotValid = (id)[NSObject new];
        manager.delegate = delegateNotValid;
        
        expect(manager.delegate).beNil();
    });
    
    it(@"sets to nil after exising delegate", ^{
        manager.delegate = delegate;
        manager.delegate = nil;
        
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
        expect(searchBar.selectedScopeButtonIndex).equal(ANListControllerSearchScopeNone);
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
    
    it(@"if user selects cancel button notfity delegate about cancel search event", ^{
        searchBar.text = [ANTestHelper randomString];
        [manager searchBar:searchBar textDidChange:searchBar.text];
        [manager searchBarCancelButtonClicked:searchBar];
        
        expect(delegate.cancelCount).equal(1);
    });
});

describe(@"predicateBlock", ^{
    
    beforeEach(^{
        manager.searchBar = searchBar;
        manager.delegate = delegate;
        manager.searchPredicateConfigBlock = searchPredicateConfigBlock;
    });
    
    it(@"create predicate block get called when search started", ^{
        
        __block NSInteger calls = 0;
        
        manager.searchPredicateConfigBlock = ^NSPredicate* (NSString* __unused searchString, NSInteger __unused scope) {
            calls ++;
            return nil;
        };
        
        searchBar.text = [ANTestHelper randomString];
        searchBar.selectedScopeButtonIndex = [ANTestHelper randomNumber].integerValue + 1;
        [manager searchBar:searchBar textDidChange:searchBar.text];
        
        waitUntilTimeout(0.1, ^(DoneCallback done) {
            done();
            expect(calls).equal(1);
        });
    });
    
    it(@"received correct parameters", ^{
        __block NSString* searchStringItem = @"test";
        __block NSInteger scopeItem = 2;
        
        manager.searchPredicateConfigBlock = ^NSPredicate* (NSString* __unused searchString, NSInteger __unused scope) {

            expect(searchString).equal(searchStringItem);
            expect(scope).equal(scopeItem);
            
            return nil;
        };
        
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
    
    it(@"if user didn't change text or scope - not create new storage", ^{
        
        NSString* searchString = @"test";
        searchBar.text = searchString;
        
        [manager searchBar:searchBar textDidChange:searchBar.text];
        [manager searchBar:searchBar textDidChange:searchBar.text];
        
        expect(delegate.allGeneratedStoragesArray).haveCount(1);
    });
});


describe(@"cancel button behavior", ^{
    
    beforeEach(^{
        manager.searchBar = searchBar;
    });
    
    it(@"should be hidden by default", ^{
        expect(searchBar.showsCancelButton).beFalsy();
    });
    
    it(@"should be visible when user start searching", ^{
        [manager searchBarTextDidBeginEditing:searchBar];
        expect(searchBar.showsCancelButton).beTruthy();
    });
    
    it(@"should be hiden when user press search button", ^{
        [manager searchBarTextDidBeginEditing:searchBar];
        [manager searchBarSearchButtonClicked:searchBar];
        
        expect(searchBar.showsCancelButton).beFalsy();
    });
    
    it(@"should be hidden if user cancels search", ^{
        [manager searchBarTextDidBeginEditing:searchBar];
        [manager searchBarCancelButtonClicked:searchBar];
        
        expect(searchBar.showsCancelButton).beFalsy();
    });
    
    it(@"should remove focus from searchBar when user press cancel button", ^{
       
        id mockedSearchBar = OCMPartialMock(searchBar);
        manager.searchBar = mockedSearchBar;
        
        OCMExpect([mockedSearchBar resignFirstResponder]);
        
        [manager searchBarSearchButtonClicked:mockedSearchBar];
        
        OCMVerifyAll(mockedSearchBar);
    });
});

SpecEnd
