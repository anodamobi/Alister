//
//  ANTableContainerViewTest.m
//  Alister-Example
//
//  Created by ANODA on 8/25/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANTableContainerView.h"

static UITableViewStyle const kTableViewStyle = UITableViewStyleGrouped;

@interface ANTableContainerViewTest : XCTestCase

@property (nonatomic, strong) ANTableContainerView* containerView;

@end

@implementation ANTableContainerViewTest

- (void)setUp
{
    [super setUp];
    self.containerView = [ANTableContainerView new];
}

- (void)tearDown
{
    self.containerView = nil;
    [super tearDown];
}


#pragma mark - tableView

- (void)test_tableView_positive_propertySetRight
{
    // given
    ANTableView* tableView = [ANTableView new];
    
    // when
    self.containerView.tableView = tableView;
    
    // then
    expect(self.containerView.tableView).equal(tableView);
}


#pragma mark - containerWithTableViewStyle

- (void)test_containerWithTableViewStyle_positive_createdTableStyleEqualsInitialStyle
{
    // when
    ANTableContainerView* containerView = [ANTableContainerView containerWithTableViewStyle:kTableViewStyle];
    
    // then
    expect(containerView.tableView.style).equal(kTableViewStyle);
}

- (void)test_containerWithTableViewStyle_positive_initialTableViewAddedAsSubview
{
    // when
    ANTableContainerView* containerView = [ANTableContainerView containerWithTableViewStyle:kTableViewStyle];
    
    // then
    expect(containerView.subviews.firstObject).to.beKindOf([UITableView class]);
}


#pragma mark - initWithStyle

- (void)test_initWithStyle_positive_initialTableViewNotNil
{
    // when
    ANTableContainerView* containerView = [[ANTableContainerView alloc] initWithStyle:kTableViewStyle];
    
    // then
    expect(containerView.tableView).notTo.beNil();
}

- (void)test_initWithStyle_positive_initialTableViewAddedAsSubview
{
    // when
    ANTableContainerView* containerView = [[ANTableContainerView alloc] initWithStyle:kTableViewStyle];
    
    // then
    expect(containerView.subviews.firstObject).to.beKindOf([UITableView class]);
}

@end
