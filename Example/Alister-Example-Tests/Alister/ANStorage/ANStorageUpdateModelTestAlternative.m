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


#pragma mark - Test isRequireReload

- (void)test_isRequireReload_positive_initialValueIsSetRight
{
    expect(self.model.isRequireReload).equal(kIsRequireReload);
}


#pragma mark - mergeWith
#pragma mark - addDeletedIndexPaths

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


#pragma mark - addInsertedIndexPaths

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


#pragma mark - addUpdatedIndexPaths

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


#pragma mark - addMovedIndexPaths

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
    [self.model addInsertedSectionIndexes:indexSet];
    
    // Then
    expect(self.model.insertedSectionIndexes).notTo.beNil();
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
    [self.model addInsertedSectionIndexes:indexSet];
    
    // Then
    expect(self.model.insertedSectionIndexes).notTo.beNil();
}

/*
 - (void)addUpdatedSectionIndexes:(NSIndexSet*)indexSet;
 - (void)addDeletedSectionIndexes:(NSIndexSet*)indexSet;
 */

@end
