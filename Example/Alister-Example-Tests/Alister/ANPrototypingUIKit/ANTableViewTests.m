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


#pragma mark - cleanTableWithFrameStyle

- (void)test_cleanTableWithFrameStyle_positive_tableWithFrameAndStyle
{
    // Given
    ANTableView* tableView = [ANTableView cleanTableWithFrame:CGRectZero
                                                        style:UITableViewStylePlain];
    // Then
    expect(tableView).notTo.beNil();
}


//#pragma mark - bottomStickedFooterView

//TODO:


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
