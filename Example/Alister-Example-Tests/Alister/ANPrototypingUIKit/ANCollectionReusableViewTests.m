//
//  ANCollectionReusableViewTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANCollectionReusableView.h"

@interface ANCollectionReusableViewTests : XCTestCase

@property (nonatomic, strong) ANCollectionReusableView* reusableView;

@end

@implementation ANCollectionReusableViewTests

- (void)setUp
{
    [super setUp];
    self.reusableView = [ANCollectionReusableView new];
}

- (void)tearDown
{
    self.reusableView = nil;
    [super tearDown];
}


#pragma mark - updateWithModel

- (void)test_updateWithModel_positive_respondUpdateWithModel
{
    expect(self.reusableView).respondTo(@selector(updateWithModel:));
}

- (void)test_updateWithModel_positive_unexpectedBehaviorNotHappen
{
    // given
    NSString* model = @"model";
    
    // when
    void(^testBlock)() = ^() {
        [self.reusableView updateWithModel:model];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

@end
