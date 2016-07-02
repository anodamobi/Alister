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
}

- (void)tearDown
{
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

- (void)testConfigureCellsWithBlock
{
    //given
   
    //when
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[UITableViewCell class] forSystemClass:[NSString class]];
    }];
    //then
    UITableViewCell* cell = [self.tw dequeueReusableCellWithIdentifier:NSStringFromClass([NSString class])];
    expect(cell).notTo.beNil;
}

- (void)testConfigureItemSelectionBlock
{
    //given
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forSystemClass:[NSString class]];
    }];
    
    
    
    //then
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
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
    
    //when
    [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
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
