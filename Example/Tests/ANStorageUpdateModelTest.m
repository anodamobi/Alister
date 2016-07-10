//
//  ANStorageUpdateModel.m
//  Alister
//
//  Created by Oksana on 7/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANStorageUpdateModel.h"

@interface ANStorageUpdateModelTest : XCTestCase

@property (nonatomic, strong) ANStorageUpdateModel* model;

@end

@implementation ANStorageUpdateModelTest

- (void)setUp
{
    [super setUp];

    self.model = [ANStorageUpdateModel new];
}

- (void)tearDown
{
    self.model = nil;
    [super tearDown];
}

- (void)test_conformsToProtocol_positive
{

}

//@property (nonatomic, assign) BOOL isRequireReload;


#pragma mark - isEmpty

- (void)test_isEmpty_positive_emptyWhenCreated
{
	
}

- (void)test_isEmpty_positive_notEmptyWhenAddItem
{
    
}

- (void)test_isEmpty_positive_notEmptyWhenNeedsReload
{
    
}


#pragma mark - isRequireReload

- (void)test_isRequireReload_positive_falseWhenCreated
{

}

- (void)test_isRequireReload_positive_falseWhenUpdateWithModelWithFalseAndNoUpdates
{
    
}

- (void)test_isRequireReload_positive_trueWhenUpdateWithModelWithTrueAndNoUpdates
{
    
}

- (void)test_isRequireReload_positive_trueWhenUpdateWithModelWithFalseAndHasUpdates
{
    
}


- (void)test_mergeWith_positive // TODO: add more conditions
{
	
}


@end
