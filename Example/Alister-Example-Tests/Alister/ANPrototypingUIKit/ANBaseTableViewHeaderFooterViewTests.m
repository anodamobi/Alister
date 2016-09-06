//
//  ANBaseTableViewHeaderFooterViewTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANBaseTableViewHeaderFooterView.h"

@interface ANBaseTableViewHeaderFooterViewTests : XCTestCase

@property (nonatomic, strong) ANBaseTableViewHeaderFooterView* view;

@end

@implementation ANBaseTableViewHeaderFooterViewTests

- (void)setUp
{
    [super setUp];
    self.view = [ANBaseTableViewHeaderFooterView new];
}

- (void)tearDown
{
    self.view = nil;
    [super tearDown];
}


#pragma mark - Tests

- (void)test_updateWithModel_positive_textLabelTextEqualModel
{
    // given
    NSString* model = @"model";
    // when
    [self.view updateWithModel:model];
    // then
    expect(self.view.textLabel.text).to.equal(model);
}

- (void)test_updateWithModel_negative_calledWithoutExceptionWhenModelIsNotNSStringClass
{
    // given
    id model = [NSDictionary dictionary];
    // when
    void(^testBlock)() = ^() {
        [self.view updateWithModel:model];
    };
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_updateWithModel_negative_textLabelTextIsNilWhenModelIsNull
{
    // given
    NSNull* model = [NSNull null];
    // when
    [self.view updateWithModel:model];
    // then
    expect(self.view.textLabel.text).to.beNil();
}

- (void)test_updateWithModel_negative_textLabelTextIsNilWhenModelIsNil
{
    // given
    id model = nil;
    // when
    [self.view updateWithModel:model];
    // then
    expect(self.view.textLabel.text).to.beNil();
}

- (void)test_updateWithModel_positive_noCrashWhenUpdateWithModelCalled
{
    expect(self.view).to.respondTo(@selector(updateWithModel:));
}

@end
