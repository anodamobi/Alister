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
    //when
    BOOL conformsToProtocol = [self.model conformsToProtocol:@protocol(ANStorageUpdateModelInterface)];
    
    //then
    XCTAssertTrue(conformsToProtocol);
}

//@property (nonatomic, assign) BOOL isRequireReload;


#pragma mark - isEmpty

- (void)test_isEmpty_positive_emptyWhenCreated
{
    //given
    ANStorageUpdateModel* testModel = [ANStorageUpdateModel new];
   
    //then
    XCTAssertTrue([testModel isEmpty]);
}

- (void)test_isEmpty_positive_notEmptyWhenAddItem
{
    //given
    [self.model mergeWith:[self _fullTestModel]];
    
    //when
    
    //then
    XCTAssertFalse([self.model isEmpty]);
}

- (void)test_isEmpty_positive_notEmptyWhenNeedsReload
{
//    [self.model mergeWith:[self _fullTestModel]];
//    [self.model setIsRequireReload:YES];
//    
//    BOOL isEmpty = [self.model isEmpty];
//    NSLog(@"");
}


#pragma mark - isRequireReload

- (void)test_isRequireReload_positive_falseWhenCreated
{
    //given
    ANStorageUpdateModel*  testModel = [ANStorageUpdateModel new];
    
    //then
    XCTAssertFalse(testModel.isRequireReload);
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
    
    //given
    XCTAssertTrue([self.model isEmpty]);
    
    //when
    [self.model mergeWith:[self _fullTestModel]];
    
    //then
    XCTAssertFalse([self.model isEmpty]);
}


- (id<ANStorageUpdateModelInterface>)_fullTestModel
{
    ANStorageUpdateModel* testModel = [ANStorageUpdateModel new];
    
    [testModel addInsertedSectionIndexes:[NSIndexSet indexSetWithIndex:1]];
    [testModel addUpdatedSectionIndexes:[NSIndexSet indexSetWithIndex:1]];
    [testModel addDeletedSectionIndexes:[NSIndexSet indexSetWithIndex:1]];
    
    [testModel addInsertedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    [testModel addUpdatedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    [testModel addDeletedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    [testModel addMovedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    
    return testModel;
}

@end
