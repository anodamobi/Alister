//
//  ANStorageUpdateModelTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/23/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANStorageUpdateModel.h"

static BOOL const kIsRequireReload = YES;
static NSInteger const kMaxGeneratedCount = 3;

@interface ANStorageUpdateModelTests : XCTestCase

@property (nonatomic, strong) ANStorageUpdateModel* model;

@end

@implementation ANStorageUpdateModelTests

- (void)setUp
{
    [super setUp];
    self.model = [ANStorageUpdateModel new];
    self.model.isRequireReload = YES;
}

- (void)tearDown
{
    self.model = nil;
    [super tearDown];
}


#pragma mark - isRequireReload

- (void)test_isRequireReload_positive_initialValueIsSetRightAndNotRaiseException
{
    void(^testBlock)() = ^() {
        expect(self.model.isRequireReload).equal(kIsRequireReload);
    };
    expect(testBlock).notTo.raiseAny();
}

- (void)test_isRequireReload_positive_falseWhenCreated
{
    //given
    ANStorageUpdateModel*  testModel = [ANStorageUpdateModel new];
    
    //then
    expect(testModel.isRequireReload).to.beFalsy();
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
    expect(self.model.isRequireReload).to.beTruthy();
    
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
    expect(self.model.isRequireReload).to.beTruthy();
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
    expect(self.model.isRequireReload).to.beTruthy();
}


#pragma mark - protocol implementation

- (void)test_protocolconformation_positive_modelComformsToStorageUpdateProtocol
{
    expect(self.model).conformTo(@protocol(ANStorageUpdateModelInterface));
}

