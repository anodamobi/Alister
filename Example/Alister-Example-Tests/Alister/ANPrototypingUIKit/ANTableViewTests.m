            //
//  ANTableViewTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANTableView.h"
#import <Expecta/Expecta.h>
#import "OCMock.h"

@interface ANTableViewTests : XCTestCase

@property (nonatomic, strong) ANTableView* tableView;

@end

@implementation ANTableViewTests

- (void)setUp
{
    [super setUp];
    self.tableView = [ANTableView new];
}

- (void)tearDown
{
    self.tableView = nil;
    [super tearDown];
}


#pragma mark - cleanTableWithFrame: style:

- (void)test_cleanTableWithFrameStyle_positive_tableWithFrameAndStyle
{
    ANTableView* tableView = [ANTableView cleanTableWithFrame:CGRectZero
                                                        style:UITableViewStylePlain];
    expect(tableView).notTo.beNil();
}


#pragma mark - bottomStickedFooterView

- (void)test_bottomStickedFooterView_positive_tableFooterViewIsSet
{
    // Given
    UIView* bottomStickedFooterView = [UIView new];
    // When
    self.tableView.bottomStickedFooterView = bottomStickedFooterView;
    // Then
    expect(self.tableView.tableFooterView).equal(bottomStickedFooterView);
}

- (void)test_bottomStickedFooterView_negative_tableFooterViewIsNil
{
    // Given
    UIView* bottomStickedFooterView = nil;
    // When
    self.tableView.bottomStickedFooterView = bottomStickedFooterView;
    // Then
    expect(self.tableView.tableFooterView).to.beNil();
}


#pragma mark - setupAppearance

- (void)test_setupAppearance_positive_methodIsCalled
{
    // TODO: test not work
    ANTableView* tableView = [ANTableView cleanTableWithFrame:CGRectZero
                                                        style:UITableViewStyleGrouped];
    
    id mockedClass = OCMClassMock([tableView class]);
    OCMStub(ClassMethod([mockedClass cleanTableWithFrame:CGRectZero style:UITableViewStyleGrouped]));
    OCMExpect([mockedClass setupAppearance]);
    OCMVerify(mockedClass);
}

@end
