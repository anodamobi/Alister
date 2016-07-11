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
    //given
    self.model.isRequireReload = YES;
    ANStorageUpdateModel* testModel = [self _fullTestModel];
    testModel.isRequireReload = NO;
    
    //when
    [self.model mergeWith:testModel];
    
    //then
    XCTAssertTrue(self.model.isRequireReload);
    
}

- (void)test_isRequireReload_positive_trueWhenUpdateWithModelWithTrueAndNoUpdates
{
    //given
    self.model.isRequireReload = YES;
    ANStorageUpdateModel* testModel = [self _fullTestModel];
    testModel.isRequireReload = YES;
    
    //when
    [self.model mergeWith:testModel];
    
    //then
    XCTAssertTrue(self.model.isRequireReload);
}

- (void)test_isRequireReload_positive_trueWhenUpdateWithModelWithFalseAndHasUpdates
{
    //given
    self.model.isRequireReload = NO;
    ANStorageUpdateModel* testModel = [self _fullTestModel];
    testModel.isRequireReload = YES;
    
    //when
    [self.model mergeWith:testModel];
    
    //then
    XCTAssertTrue(self.model.isRequireReload);
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


#pragma mark - Model updated with Sections

- (void)test_deletedSection_positive_beforeMergeZeroAfterMergeHasObject
{
    //given
    
    //when
    [self.model mergeWith:[self _fullTestModel]];
    
    //then
    id array = self.model.deletedSectionIndexes;
    XCTAssertNotNil(array);
}

- (void)test_updatedSection_positive_beforeMergeZeroAfterMergeHasObject
{
    //when
    [self.model mergeWith:[self _fullTestModel]];
    
    //then
    id array = self.model.updatedSectionIndexes;
    XCTAssertNotNil(array);
}

- (void)test_insertedSection_positive_beforeMergeZeroAfterMergeHasObject
{
    //when
    [self.model mergeWith:[self _fullTestModel]];
    
    //then
    id array = self.model.insertedSectionIndexes;
    XCTAssertNotNil(array);
}


#pragma mark - Model updated with Full Test Models, index path tests

- (void)test_insertedIndexPaths_positive_hasIndexesAfterMerge
{
    //when
    [self.model mergeWith:[self _fullTestModel]];
    
    //then
    id insertedIndexes = self.model.insertedRowIndexPaths;
    XCTAssertNotNil(insertedIndexes);
}

- (void)test_updatedIndexPaths_positive_hasIndexesAfterMerge
{
    //when
    [self.model mergeWith:[self _fullTestModel]];
    
    //then
    id updatedIndexes = self.model.updatedRowIndexPaths;
    XCTAssertNotNil(updatedIndexes);
}

- (void)test_deletedIndexPaths_positive_hasIndexesAfterMerge
{
    //when
    [self.model mergeWith:[self _fullTestModel]];
    
    //then
    id deletedIndexes = self.model.deletedRowIndexPaths;
    XCTAssertNotNil(deletedIndexes);
}

- (void)test_movedIndexPaths_positive_hasIndexesAfterMerge
{
    //when
    [self.model mergeWith:[self _fullTestModel]];
    
    //then
    id movedIndexes = self.model.movedRowsIndexPaths;
    XCTAssertNotNil(movedIndexes);
}


#pragma mark - Empty Model updated with Full Test Models, index path tests

- (void)test_insertedIndexPathsFromEmptyModel_positive_hasIndexesAfterMerge
{
    
    //given
    ANStorageUpdateModel* emptyModel = [ANStorageUpdateModel new];
    [self.model addInsertedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    
    //when
    [self.model mergeWith:emptyModel];
    //then
    id insertedIndexes = self.model.insertedRowIndexPaths;
    XCTAssertNotNil(insertedIndexes);
}

- (void)test_updatedIndexPathsFromEmptyModel_positive_hasIndexesAfterMerge
{
    //given
    ANStorageUpdateModel* emptyModel = [ANStorageUpdateModel new];
    [self.model addUpdatedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    
    //when
    [self.model mergeWith:emptyModel];
    
    //then
    id updatedIndexes = self.model.updatedRowIndexPaths;
    XCTAssertNotNil(updatedIndexes);
}

- (void)test_deletedIndexPathsFromEmptyModel_positive_hasIndexesAfterMerge
{
    //given
    ANStorageUpdateModel* emptyModel = [ANStorageUpdateModel new];
    [self.model addDeletedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    
    //when
    [self.model mergeWith:emptyModel];
    
    //then
    id deletedIndexes = self.model.deletedRowIndexPaths;
    XCTAssertNotNil(deletedIndexes);
}

- (void)test_movedIndexPathsFromEmptyModel_positive_hasIndexesAfterMerge
{
    //given
    ANStorageUpdateModel* emptyModel = [ANStorageUpdateModel new];
    [self.model addMovedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    
    //when
    
    [self.model mergeWith:emptyModel];
    
    //then
    id movedIndexes = self.model.movedRowsIndexPaths;
    XCTAssertNotNil(movedIndexes);
}

#pragma mark - Model Sections updated with empty Model

- (void)test_deletedSectionFromEmptyModel_positive_afterMergeHasObject
{
    //given
    ANStorageUpdateModel* emptyModel = [ANStorageUpdateModel new];
    [self.model addDeletedSectionIndexes:[NSIndexSet indexSetWithIndex:1]];
    
    //when
    [self.model mergeWith:emptyModel];
    
    //then
    id array = self.model.deletedSectionIndexes;
    XCTAssertNotNil(array);
}

- (void)test_updatedSectionFromEmptyModel_positive_afterMergeHasObject
{
    ANStorageUpdateModel* emptyModel = [ANStorageUpdateModel new];
    [self.model addUpdatedSectionIndexes:[NSIndexSet indexSetWithIndex:1]];
    
    //when
    [self.model mergeWith:emptyModel];
    
    //then
    id array = self.model.updatedSectionIndexes;
    XCTAssertNotNil(array);
}

- (void)test_insertedSectionFromEmptyModel_positive_afterMergeHasObject
{
    //given
    ANStorageUpdateModel* emptyModel = [ANStorageUpdateModel new];
    [self.model addInsertedSectionIndexes:[NSIndexSet indexSetWithIndex:1]];
    
    //when
    [self.model mergeWith:emptyModel];
    
    //then
    id array = self.model.insertedSectionIndexes;
    XCTAssertNotNil(array);
}

@end
