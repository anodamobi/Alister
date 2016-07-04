//
//  ANListControllerTest.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/2/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANTableController.h"
#import "ANStorage.h"
#import <Expecta/Expecta.h>
#import "ANTestTableCell.h"
#import "ANTestTableHeaderFooter.h"

@interface ANTableControllerTest : XCTestCase

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) UITableView* tw;
@property (nonatomic, strong) ANTableController* listController;
@property (nonatomic) dispatch_group_t dispatchGroup;

@end

@implementation ANTableControllerTest

- (void)setUp
{
    [super setUp];
    
    self.storage = [ANStorage new];
    self.tw = [UITableView new];
    self.tw.sectionHeaderHeight = 30;
    self.tw.sectionFooterHeight = 30;
    self.listController = [ANTableController controllerWithTableView:self.tw];
    [self.listController attachStorage:self.storage];
}

- (void)tearDown
{//TODO: zoombie
    self.listController = nil;
    self.tw = nil;
    self.storage = nil;
    self.dispatchGroup = nil;
    
    [super tearDown];
}

- (void)testAttachStorage
{
    //given
    ANTableController* listController = [ANTableController new];
    ANStorage* storage = [ANStorage new];
    //when
    [listController attachStorage:storage];
    //then
    expect(listController.currentStorage).notTo.beNil;
    expect(listController.currentStorage).equal(storage);
}

- (void)testConfigureItemSelectionBlock
{
    //given
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    XCTestExpectation *expectation = [self expectationWithDescription:@"configureItemSelectionBlock called"];
    __weak typeof(self) welf = self;
    
    [self.listController configureItemSelectionBlock:^(id model, NSIndexPath *indexPath) {
        [expectation fulfill];
        expect(model).equal(testModel);
        expect(indexPath.row).equal(0);
        expect(indexPath.section).equal(0);
    }];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [welf.listController tableView:welf.tw
               didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }];
    
    [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testUpdateConfigurationModelWithBlock
{
    //given
    XCTestExpectation *expectation = [self expectationWithDescription:@"updateConfigurationModelWithBlock called"];

    //when
    [self.listController updateConfigurationModelWithBlock:^(ANListControllerConfigurationModel *configurationModel) {
        configurationModel.shouldHandleKeyboard = NO;
        configurationModel.shouldDisplayHeaderOnEmptySection = NO;
    }];
    
    [self.listController updateConfigurationModelWithBlock:^(ANListControllerConfigurationModel *configurationModel) {
        [expectation fulfill];
        expect(configurationModel.shouldHandleKeyboard).beFalsy();
        expect(configurationModel.shouldDisplayHeaderOnEmptySection).beFalsy();
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}


- (void)testAddUpdatesFinsihedTriggerBlock
{
    //given
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"testAddUpdatesFinsihedTriggerBlock called"];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
    }];
    
    [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testAttachSearchBar
{
    //given
    UISearchBar* searchBar = [UISearchBar new];
    //when
    [self.listController attachSearchBar:searchBar];
    //then
    expect(self.listController.searchBar).notTo.beNil();
    expect(self.listController.searchBar).equal(searchBar);
}

- (void)testControllerWithTableView
{
    //when
    ANTableController* tc = [ANTableController controllerWithTableView:self.tw];
    //then
    expect(tc.tableView).notTo.beNil();
    expect(tc.tableView).equal(self.tw);
}

- (void)testInitWithTableView
{
    //when
    ANTableController* tc = [[ANTableController alloc] initWithTableView:self.tw];
    //then
    expect(tc.tableView).notTo.beNil();
    expect(tc.tableView).equal(self.tw);
}

@end
