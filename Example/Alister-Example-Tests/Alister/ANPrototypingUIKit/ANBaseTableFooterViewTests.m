//
//  ANBaseTableFooterViewTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANBaseTableFooterView.h"

static BOOL const kIsTransparent = YES;

@interface ANBaseTableFooterViewTests : XCTestCase

@property (nonatomic, strong) ANBaseTableFooterView* view;

@end

@implementation ANBaseTableFooterViewTests

- (void)setUp
{
    [super setUp];
    self.view = [ANBaseTableFooterView new];
    self.view.isTransparent = kIsTransparent;
}

- (void)tearDown
{
    self.view = nil;
    [super tearDown];
}

- (void)test_isTransparent_positive_valueIsSetRight
{
    expect(self.view.isTransparent).equal(kIsTransparent);
}

@end