- (void)test_protocolImplementation_positive_modelImplementsAllProtocolMethods
{
    expect(self.model).respondTo(@selector(deletedSectionIndexes));
    expect(self.model).respondTo(@selector(insertedSectionIndexes));
    expect(self.model).respondTo(@selector(updatedSectionIndexes));
    expect(self.model).respondTo(@selector(updatedSectionIndexes));
    
    expect(self.model).respondTo(@selector(deletedRowIndexPaths));
    expect(self.model).respondTo(@selector(insertedRowIndexPaths));
    expect(self.model).respondTo(@selector(updatedRowIndexPaths));
    expect(self.model).respondTo(@selector(movedRowsIndexPaths));
    
    expect(self.model).respondTo(@selector(addDeletedSectionIndex:));
    expect(self.model).respondTo(@selector(addUpdatedSectionIndex:));
    expect(self.model).respondTo(@selector(addInsertedSectionIndex:));
    
    expect(self.model).respondTo(@selector(addInsertedSectionIndexes:));
    expect(self.model).respondTo(@selector(addUpdatedSectionIndexes:));
    expect(self.model).respondTo(@selector(addDeletedSectionIndexes:));

    expect(self.model).respondTo(@selector(addInsertedIndexPaths:));
    expect(self.model).respondTo(@selector(addUpdatedIndexPaths:));
    expect(self.model).respondTo(@selector(addDeletedIndexPaths:));
    expect(self.model).respondTo(@selector(addMovedIndexPaths:));
    
    expect(self.model).respondTo(@selector(isRequireReload));
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


#pragma mark - mergeWith

- (void)test_mergeWith_positive_modelIsEmptyWhenCreated
{
    //given
    ANStorageUpdateModel* model = [ANStorageUpdateModel new];
    expect([model isEmpty]).to.beTruthy();
    
    //when
    [model mergeWith:[self _fullTestModel]];
    
    //then
    expect([self.model isEmpty]).to.beFalsy();
}


#pragma mark - mergeWith addDeletedIndexPaths

- (void)test_mergeWith_positive_deletedRowIndexPathsCountAreEqual
{
    // Given
    NSIndexPath* firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* secondPath = [NSIndexPath indexPathForRow:2000 inSection:9999];
    NSArray* indexPaths = @[firstPath, secondPath];
    
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    [mergedModel addDeletedIndexPaths:indexPaths];
    
    // When
    [self.model mergeWith:mergedModel];
    
    // Then
    expect(self.model.deletedRowIndexPaths.count).to.equal(indexPaths.count);
}

- (void)test_mergeWith_positive_respondToAddDeletedIndexPaths
{
    expect(self.model).to.respondTo(@selector(addDeletedIndexPaths:));
}

- (void)test_mergeWith_negative_toNotRaiseExceptionWhenAddNilDeletedInsexPaths
{
    // Given
    id indexPaths = nil;
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    
    // When
    void(^testBlock)() = ^{
        [mergedModel addDeletedIndexPaths:indexPaths];
        [self.model mergeWith:mergedModel];
    };
    
    // Then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - mergeWith addInsertedIndexPaths

- (void)test_mergeWith_positive_insertedIndexPathsCountAreEqual
{
    // Given
    NSIndexPath* firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* secondPath = [NSIndexPath indexPathForRow:2000 inSection:9999];
    NSArray* indexPaths = @[firstPath, secondPath];
    
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    [mergedModel addInsertedIndexPaths:indexPaths];
    
    // When
    [self.model mergeWith:mergedModel];
    
    // Then
    expect(self.model.insertedRowIndexPaths.count).to.equal(indexPaths.count);
}

- (void)test_mergeWith_positive_respondToAddInsertedIndexPaths
{
    expect(self.model).to.respondTo(@selector(addInsertedIndexPaths:));
}

- (void)test_mergeWith_negative_toNotRaiseExceptionWhenAddNilInsertedInsexPaths
{
    // Given
    id indexPaths = nil;
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    
    // When
    void(^testBlock)() = ^{
        [mergedModel addInsertedIndexPaths:indexPaths];
        [self.model mergeWith:mergedModel];
    };
    
    // Then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - mergeWith addUpdatedIndexPaths

- (void)test_mergeWith_positive_updatedIndexPathsCountAreEqual
{
    // Given
    NSIndexPath* firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* secondPath = [NSIndexPath indexPathForRow:2000 inSection:9999];
    NSArray* indexPaths = @[firstPath, secondPath];
    
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    [mergedModel addUpdatedIndexPaths:indexPaths];
    
    // When
    [self.model mergeWith:mergedModel];
    
    // Then
    expect(self.model.updatedRowIndexPaths.count).to.equal(indexPaths.count);
}

- (void)test_mergeWith_positive_respondToAddUpdatedIndexPaths
{
    expect(self.model).to.respondTo(@selector(addUpdatedIndexPaths:));
}

- (void)test_mergeWith_negative_toNotRaiseExceptionWhenAddNilUpdatedInsexPaths
{
    // Given
    id indexPaths = nil;
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    
    // When
    void(^testBlock)() = ^{
        [mergedModel addUpdatedIndexPaths:indexPaths];
        [self.model mergeWith:mergedModel];
    };
    
    // Then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - mergeWith addMovedIndexPaths

- (void)test_mergeWith_positive_movedIndexPathsCountAreEqual
{
    // Given
    NSIndexPath* firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* secondPath = [NSIndexPath indexPathForRow:2000 inSection:9999];
    NSArray* indexPaths = @[firstPath, secondPath];
    
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    [mergedModel addMovedIndexPaths:indexPaths];
    
    // When
    [self.model mergeWith:mergedModel];
    
    // Then
    expect(self.model.movedRowsIndexPaths.count).to.equal(indexPaths.count);
}

- (void)test_mergeWith_positive_respondToAddMovedIndexPaths
{
    expect(self.model).to.respondTo(@selector(addMovedIndexPaths:));
}

- (void)test_mergeWith_negative_toNotRaiseExceptionWhenAddNilMovedInsexPaths
{
    // Given
    id indexPaths = nil;
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    
    // When
    void(^testBlock)() = ^{
        [mergedModel addMovedIndexPaths:indexPaths];
        [self.model mergeWith:mergedModel];
    };
    
    // Then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addInsertedSectionIndexes

- (void)test_addInsertedSectionIndexes_positive_insertedSectionIndexesAreAdded
{
    // Given
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)];
    
    // When
    [self.model addInsertedSectionIndexes:indexSet];
    
    // Then
    expect(self.model.insertedSectionIndexes).to.equal(indexSet);
}

- (void)test_addInsertedSectionIndexes_negative_toNotRaiseExceptionWhenAddNilIndexes
{
    // Given
    NSIndexSet* indexSet = nil;
    
    // When
    void(^testBlock)() = ^() {
        [self.model addInsertedSectionIndexes:indexSet];
    };
    
    // Then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addUpdatedSectionIndexes

- (void)test_addUpdatedSectionIndexes_positive_updatedSectionIndexesAreAdded
{
    // Given
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)];
    
    // When
    [self.model addUpdatedSectionIndexes:indexSet];
    
    // Then
    expect(self.model.updatedSectionIndexes).to.equal(indexSet);
}

- (void)test_addUpdatedSectionIndexes_negative_toNotRaiseExceptionWhenAddNilIndexes
{
    // Given
    NSIndexSet* indexSet = nil;
    
    // When
    void(^testBlock)() = ^() {
        [self.model addInsertedSectionIndexes:indexSet];
    };
    
    // Then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addDeletedSectionIndexes

- (void)test_addDeletedSectionIndexes_positive_deletedSectionIndexesAreAdded
{
    // Given
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)];
    
    // When
    [self.model addDeletedSectionIndexes:indexSet];
    
    // Then
    expect(self.model.deletedSectionIndexes).to.equal(indexSet);
}

- (void)test_addDeletedSectionIndexes_negative_toNotRaiseExceptionWhenAddNilIndexes
{
    // Given
    NSIndexSet* indexSet = nil;
    
    // When
    void(^testBlock)() = ^() {
        [self.model addDeletedSectionIndexes:indexSet];
    };
    
    // Then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addDeletedSectionIndex

- (void)test_addDeletedSectionIndex_positive_modelContainsDeletedIndex
{
    // Given
    NSMutableIndexSet* indexSet = [NSMutableIndexSet indexSet];
    
    for (NSInteger counter = 0; counter < kMaxGeneratedCount; counter++)
    {
        [indexSet addIndex:counter];
        [self.model addDeletedSectionIndex:counter];
    }
    
    // Then
    expect(self.model.deletedSectionIndexes).to.equal(indexSet);
}

- (void)test_addUpdatedSectionIndex_positive_modelContainsUpdatedIndex
{
    // Given
    NSMutableIndexSet* indexSet = [NSMutableIndexSet indexSet];
    
    for (NSInteger counter = 0; counter < kMaxGeneratedCount; counter++)
    {
        [indexSet addIndex:counter];
        [self.model addUpdatedSectionIndex:counter];
    }
    
    // Then
    expect(self.model.updatedSectionIndexes).to.equal(indexSet);
}

- (void)test_addInsertedSectionIndex_positive_modelContainsInsertedIndex
{
    // Given
    NSMutableIndexSet* indexSet = [NSMutableIndexSet indexSet];
    
    for (NSInteger counter = 0; counter < kMaxGeneratedCount; counter++)
    {
        [indexSet addIndex:counter];
        [self.model addInsertedSectionIndex:counter];
    }
    
    // Then
    expect(self.model.insertedSectionIndexes).to.equal(indexSet);
}


#pragma mark - all rowIndexPaths

- (void)test_rowIndexPaths_positive_initialRowIndexPathsNonNil
{
    expect(self.model.deletedRowIndexPaths).notTo.beNil();
    expect(self.model.insertedRowIndexPaths).notTo.beNil();
    expect(self.model.updatedRowIndexPaths).notTo.beNil();
    expect(self.model.movedRowsIndexPaths).notTo.beNil();
}


#pragma mark - deletedRowIndexPaths

- (void)test_deletedRowIndexPaths_positive_initialAndReturnedPathsAreEqual
{
    // Given
    NSArray* indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:1]];
    
    // When
    [self.model addDeletedIndexPaths:indexPaths];
    
    // Then
    expect(self.model.deletedRowIndexPaths).equal(indexPaths);
    expect(self.model.deletedRowIndexPaths.count).equal(indexPaths.count);
}

