//
//  ANStorageModelTestAlternative.m
//  Alister-Example
//
//  Created by ANODA on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"

@interface ANStorageModelTestAlternative : XCTestCase

@property (nonatomic, strong) ANStorageModel* storageModel;
@property (nonatomic, strong) NSString* item;

@end

@implementation ANStorageModelTestAlternative

- (void)setUp
{
    [super setUp];
    self.storageModel = [ANStorageModel new];
    self.item = @"item";
}

- (void)tearDown
{
    self.storageModel = nil;
    self.item = nil;
    [super tearDown];
}


#pragma mark - itemsInSection

- (void)test_itemsInSection_positive_initialAndReturnedObjectsMatch
{
    // given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.item];
    
    // when
    [self.storageModel addSection:section];
    
    // then
    expect([self.storageModel itemsInSection:0]).equal(section.objects);
}

- (void)test_itemsInSection_negative_notRaiseExceptionWhenIndexIsNegative
{
    // when
    void(^testBlock)(void) = ^{
        [self.storageModel itemsInSection:arc4random()];
        [self.storageModel itemsInSection:-1];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - sections

- (void)test_sections_positive_addedAndReturnedSectionsMatch
{
    // given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.item];
    
    // when
    [self.storageModel addSection:section];
    
    // then
    expect([self.storageModel sections].firstObject).equal(section);
}


#pragma mark - itemAtIndexPath

- (void)test_itemAtIndexPath_positive_dataIsValidWhenGetExistingItem
{
    // given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.item];
    [self.storageModel addSection:section];
    
    // when
    NSIndexPath* firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    // then
    id returnedItem = [self.storageModel itemAtIndexPath:firstItemIndexPath];
    expect(returnedItem).to.equal(self.item);
}

- (void)test_itemAtIndexPath_negative_itemIsNilWhenIndexPathIsOutOfBounds
{
    // given
    NSIndexPath* negativeIndexPath = [NSIndexPath indexPathForItem:arc4random()
                                                         inSection:arc4random()];
    // then
    expect([self.storageModel itemAtIndexPath:negativeIndexPath]).to.beNil();
}

- (void)test_itemAtIndexPath_negative_indexPathIsNil
{
    // given
    __block id obj = nil;
    
    // when
    void(^testBlock)() = ^{
        obj = [self.storageModel itemAtIndexPath:nil];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
    expect(obj).to.beNil();
}

- (void)test_itemAtIndexPath_negative_indexPathIsNotAValidClass
{
    // given
    __block id obj = nil;
    
    // when
    void(^testBlock)() = ^{
        obj = [self.storageModel itemAtIndexPath:(NSIndexPath*)@""];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
    expect(obj).to.beNil();
}


#pragma mark - sectionAtIndex

- (void)test_sectionAtIndex_positive_sectionExists
{
    // given
    u_int32_t maxObjectsCount = arc4random_uniform(20);
    for (NSUInteger counter = 0; counter < maxObjectsCount; counter++)
    {
        [self.storageModel addSection:[ANStorageSectionModel new]];
    }
    
    // then
    u_int32_t sectionIndex = arc4random_uniform(maxObjectsCount);
    expect([self.storageModel sectionAtIndex:sectionIndex]).notTo.beNil();
}

- (void)test_sectionAtIndex_negative_noCrashWithIncorrectSectionIndex
{
    // given
    void(^TestBlock)(void) = ^{
        [self.storageModel sectionAtIndex:arc4random()];
    };
    
    // then
    expect(TestBlock).notTo.raiseAny();
}

- (void)test_sectionAtIndex_negative_sectionIsNilWhenNotExist
{
    // given
    NSUInteger sectionIndex = arc4random();
    
    // then
    expect([self.storageModel sectionAtIndex:sectionIndex]).to.beNil();
}


#pragma mark - addSection

- (void)test_addSection_positive_sectionsCountValid
{
    // when
    NSInteger maxObjectsCount = arc4random_uniform(3) + 1;
    for (NSInteger counter = 0; counter < maxObjectsCount; counter++)
    {
        [self.storageModel addSection:[ANStorageSectionModel new]];
    }
    
    // then
    expect(self.storageModel.sections).haveCount(maxObjectsCount);
}

- (void)test_addSection_negative_noAssertIfTryToAddNil
{
    void(^testBlock)(void) = ^{
        [self.storageModel addSection:nil];
    };
    expect(testBlock).notTo.raiseAny();
    expect(self.storageModel.sections).haveCount(0);
}

/**

- (void)test_addSection_negative_noAssertIfTryToAddInvalidObject
{
    void(^TestBlock)(void) = ^{
        [self.model addSection:(ANStorageSectionModel*)@""];
    };
    expect(TestBlock).notTo.raiseAny();
    expect(self.model.sections).haveCount(0);
}


 - (void)addSection:(ANStorageSectionModel*)section;
 - (void)removeSectionAtIndex:(NSUInteger)index;
 - (void)removeAllSections;
 
 */

@end
