//
//  ANStorageMovedIndexPathModelTest.m
//  Alister-Example
//
//  Created by ANODA on 8/29/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANStorageMovedIndexPathModel.h"

static NSInteger const kGeneratedLimit = 100;

@interface ANStorageMovedIndexPathModelTest : XCTestCase

@property (nonatomic, strong) ANStorageMovedIndexPathModel* model;

@end

@implementation ANStorageMovedIndexPathModelTest

- (void)setUp
{
    [super setUp];
    self.model = [ANStorageMovedIndexPathModel new];
}

- (void)tearDown
{
    self.model = nil;
    [super tearDown];
}

- (NSIndexPath*)_generatedIndexPath
{
    return [NSIndexPath indexPathForRow:arc4random_uniform(kGeneratedLimit)
                              inSection:arc4random_uniform(kGeneratedLimit)];
}


#pragma mark - Setters

- (void)test_setters_positive_propertiesSetCorrect
{
    // given
    NSIndexPath* fromPath = [self _generatedIndexPath];
    NSIndexPath* toPath = [self _generatedIndexPath];
    
    // when
    void(^testBlock)() = ^() {
        self.model.fromIndexPath = fromPath;
        self.model.toIndexPath = toPath;
        
        expect(self.model.fromIndexPath).to.equal(fromPath);
        expect(self.model.toIndexPath).to.equal(toPath);
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

@end
