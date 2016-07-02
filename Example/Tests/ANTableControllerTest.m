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
#import "Expecta.h"
#import "ANTestTableCell.h"

@interface ANTableControllerTest : XCTestCase

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) UITableView* tw;
@property (nonatomic, strong) ANTableController* listController;

@end

@implementation ANTableControllerTest

- (void)setUp
{
    [super setUp];
    self.storage = [ANStorage new];
    self.tw = [UITableView new];
    self.listController = [ANTableController controllerWithTableView:self.tw];
    [self.listController attachStorage:self.storage];
}

- (void)tearDown
{//TODO: zoombie
    self.listController = nil;
    self.tw = nil;
    self.storage = nil;
    
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

- (void)testConfigureCellsWithBlockRetriveFromTabelView
{
    //given
   
    //when
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[UITableViewCell class] forSystemClass:[NSString class]];
    }];
    //then
    UITableViewCell* cell = [self.tw dequeueReusableCellWithIdentifier:NSStringFromClass([NSString class])];
    expect(cell).notTo.beNil;
    expect(cell).beKindOf([UITableViewCell class]);
}

- (void)testConfigureCellsWithBlockRetriveFromTableController
{
    //given
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"addUpdatesFinsihedTriggerBlock called"];
    
    __weak typeof(self) welf = self;
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
        ANTestTableCell* cell = (id)[welf.listController tableView:welf.tw
                                             cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        expect(cell).notTo.beNil;
        expect(cell.model).equal(testModel);
        expect(cell.textLabel.text).equal(testModel);
    }];
    
    [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)testConfigureItemSelectionBlock
{
    //given
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"configureItemSelectionBlock called"];
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

}

- (void)testAddUpdatesFinsihedTriggerBlock
{

}

- (void)testAttachSearchBar
{

}


@end
