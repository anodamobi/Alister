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
    ANStorageUpdateModel*  testModel = [ANStorageUpdateModel new];
    
    expect(testModel.isRequireReload).to.beFalsy();
}

- (void)test_isRequireReload_positive_falseWhenUpdateWithModelWithFalseAndNoUpdates
{
    ANStorageUpdateModel* testModel = [self _fullTestModel];
    testModel.isRequireReload = NO;
    
    [self.model mergeWith:testModel];
    
    expect(self.model.isRequireReload).to.beTruthy();
}

- (void)test_isRequireReload_positive_trueWhenUpdateWithModelWithTrueAndNoUpdates
{
    ANStorageUpdateModel* testModel = [self _fullTestModel];
    testModel.isRequireReload = YES;
    
    [self.model mergeWith:testModel];
    
    expect(self.model.isRequireReload).to.beTruthy();
}

- (void)test_isRequireReload_positive_trueWhenUpdateWithModelWithFalseAndHasUpdates
{
    self.model.isRequireReload = NO;
    ANStorageUpdateModel* testModel = [self _fullTestModel];
    testModel.isRequireReload = YES;
    
    [self.model mergeWith:testModel];
    
    expect(self.model.isRequireReload).to.beTruthy();
}


#pragma mark - protocol implementation

- (void)test_protocolConformation_positive_modelComformsToStorageUpdateProtocol
{
    expect(self.model).conformTo(@protocol(ANStorageUpdateModelInterface));
}


#pragma mark - mergeWith

- (void)test_mergeWith_positive_modelIsEmptyWhenCreated
{
    ANStorageUpdateModel* model = [ANStorageUpdateModel new];
    expect([model isEmpty]).to.beTruthy();
    
    [model mergeWith:[self _fullTestModel]];
    
    expect([self.model isEmpty]).to.beFalsy();
}


#pragma mark - mergeWith addDeletedIndexPaths

- (void)test_mergeWith_positive_deletedRowIndexPathsCountAreEqual
{
    NSIndexPath* firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* secondPath = [NSIndexPath indexPathForRow:2000 inSection:9999];
    NSArray* indexPaths = @[firstPath, secondPath];
    
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    [mergedModel addDeletedIndexPaths:indexPaths];
    
    [self.model mergeWith:mergedModel];
    
    expect(self.model.deletedRowIndexPaths.count).to.equal(indexPaths.count);
}

- (void)test_mergeWith_positive_respondToAddDeletedIndexPaths
{
    expect(self.model).to.respondTo(@selector(addDeletedIndexPaths:));
}

- (void)test_mergeWith_negative_toNotRaiseExceptionWhenAddNilDeletedInsexPaths
{
    id indexPaths = nil;
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    
    void(^testBlock)() = ^{
        [mergedModel addDeletedIndexPaths:indexPaths];
        [self.model mergeWith:mergedModel];
    };
    
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - mergeWith addInsertedIndexPaths

- (void)test_mergeWith_positive_insertedIndexPathsCountAreEqual
{
    NSIndexPath* firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* secondPath = [NSIndexPath indexPathForRow:2000 inSection:9999];
    NSArray* indexPaths = @[firstPath, secondPath];
    
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    [mergedModel addInsertedIndexPaths:indexPaths];
    
    [self.model mergeWith:mergedModel];
    
    expect(self.model.insertedRowIndexPaths.count).to.equal(indexPaths.count);
}

- (void)test_mergeWith_negative_toNotRaiseExceptionWhenAddNilInsertedInsexPaths
{
    id indexPaths = nil;
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    
    void(^testBlock)() = ^{
        [mergedModel addInsertedIndexPaths:indexPaths];
        [self.model mergeWith:mergedModel];
    };
    
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - mergeWith addUpdatedIndexPaths

- (void)test_mergeWith_positive_updatedIndexPathsCountAreEqual
{
    NSIndexPath* firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* secondPath = [NSIndexPath indexPathForRow:2000 inSection:9999];
    NSArray* indexPaths = @[firstPath, secondPath];
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    [mergedModel addUpdatedIndexPaths:indexPaths];
    
    [self.model mergeWith:mergedModel];
    
    expect(self.model.updatedRowIndexPaths.count).to.equal(indexPaths.count);
}

- (void)test_mergeWith_negative_toNotRaiseExceptionWhenAddNilUpdatedInsexPaths
{
    id indexPaths = nil;
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    
    void(^testBlock)() = ^{
        [mergedModel addUpdatedIndexPaths:indexPaths];
        [self.model mergeWith:mergedModel];
    };
    
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - mergeWith addMovedIndexPaths

- (void)test_mergeWith_positive_movedIndexPathsCountAreEqual
{
    NSIndexPath* firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* secondPath = [NSIndexPath indexPathForRow:2000 inSection:9999];
    NSArray* indexPaths = @[firstPath, secondPath];
    
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    [mergedModel addMovedIndexPaths:indexPaths];
    
    [self.model mergeWith:mergedModel];
    
    expect(self.model.movedRowsIndexPaths.count).to.equal(indexPaths.count);
}

- (void)test_mergeWith_negative_toNotRaiseExceptionWhenAddNilMovedInsexPaths
{
    id indexPaths = nil;
    ANStorageUpdateModel* mergedModel = [ANStorageUpdateModel new];
    
    void(^testBlock)() = ^{
        [mergedModel addMovedIndexPaths:indexPaths];
        [self.model mergeWith:mergedModel];
    };
    
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addInsertedSectionIndexes

- (void)test_addInsertedSectionIndexes_positive_insertedSectionIndexesAreAdded
{
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)];
    
    [self.model addInsertedSectionIndexes:indexSet];
    
    expect(self.model.insertedSectionIndexes).to.equal(indexSet);
}

- (void)test_addInsertedSectionIndexes_negative_toNotRaiseExceptionWhenAddNilIndexes
{
    NSIndexSet* indexSet = nil;
    
    void(^testBlock)() = ^() {
        [self.model addInsertedSectionIndexes:indexSet];
    };
    
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addUpdatedSectionIndexes

- (void)test_addUpdatedSectionIndexes_positive_updatedSectionIndexesAreAdded
{
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)];
    
    [self.model addUpdatedSectionIndexes:indexSet];
    
    expect(self.model.updatedSectionIndexes).to.equal(indexSet);
}

- (void)test_addUpdatedSectionIndexes_negative_toNotRaiseExceptionWhenAddNilIndexes
{
    NSIndexSet* indexSet = nil;
    
    void(^testBlock)() = ^() {
        [self.model addInsertedSectionIndexes:indexSet];
    };
    
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addDeletedSectionIndexes

- (void)test_addDeletedSectionIndexes_positive_deletedSectionIndexesAreAdded
{
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)];
    
    [self.model addDeletedSectionIndexes:indexSet];
    
    expect(self.model.deletedSectionIndexes).to.equal(indexSet);
}

