//
//  ANTableControllerItemsRegistrationTest.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/4/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANTableController.h"
#import <Alister/ANStorage.h>
#import "ANTestTableCell.h"
#import "ANTestTableHeaderFooter.h"
#import "ANTestViewModel.h"

@interface ANTableControllerItemsRegistrationTest : XCTestCase

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) UITableView* tw;
@property (nonatomic, strong) ANTableController* listController;

@end

@implementation ANTableControllerItemsRegistrationTest

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
{
    self.listController = nil;
    self.tw = nil;
    self.storage = nil;
    
    [super tearDown];
}

- (void)_setAsSystemHeader:(id)object
{
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerHeaderClass:[ANTestTableHeaderFooter class] forSystemClass:[object class]];
    }];
    
    //when
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController setSectionHeaderModel:object forSectionIndex:0];
    }];
}

- (void)_setAsCustomHeader:(id)object
{
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerHeaderClass:[ANTestTableHeaderFooter class] forModelClass:[object class]];
    }];
    
    //when
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController setSectionHeaderModel:object forSectionIndex:0];
    }];
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"

- (void)testTitleForHeaderInSectionForSystemAsExpect
{
    //given
    NSString* testModel = @"Mock";
    XCTestExpectation* expectation = [self expectationWithDescription:@"testTitleForHeaderInSectionForSystemAsExpect"];
    __weak typeof(self) welf = self;
    
    //when
    [self _setAsSystemHeader:testModel];

    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        typeof (self) strongSelf = welf;
        [expectation fulfill];
        
        NSString* titleHeader = [strongSelf.listController tableView:strongSelf.tw titleForHeaderInSection:0];
        expect(titleHeader).beNil();
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testTitleForHeaderInSectionForSystemWhenExpectView
{
    //given
    NSNumber* testNotAStringModel = @34;
    XCTestExpectation* expectation = [self expectationWithDescription:@"testTitleForHeaderInSectionForSystemWhenExpectView"];
    __weak typeof(self) welf = self;
    
    //when
    [self _setAsSystemHeader:testNotAStringModel];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        typeof (self) strongSelf = welf;
        [expectation fulfill];
        
        NSString* emptyTitleHeader = [strongSelf.listController tableView:strongSelf.tw titleForHeaderInSection:0];
        expect(emptyTitleHeader).to.beNil();
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testViewForHeaderInSectionForSystemClassAsExpect
{
    //given
    NSNumber* testModel = @123;
    XCTestExpectation* expectation = [self expectationWithDescription:@"testViewForHeaderInSectionForSystemClassAsExpect"];
    __weak typeof(self) welf = self;
    
    //when
    [self _setAsSystemHeader:testModel];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        typeof (self) strongSelf = welf;
        [expectation fulfill];
        
        ANTestTableHeaderFooter* header = (ANTestTableHeaderFooter*)[strongSelf.listController
                                                                     tableView:strongSelf.tw
                                                                     viewForHeaderInSection:0];
        expect(header).willNot.beNil();
        expect(header.model).equal(testModel);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testTitleForHeaderInSectionNotRegisteredAsExpected
{
    //given
    NSString* testModel = @"Mock";
    XCTestExpectation* expectation = [self expectationWithDescription:@"testTitleForHeaderInSectionNotRegisteredAsExpected"];
    __weak typeof(self) welf = self;
    
    //when
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController setSectionHeaderModel:testModel forSectionIndex:0];
    }];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        typeof (self) strongSelf = welf;
        [expectation fulfill];
        NSString* titleHeader = [strongSelf.listController tableView:strongSelf.tw titleForHeaderInSection:0];
        expect(titleHeader).notTo.beNil();
        expect(titleHeader).equal(testModel);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testViewForHeaderInSectionForCustomClassAsExpect
{
    //given
    ANTestViewModel* testModel = [ANTestViewModel new];
    XCTestExpectation* expectation = [self expectationWithDescription:@"testViewForHeaderInSectionForCustomClassAsExpect"];
    __weak typeof(self) welf = self;
    
    //when
    [self _setAsCustomHeader:testModel];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        typeof (self) strongSelf = welf;
        [expectation fulfill];
        
        ANTestTableHeaderFooter* header = (ANTestTableHeaderFooter*)[strongSelf.listController tableView:strongSelf.tw viewForHeaderInSection:0];
        expect(header).willNot.beNil();
        expect(header.model).equal(testModel);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}


#pragma mark - Footer

- (void)_setAsSystemFooter:(id)object
{
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerFooterClass:[ANTestTableHeaderFooter class] forSystemClass:[object class]];
    }];
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController setSectionFooterModel:object forSectionIndex:0];
    }];
}

- (void)_setAsCustomFooter:(id)object
{
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerFooterClass:[ANTestTableHeaderFooter class] forModelClass:[object class]];
    }];
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController setSectionFooterModel:object forSectionIndex:0];
    }];
}

