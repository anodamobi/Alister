//
//  ANStorageModelTest.m
//  Alister
//
//  Created by Oksana on 7/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"
#import <Expecta/Expecta.h>

static u_int32_t const kMaxGeneratedNumber = 3;

@interface ANStorageModelTest : XCTestCase

@property (nonatomic, strong) ANStorageModel* model;
@property (nonatomic, strong) NSString* fixtureObject;

@end

@implementation ANStorageModelTest

- (void)setUp
{
    [super setUp];

    self.model = [ANStorageModel new];
    self.fixtureObject = @"test";
}

- (void)tearDown
{
    self.model = nil;
    [super tearDown];
}

- (void)test_objectSetup_positive_defaultValues
{
    expect(self.model.sections).haveCount(0);
}

- (void)test_addSection_positive_sectionsCountIsValid
{
    // when
    NSInteger counter = arc4random_uniform(kMaxGeneratedNumber) + 1;
    for (NSInteger i = 0; i < counter; i++)
    {
        [self.model addSection:[ANStorageSectionModel new]];
    }
    
    // then
    expect(self.model.sections).haveCount(counter);
}

- (void)test_addSection_negative_toNotRaiseExceptionWhenAddNilSection
{
    // when
    void(^TestBlock)(void) = ^{
       [self.model addSection:nil];
    };
    
    // then
    expect(TestBlock).notTo.raiseAny();
    expect(self.model.sections).haveCount(0);
}

- (void)test_addSection_negative_noAssertIfTryToAddInvalidObject
{
    // when
    void(^testBlock)(void) = ^{
        [self.model addSection:(ANStorageSectionModel*)@""];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
    expect(self.model.sections).haveCount(0);
}


#pragma mark - itemsInSection

- (void)test_itemsInSection_positive_objectsMatch
{
    // when
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.fixtureObject];
    [self.model addSection:section];
    
    // then
    expect([self.model itemsInSection:0]).equal(section.objects);
}

- (void)test_itemsInSection_negative_whenSectionIndexInvalidNoAssert
{
    // when
    void(^TestBlock)(void) = ^{
        [self.model itemsInSection:arc4random()];
    };
    
    // then
    expect(TestBlock).notTo.raiseAny();
}


#pragma mark - sectionAtIndex

- (void)test_sectionAtIndex_positive_sectionExists
{
    // when
    u_int32_t counter = arc4random_uniform(kMaxGeneratedNumber) + 1;
    for (NSUInteger i = 0; i < counter; i++)
    {
        [self.model addSection:[ANStorageSectionModel new]];
    }
    
    // then
    u_int32_t sectionIndex = arc4random_uniform(counter);
    expect([self.model sectionAtIndex:sectionIndex]).notTo.beNil();
}

- (void)test_sectionAtIndex_negative_noCrashWithIncorrectSectionIndex
{
    void(^TestBlock)(void) = ^{
        [self.model sectionAtIndex:arc4random()];
    };
    expect(TestBlock).notTo.raiseAny();
}

- (void)test_sectionAtIndex_negative_sectionIsNilWhenNotExist
{
    NSUInteger sectionIndex = arc4random();
    expect([self.model sectionAtIndex:sectionIndex]).to.beNil();
}


#pragma mark - removeSectionAtIndex

- (void)test_removeSectionAtIndex_positive_sectionExistAtIndex
{
    // given
    u_int32_t counter = arc4random_uniform(kMaxGeneratedNumber) + 1;
    for (NSUInteger i = 0; i < counter; i++)
    {
        [self.model addSection:[ANStorageSectionModel new]];
    }
    u_int32_t sectionIndex = arc4random_uniform(counter);
    NSUInteger sectionsCount = self.model.sections.count;
    
    // when
    [self.model removeSectionAtIndex:sectionIndex];
    
    // then
    expect(sectionsCount - 1).equal(self.model.sections.count);
}

- (void)test_removeSectionAtIndex_negative_noCrashIfSectionNotExist
{
    // when
    void(^testBlock)(void) = ^{
        [self.model removeSectionAtIndex:arc4random()];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_removeSectionAtIndex_positive_removeLastSection
{
    // given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];

    // when
    [self.model removeSectionAtIndex:0];
    
    // then
    expect(self.model.sections).haveCount(0);
}


#pragma mark - removeAllSections

- (void)test_removeAllSections_positive_noExistingSectionsAfterRemove
{
    // given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];
    
    // when
    [self.model removeAllSections];
    
    // then
    expect(self.model.sections).haveCount(0);
}

- (void)test_removeAllSections_positive_sectionExistIfAddAfterRemove
{
    // given
    [self.model removeAllSections];
    
    // when
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];
    
    // then
    expect(self.model.sections).haveCount(1);
}


#pragma mark - itemAtIndexPath

- (void)test_itemAtIndexPath_positive_dataIsValidWhenGetExistingItem
{
	//given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.fixtureObject];
    [self.model addSection:section];
    
    //when
    NSIndexPath* firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
   
    //then
    expect([self.model itemAtIndexPath:firstItemIndexPath]).to.equal(self.fixtureObject);
}

- (void)test_itemAtIndexPath_negative_itemIsNilWhenIndexPathIsOutOfBounds
{
    // given
    NSIndexPath* negativeIndexPath = [NSIndexPath indexPathForItem:arc4random()
                                                         inSection:arc4random()];
    
    // then
    expect([self.model itemAtIndexPath:negativeIndexPath]).to.beNil();
}

- (void)test_itemAtIndexPath_negative_indexPathIsNil
{
    // given
    __block id obj = nil;
    
    // when
    void(^testBlock)() = ^{
        obj = [self.model itemAtIndexPath:nil];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
    expect(obj).to.beNil();
}

- (void)test_itemAtIndexPath_negative_indexPathIsNotAValidClass
{
    // when
    __block id obj = nil;
    
    // then
    void(^testBlock)() = ^{
        obj = [self.model itemAtIndexPath:(NSIndexPath*)@""];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
    expect(obj).to.beNil();
}

@end
