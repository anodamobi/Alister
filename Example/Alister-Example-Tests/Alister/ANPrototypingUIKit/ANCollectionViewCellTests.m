//
//  ANCollectionViewCellTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANCollectionViewCell.h"

@interface ANCollectionViewCellTests : XCTestCase

@property (nonatomic, strong) ANCollectionViewCell* cell;

@end

@implementation ANCollectionViewCellTests

- (void)setUp
{
    [super setUp];
    self.cell = [ANCollectionViewCell new];
}

- (void)tearDown
{
    self.cell = nil;
    [super tearDown];
}


#pragma mark - updateWithModel

- (void)test_updateWithModel_positive_conformToListControllerUpdateViewInterface
{
    expect(self.cell).conformTo(@protocol(ANListControllerUpdateViewInterface));
}

- (void)test_updateWithModel_positive_calledWithoutException
{
    // given
    NSString* model = @"model";
    
    // when
    void(^testBlock)() = ^() {
        [self.cell updateWithModel:model];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_updateWithModel_negative_calledWithoutExceptionWhenModelIsNil
{
    // given
    NSString* model = nil;
    
    // when
    void(^testBlock)() = ^() {
        [self.cell updateWithModel:model];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_updateWithModel_negative_calledWithoutExceptionWhenModelIsNull
{
    // given
    NSNull* model = [NSNull null];
    
    // when
    void(^testBlock)() = ^() {
        [self.cell updateWithModel:model];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_updateWithModel_negative_calledWithoutExceptionWhenModelIsNotNSStringClass
{
    // given
    id model = [NSDictionary dictionary];
    
    // when
    void(^testBlock)() = ^() {
        [self.cell updateWithModel:model];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

@end
