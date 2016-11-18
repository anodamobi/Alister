//
//  ANListControllerSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/5/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerFixture.h"
#import "ANListViewInterface.h"
#import <XCTest/XCTest.h>
#import "ANListController.h"
#import "ANListController+Interitance.h"
#import "ANListViewFixture.h"
#import "ANListControllerSearchManager.h"
#import "ANListControllerReusableInterface.h"

@interface ANListControllerTest : XCTestCase

@property (nonatomic, strong) ANListControllerFixture* controller;
@property (nonatomic, strong) ANListViewFixture* listView;
@property (nonatomic, strong) id itemsHandler;
@property (nonatomic, strong) id storage;
@property (nonatomic, strong) id updateService;
@property (nonatomic, strong) id searchManager;

@end

@implementation ANListControllerTest

- (void)setUp
{
    [super setUp];
    self.listView = [ANListViewFixture new];
    self.controller = [[ANListControllerFixture alloc] initWithListView:self.listView];
    self.itemsHandler = OCMProtocolMock(@protocol(ANListControllerReusableInterface));
    self.updateService = OCMProtocolMock(@protocol(ANStorageUpdateEventsDelegate));
    self.storage = OCMClassMock([ANStorage class]);
    self.searchManager = OCMClassMock([ANListControllerSearchManager class]);
    
    self.controller.itemsHandler = self.itemsHandler;
    self.controller.updateService = self.updateService;
    self.controller.searchManager = self.searchManager;
}

- (void)tearDown
{
    self.controller = nil;
    self.listView = nil;
    self.storage = nil;
    self.itemsHandler = nil;
    [super tearDown];
}

- (void)testDefaultState
{
    expect(self.controller.currentStorage).beNil();
}

- (void)test_currentStorage_shouldBeEqualToAttachedIfNoSearch
{
    id storage = [self _attachStorageAndSetIsSearchingValueTo:NO];
    expect(self.controller.currentStorage).equal(storage);
}

- (void)test_currentStorage_shouldNotBeEqualToAttachedIfSearching
{
    id storage = [self _attachStorageAndSetIsSearchingValueTo:YES];
    expect(self.controller.currentStorage).notTo.equal(storage);
}

- (void)test_configureCellsWithBlock_shouldExecuteAndPassConfigurator
{
    waitUntilTimeout(0.1, ^(DoneCallback done) {
        
        [self.controller configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
            done();
            expect(self.itemsHandler).equal(configurator);
        }];
    });
}

- (void)test_attachStorage_shouldEqualCurrentIfNoActiveSearch
{
    [self.controller attachStorage:self.storage];
    expect(self.controller.currentStorage).equal(self.storage);
}

- (void)test_attachStorage_shouldSetDelegate
{
    [self.controller attachStorage:self.storage];
    OCMVerify([self.storage setUpdatesHandler:self.updateService]);
}

- (void)test_attachStorage_shouldBeReloaded
{
    ANStorage* storageMock = OCMClassMock([ANStorage class]);
    [self.controller attachStorage:storageMock];
    
    OCMVerify([self.listView reloadData]);
}

- (void)test_attachSearchBar_shouldUpdateSearchManager
{
    UISearchBar* searchBar = [UISearchBar new];
    [self.controller attachSearchBar:searchBar];
    
    OCMVerify([self.searchManager setSearchBar:searchBar]);
}

- (void)test_configureCellsWithBlock_shouldNotRaiseIfNil
{
    void(^block)() = ^() {
        [self.controller configureCellsWithBlock:nil];
    };
    expect(block).notTo.raiseAny();
}

- (void)test_configureCellsWithBlock_shouldProvideItemsHandler
{
    __block BOOL wasCalled = NO;
    ANListControllerCellConfigurationBlock block = ^(id<ANListControllerReusableInterface> configurator) {
        wasCalled = YES;
        expect(configurator).equal(self.itemsHandler);
    };
    [self.controller configureCellsWithBlock:block];
    
    expect(wasCalled).beTruthy();
}

- (void)test_configureItemSelectionBlock_shouldBeEqualToPropertyAfterSet
{
    ANListControllerItemSelectionBlock block = ^(id model, NSIndexPath *indexPath) {
        
    };
    [self.controller configureItemSelectionBlock:block];
    
    expect(block).equal(self.controller.selectionBlock);
}

- (void)test_addUpdatesFinishedTriggerBlock_shouldNotRaiseIfNil
{
    [self.controller addUpdatesFinishedTriggerBlock:nil];
    void(^block)() = ^() {
        [self.controller allUpdatesFinished];
    };
    expect(block).notTo.raiseAny();
}

- (void)test_addUpdatesFinishedTriggerBlock_shouldCalledWhenDelegateMethodInvoked
{
    __block BOOL wasCalled = NO;
    [self.controller addUpdatesFinishedTriggerBlock:^{
        wasCalled = YES;
    }];
    [self.controller allUpdatesFinished];
    
    expect(wasCalled).beTruthy();
}


- (void)test_updateSearchingPredicateBlock_shouldPassItToSearchManager
{
    ANListControllerSearchPredicateBlock searchBlock = ^NSPredicate *(NSString *searchString, NSInteger scope) {
        return [NSPredicate predicateWithValue:YES];
    };
    
    [self.controller updateSearchingPredicateBlock:searchBlock];
    
    OCMVerify([self.searchManager setSearchPredicateConfigBlock:searchBlock]);
}

- (void)test_searchControllerDidCancelSearch_shouldSetUpdatesHandler
{
    [self.controller attachStorage:self.storage];
    [self.controller searchControllerDidCancelSearch];
    OCMVerify([self.storage setUpdatesHandler:self.controller.updateService]);
}

- (void)test_searchControllerCreatedStorage_shouldSetUpdatesHandlerAndReload
{
    NSString* identifier = [ANTestHelper randomString];
    
    id searchStorage = OCMClassMock([ANStorage class]);
    [OCMStub([searchStorage identifier]) andReturn:identifier];
    [self.controller searchControllerCreatedStorage:searchStorage];
    
    OCMVerify([searchStorage setUpdatesHandler:self.updateService]);
    OCMVerify([self.updateService storageNeedsReloadWithIdentifier:identifier animated:NO]);
}


#pragma mark - Helpers

- (id)_attachStorageAndSetIsSearchingValueTo:(BOOL)isSearching
{
    id storage = OCMClassMock([ANStorage class]);
    [self.controller attachStorage:storage];
    [OCMStub([self.searchManager isSearching]) andReturnValue:OCMOCK_VALUE(isSearching)];
    
    return storage;
}


@end