- (void)testTitleForFooterInSectionForSystemAsExpect
{
    //given
    NSString* testModel = @"Mock";
    XCTestExpectation* expectation = [self expectationWithDescription:@"testTitleForFooterInSectionForSystemAsExpect"];
    __weak typeof(self) welf = self;
    
    //when
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController setSectionFooterModel:testModel forSectionIndex:0];
    }];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
        __strong typeof(welf) strongSelf = welf;
        NSString* footer = [strongSelf.listController tableView:strongSelf.tw titleForFooterInSection:0];
        expect(footer).notTo.beNil();
        expect(footer).equal(testModel);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testTitleForFooterInSectionForSystemWhenExpectView
{
    //given
    NSNumber* testNotAStringModel = @34;
    XCTestExpectation* expectation = [self expectationWithDescription:@"testTitleForFooterInSectionForSystemWhenExpectView"];
    __weak typeof(self) welf = self;
    
    //when
    [self _setAsSystemFooter:testNotAStringModel];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
        __strong typeof(welf) strongSelf = welf;
        NSString* footer = [strongSelf.listController tableView:strongSelf.tw titleForFooterInSection:0];
        expect(footer).to.beNil();
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testViewForFooterInSectionForSystemClassAsExpect
{
    //given
    NSNumber* testModel = @123;
    XCTestExpectation* expectation = [self expectationWithDescription:@"testViewForFooterInSectionForSystemClassAsExpect"];
    __weak typeof(self) welf = self;
    
    //when
    [self _setAsSystemFooter:testModel];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
        __strong typeof(welf) strongSelf = welf;
        ANTestTableHeaderFooter* footer = (ANTestTableHeaderFooter*)[strongSelf.listController tableView:strongSelf.tw viewForFooterInSection:0];
        expect(footer).willNot.beNil();
        expect(footer.model).equal(testModel);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testTitleForFooterInSectionNotRegisteredAsExpected
{
    //given
    NSString* testModel = @"Mock";
    XCTestExpectation* expectation = [self expectationWithDescription:@"testTitleForFooterInSectionNotRegisteredAsExpected"];
    __weak typeof(self) welf = self;
    
    //when
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController setSectionFooterModel:testModel forSectionIndex:0];
    }];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
        __strong typeof(welf) strongSelf = welf;
        NSString* footer = [strongSelf.listController tableView:strongSelf.tw titleForFooterInSection:0];
        expect(footer).notTo.beNil();
        expect(footer).equal(testModel);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testViewForFooterInSectionForCustomClassAsExpect
{
    //given
    ANTestViewModel* testModel = [ANTestViewModel new];
    XCTestExpectation* expectation = [self expectationWithDescription:@"testViewForFooterInSectionForCustomClassAsExpect"];
    __weak typeof(self) welf = self;
    
    //when
    [self _setAsCustomFooter:testModel];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
        __strong typeof(welf) strongSelf = welf;
        ANTestTableHeaderFooter* footer = (ANTestTableHeaderFooter*)[strongSelf.listController tableView:strongSelf.tw viewForFooterInSection:0];
        expect(footer).notTo.beNil();
        expect(footer.model).equal(testModel);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testConfigureCellsWithBlockRetriveFromTabelView
{
    //given
    
    //when
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[UITableViewCell class] forSystemClass:[NSString class]];
    }];
    //then
    UITableViewCell* cell = [self.tw dequeueReusableCellWithIdentifier:NSStringFromClass([NSString class])];
    expect(cell).notTo.beNil();
    expect(cell).beKindOf([UITableViewCell class]);
}

- (void)testConfigureCellsWithBlockRegisterForSystemClassAsExpect
{
    //given
    NSString* testModel = @"Mock";
    __weak typeof(self) welf = self;
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    XCTestExpectation* expectation = [self expectationWithDescription:@"testConfigureCellsWithBlockRegisterForSystemClassAsExpect called"];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        
        [expectation fulfill];
        __strong typeof(welf) strongSelf = welf;
        ANTestTableCell* cell = (id)[strongSelf.listController tableView:strongSelf.tw
                                        cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        expect(cell).notTo.beNil();
        expect(cell.model).equal(testModel);
    }];
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testConfigureCellsWithBlockRegisterForCustomClassAsExpect
{
    //given
    ANTestViewModel* testModel = [ANTestViewModel new];
    __weak typeof(self) welf = self;
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[ANTestViewModel class]];
    }];
    
    //when
    XCTestExpectation* expectation = [self expectationWithDescription:@"testConfigureCellsWithBlockRegisterForCustomClassAsExpect called"];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        
        [expectation fulfill];
        __strong typeof(welf) strongSelf = welf;
        ANTestTableCell* cell = (id)[strongSelf.listController tableView:strongSelf.tw
                                             cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        expect(cell).notTo.beNil();
        expect(cell.model).equal(testModel);
    }];
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}


#pragma clang diagnostic pop

@end
