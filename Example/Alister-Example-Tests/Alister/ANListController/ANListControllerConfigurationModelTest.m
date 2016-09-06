//
//  ANListControllerConfigurationModelTest.m
//  Alister-Example
//
//  Created by ANODA on 8/25/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANListControllerConfigurationModel.h"

static BOOL const kShouldHandleKeyboard = YES;
static CGFloat const kReloadAnimationDuration = 1.2f;
static CGFloat const kDefaultAnimationDuration = 2.3f;
static NSString* const kReloadAnimationKey = @"kReloadAnimationKey";

static BOOL const kShouldDisplayHeaderOnEmptySection = YES;
static BOOL const kShouldDisplayFooterOnEmptySection = YES;

static UITableViewRowAnimation const kInsertSectionAnimation = UITableViewRowAnimationMiddle;
static UITableViewRowAnimation const kDeleteSectionAnimation = UITableViewRowAnimationRight;
static UITableViewRowAnimation const kReloadSectionAnimation = UITableViewRowAnimationLeft;

static UITableViewRowAnimation const kInsertRowAnimation = UITableViewRowAnimationMiddle;
static UITableViewRowAnimation const kDeleteRowAnimation = UITableViewRowAnimationRight;
static UITableViewRowAnimation const kReloadRowAnimation = UITableViewRowAnimationLeft;

static NSString* const kDefaultHeaderSupplementary = @"kDefaultHeaderSupplementary";
static NSString* const kDefaultFooterSupplementary = @"kDefaultFooterSupplementary";

@interface ANListControllerConfigurationModelTest : XCTestCase

@property (nonatomic, strong) ANListControllerConfigurationModel* model;

@end

@implementation ANListControllerConfigurationModelTest

- (void)setUp
{
    [super setUp];
    self.model = [ANListControllerConfigurationModel new];
}

- (void)tearDown
{
    self.model = nil;
    [super tearDown];
}

- (ANListControllerConfigurationModel*)_fullModel
{
    ANListControllerConfigurationModel* model = [ANListControllerConfigurationModel new];
    
    model.shouldHandleKeyboard = kShouldHandleKeyboard;
    model.reloadAnimationDuration = kReloadAnimationDuration;
    model.reloadAnimationKey = kReloadAnimationKey;
    model.shouldDisplayHeaderOnEmptySection = kShouldDisplayHeaderOnEmptySection;
    model.shouldDisplayFooterOnEmptySection = kShouldDisplayFooterOnEmptySection;
    model.insertSectionAnimation = kInsertSectionAnimation;
    model.deleteSectionAnimation = kDeleteSectionAnimation;
    model.reloadSectionAnimation = kReloadSectionAnimation;
    
    model.insertRowAnimation = kInsertRowAnimation;
    model.deleteRowAnimation = kDeleteRowAnimation;
    model.reloadRowAnimation = kReloadRowAnimation;
    
    model.defaultHeaderSupplementary = kDefaultHeaderSupplementary;
    model.defaultFooterSupplementary = kDefaultFooterSupplementary;
    model.defaultAnimationDuration = kDefaultAnimationDuration;
    
    return model;
}


#pragma mark - setters

- (void)test_setters_positive_propertiesIsSetRight
{
    // given
    ANListControllerConfigurationModel* model = [self _fullModel];
    
    // then
    expect(model.shouldHandleKeyboard).equal(kShouldHandleKeyboard);
    expect(model.reloadAnimationDuration).equal(kReloadAnimationDuration);
    expect(model.reloadAnimationKey).equal(kReloadAnimationKey);
    expect(model.shouldDisplayHeaderOnEmptySection).equal(kShouldDisplayHeaderOnEmptySection);
    expect(model.shouldDisplayFooterOnEmptySection).equal(kShouldDisplayFooterOnEmptySection);
    expect(model.insertSectionAnimation).equal(kInsertSectionAnimation);
    expect(model.deleteSectionAnimation).equal(kDeleteSectionAnimation);
    expect(model.reloadSectionAnimation).equal(kReloadSectionAnimation);
    
    expect(model.insertRowAnimation).equal(kInsertRowAnimation);
    expect(model.deleteRowAnimation).equal(kDeleteRowAnimation);
    expect(model.reloadRowAnimation).equal(kReloadRowAnimation);
    
    expect(model.defaultHeaderSupplementary).equal(kDefaultHeaderSupplementary);
    expect(model.defaultFooterSupplementary).equal(kDefaultFooterSupplementary);
    expect(model.defaultAnimationDuration).equal(kDefaultAnimationDuration);
}


#pragma mark - ANListControllerConfigurationModelInterface

- (void)test_protocolConformation_positive_modelConformsToModelInterface
{
    expect(self.model).to.conformTo(@protocol(ANListControllerConfigurationModelInterface));
}

@end
