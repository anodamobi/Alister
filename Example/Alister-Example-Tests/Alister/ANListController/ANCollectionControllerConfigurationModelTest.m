//
//  ANCollectionControllerConfigurationModelTest.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANCollectionControllerConfigurationModel.h"

static BOOL const kIsHandlingKeyboard = YES;
static CGFloat const kReloadAnimationDuration = 0.3f;
static NSString* const kReloadAnimationKey = @"kReloadAnimationKey";

@interface ANCollectionControllerConfigurationModelTest : XCTestCase

@property (nonatomic, strong) ANCollectionControllerConfigurationModel* model;

@end

@implementation ANCollectionControllerConfigurationModelTest

- (void)setUp
{
    [super setUp];
    self.model = [ANCollectionControllerConfigurationModel new];
    self.model.isHandlingKeyboard = kIsHandlingKeyboard;
    self.model.reloadAnimationDuration = kReloadAnimationDuration;
    self.model.reloadAnimationKey = kReloadAnimationKey;
}

- (void)tearDown
{
    self.model = nil;
    [super tearDown];
}


#pragma mark - Tests

- (void)test_defaultModel_positive_propertiesAreCorrect
{
    // when
    id model = [ANCollectionControllerConfigurationModel defaultModel];
    //then
    expect(model).notTo.beNil();
    expect(self.model.isHandlingKeyboard).to.equal(kIsHandlingKeyboard);
    expect(self.model.reloadAnimationDuration).to.equal(kReloadAnimationDuration);
    expect(self.model.reloadAnimationKey).to.equal(kReloadAnimationKey);
}

@end
