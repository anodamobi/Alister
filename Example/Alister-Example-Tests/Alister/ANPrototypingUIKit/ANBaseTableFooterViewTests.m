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


#pragma mark - Setters

- (void)test_isTransparent_positive_valueSetCorrectly
{
    expect(self.view.isTransparent).equal(kIsTransparent);
}

- (void)test_isTransparent_positive_backgroundColorIsTransparent
{
    // when
    self.view.isTransparent = YES;
    
    // then
    expect(self.view.backgroundView).notTo.beNil();
}

@end