- (void)test_insertedRowIndexPaths_positive_initialAndReturnedPathsAreEqual
{
    // Given
    NSArray* indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:1]];
    
    // When
    [self.model addInsertedIndexPaths:indexPaths];
    
    // Then
    expect(self.model.insertedRowIndexPaths).equal(indexPaths);
    expect(self.model.insertedRowIndexPaths.count).equal(indexPaths.count);
}

- (void)test_updatedRowIndexPaths_positive_initialAndReturnedPathsAreEqual
{
    // Given
    NSArray* indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:1]];
    
    // When
    [self.model addUpdatedIndexPaths:indexPaths];
    
    // Then
    expect(self.model.updatedRowIndexPaths).equal(indexPaths);
    expect(self.model.updatedRowIndexPaths.count).equal(indexPaths.count);
}

- (void)test_movedRowsIndexPaths_positive_initialAndReturnedPathsAreEqual
{
    // Given
    NSArray* indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:1]];
    
    // When
    [self.model addMovedIndexPaths:indexPaths];
    
    // Then
    expect(self.model.movedRowsIndexPaths).equal(indexPaths);
    expect(self.model.movedRowsIndexPaths.count).equal(indexPaths.count);
}


#pragma mark - all sectionIndexes

- (void)test_sectionIndexes_positive_initialSectionIndexesNonNil
{
    expect(self.model.deletedSectionIndexes).notTo.beNil();
    expect(self.model.insertedSectionIndexes).notTo.beNil();
    expect(self.model.updatedSectionIndexes).notTo.beNil();
}

- (void)test_sectionIndexes_positive_toNotRaiseException
{
    void(^testBlock)() = ^() {
        [self.model deletedSectionIndexes];
        [self.model insertedSectionIndexes];
        [self.model updatedSectionIndexes];
    };
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - isEmpty

- (void)test_isEmpty_positive_modelIsEmptyWhenCreated
{
    //given
    ANStorageUpdateModel* testModel = [ANStorageUpdateModel new];
    
    //then
    expect([testModel isEmpty]).to.beTruthy();
}

- (void)test_isEmpty_positive_modelIsNotEmptyWhenAddValues
{
    // Given
    self.model.isRequireReload = NO;
    [self.model addInsertedSectionIndex:3];
    
    // Then
    expect(self.model.isEmpty).to.beFalsy();
}

- (void)test_isEmpty_negative_modelIsNotEmptyWhenRequirerReload
{
    // Given
    self.model.isRequireReload = YES;
    
    // Then
    expect(self.model.isEmpty).to.beFalsy();
}

- (void)test_isEmpty_positive_notEmptyWhenAddItem
{
    //given
    [self.model mergeWith:[self _fullTestModel]];
    
    //then
    expect(([self.model isEmpty])).to.beFalsy();
}

@end
