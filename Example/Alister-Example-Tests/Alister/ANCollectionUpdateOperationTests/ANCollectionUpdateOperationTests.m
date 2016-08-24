//
//  ANCollectionUpdateOperationTests.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "ANTestableCollectionUpdateOperation.h"

@interface ANCollectionControllerUpdateOperation ()



@end

@interface ANCollectionUpdateOperationTests : XCTestCase <ANListControllerUpdateOperationDelegate>

@property (nonatomic, strong) ANTestableCollectionUpdateOperation* operaton;

@end

@implementation ANCollectionUpdateOperationTests

- (void)setUp {
    [super setUp];
    self.operaton = [ANTestableCollectionUpdateOperation new];
}

- (void)tearDown
{
    self.operaton = nil;
    [super tearDown];
}

- (void)test_shouldAnimatePropertySetuped_positive_valueSetupedSuccessfully
{
    self.operaton.shouldAnimate = YES;
    expect(self.operaton.shouldAnimate).to.beTruthy();
}

- (void)test_delegatePropertySetuped_positive_delegateSetupedSuccessfully
{
    self.operaton.delegate = self;
    expect(self.operaton.delegate).notTo.beNil();
    expect(self.operaton.delegate).equal(self);
}


#pragma mark - ANListControllerUpdateOperationDelegate

- (UIView<ANListViewInterface> *)listView
{
    return nil;
}

- (id<ANListControllerConfigurationModelInterface>)configurationModel
{
    return nil;
}

- (void)storageNeedsReloadWithIdentifier:(NSString *)identifier
{

}

@end