- (void)test_addDeletedSectionIndexes_negative_toNotRaiseExceptionWhenAddNilIndexes
{
    NSIndexSet* indexSet = nil;
    
    void(^testBlock)() = ^() {
        [self.model addDeletedSectionIndexes:indexSet];
    };
    
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - addDeletedSectionIndex

- (void)test_addDeletedSectionIndex_positive_modelContainsDeletedIndex
{
    NSMutableIndexSet* indexSet = [NSMutableIndexSet indexSet];
    
    for (NSInteger counter = 0; counter < kMaxGeneratedCount; counter++)
    {
        [indexSet addIndex:counter];
        [self.model addDeletedSectionIndex:counter];
    }
    
    expect(self.model.deletedSectionIndexes).to.equal(indexSet);
}

- (void)test_addUpdatedSectionIndex_positive_modelContainsUpdatedIndex
{
    NSMutableIndexSet* indexSet = [NSMutableIndexSet indexSet];
    
    for (NSInteger counter = 0; counter < kMaxGeneratedCount; counter++)
    {
        [indexSet addIndex:counter];
        [self.model addUpdatedSectionIndex:counter];
    }
    
    expect(self.model.updatedSectionIndexes).to.equal(indexSet);
}

- (void)test_addInsertedSectionIndex_positive_modelContainsInsertedIndex
{
    NSMutableIndexSet* indexSet = [NSMutableIndexSet indexSet];
    
    for (NSInteger counter = 0; counter < kMaxGeneratedCount; counter++)
    {
        [indexSet addIndex:counter];
        [self.model addInsertedSectionIndex:counter];
    }
    
    expect(self.model.insertedSectionIndexes).to.equal(indexSet);
}


#pragma mark - all rowIndexPaths

- (void)test_rowIndexPaths_positive_initialRowIndexPathsNotNil
{
    expect(self.model.deletedRowIndexPaths).notTo.beNil();
    expect(self.model.insertedRowIndexPaths).notTo.beNil();
    expect(self.model.updatedRowIndexPaths).notTo.beNil();
    expect(self.model.movedRowsIndexPaths).notTo.beNil();
}


#pragma mark - deletedRowIndexPaths

- (void)test_deletedRowIndexPaths_positive_initialAndReturnedPathsAreEqual
{
    NSArray* indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:1]];
    
    [self.model addDeletedIndexPaths:indexPaths];
    
    expect(self.model.deletedRowIndexPaths).equal(indexPaths);
    expect(self.model.deletedRowIndexPaths).haveCount(indexPaths.count);
}

- (void)test_insertedRowIndexPaths_positive_initialAndReturnedPathsAreEqual
{
    NSArray* indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:1]];
    
    [self.model addInsertedIndexPaths:indexPaths];
    
    expect(self.model.insertedRowIndexPaths).equal(indexPaths);
    expect(self.model.insertedRowIndexPaths.count).equal(indexPaths.count);
}

- (void)test_updatedRowIndexPaths_positive_initialAndReturnedPathsAreEqual
{
    NSArray* indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:1]];
    
    [self.model addUpdatedIndexPaths:indexPaths];
    
    expect(self.model.updatedRowIndexPaths).equal(indexPaths);
    expect(self.model.updatedRowIndexPaths.count).equal(indexPaths.count);
}

- (void)test_movedRowsIndexPaths_positive_initialAndReturnedPathsAreEqual
{
    NSArray* indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:1]];
    
    [self.model addMovedIndexPaths:indexPaths];
    
    expect(self.model.movedRowsIndexPaths).equal(indexPaths);
    expect(self.model.movedRowsIndexPaths.count).equal(indexPaths.count);
}


#pragma mark - all sectionIndexes

- (void)test_sectionIndexes_positive_initialSectionIndexesNotNil
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
    ANStorageUpdateModel* testModel = [ANStorageUpdateModel new];
    
    expect([testModel isEmpty]).to.beTruthy();
}

- (void)test_isEmpty_positive_modelIsNotEmptyWhenAddValues
{
    self.model.isRequireReload = NO;
    [self.model addInsertedSectionIndex:3];
    
    expect(self.model.isEmpty).to.beFalsy();
}

- (void)test_isEmpty_negative_modelIsNotEmptyWhenRequirerReload
{
    self.model.isRequireReload = YES;
    
    expect(self.model.isEmpty).to.beFalsy();
}

- (void)test_isEmpty_positive_notEmptyWhenAddItem
{
    [self.model mergeWith:[self _fullTestModel]];
    
    expect(([self.model isEmpty])).to.beFalsy();
}

@end
