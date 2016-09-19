//
//  ANListControllerMappingModelTest.m
//  Alister-Example
//
//  Created by ANODA on 8/29/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANListControllerMappingModel.h"

static NSString* const kClassIdentifier = @"kClassIdentifier";
static NSString* const kKind = @"kKind";
static BOOL const kIsSystem = YES;
static NSString* const kMappingClass = @"kMappingClass";

@interface ANListControllerMappingModelTest : XCTestCase

@property (nonatomic, strong) ANListControllerMappingModel* model;

@end

@implementation ANListControllerMappingModelTest

- (void)setUp
{
    [super setUp];
    self.model = [ANListControllerMappingModel new];
    self.model.classIdentifier = kClassIdentifier;
    self.model.kind = kKind;
    self.model.isSystem = kIsSystem;
    self.model.mappingClass = [kMappingClass class];
}

- (void)tearDown
{
    self.model = nil;
    [super tearDown];
}


#pragma mark - Setters

- (void)test_setters_positive_propertiesSetCorrect
{
    ANListControllerMappingModel* model = self.model;
    expect(model.classIdentifier).to.equal(kClassIdentifier);
    expect(model.kind).to.equal(kKind);
    expect(model.isSystem).to.equal(kIsSystem);
    expect(model.mappingClass).to.equal([kMappingClass class]);
}

@end
