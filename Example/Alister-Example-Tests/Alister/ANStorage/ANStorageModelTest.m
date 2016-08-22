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

- (void)test_addSection_positive_sectionsCountValid
{
    NSInteger counter = arc4random_uniform(20);
    for (NSInteger i = 0; i < counter; i++)
    {
        [self.model addSection:[ANStorageSectionModel new]];
    }
    expect(self.model.sections).haveCount(counter);
}

- (void)test_addSection_negative_noAssertIfTryToAddNil
{
    void(^TestBlock)(void) = ^{
       [self.model addSection:nil];
    };
    expect(TestBlock).notTo.raiseAny();
    expect(self.model.sections).haveCount(0);
}

- (void)test_addSection_negative_noAssertIfTryToAddInvalidObject
{
    void(^TestBlock)(void) = ^{
        [self.model addSection:(ANStorageSectionModel*)@""];
    };
    expect(TestBlock).notTo.raiseAny();
    expect(self.model.sections).haveCount(0);
}


#pragma mark - itemsInSection

- (void)test_itemsInSection_positive_objectsMatch
{
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.fixtureObject];
    [self.model addSection:section];
    
    expect([self.model itemsInSection:0]).equal(section.objects);
}

- (void)test_itemsInSection_negative_whenSectionIndexInvalidNoAssert
{
    void(^TestBlock)(void) = ^{
        [self.model itemsInSection:arc4random()];
    };
    expect(TestBlock).notTo.raiseAny();
}


#pragma mark - sectionAtIndex

- (void)test_sectionAtIndex_positive_sectionExists
{
    u_int32_t counter = arc4random_uniform(20);
    for (NSUInteger i = 0; i < counter; i++)
    {
        [self.model addSection:[ANStorageSectionModel new]];
    }

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
    u_int32_t counter = arc4random_uniform(20);
    for (NSUInteger i = 0; i < counter; i++)
    {
        [self.model addSection:[ANStorageSectionModel new]];
    }
    u_int32_t sectionIndex = arc4random_uniform(counter);
    NSUInteger sectionsCount = self.model.sections.count;
    
    [self.model removeSectionAtIndex:sectionIndex];
    
    expect(sectionsCount - 1).equal(self.model.sections.count);
}

- (void)test_removeSectionAtIndex_negative_noCrashIfSectionNotExist
{
    void(^TestBlock)(void) = ^{
        [self.model removeSectionAtIndex:arc4random()];
    };
    expect(TestBlock).notTo.raiseAny();
}

- (void)test_removeSectionAtIndex_positive_removeLastSection
{
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];

    [self.model removeSectionAtIndex:0];
    
    expect(self.model.sections).haveCount(0);
}


#pragma mark - removeAllSections

- (void)test_removeAllSections_positive_noExistingSectionsAfterRemove
{
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];
    
    [self.model removeAllSections];
    
    expect(self.model.sections).haveCount(0);
}

- (void)test_removeAllSections_positive_sectionExistIfAddAfterRemove
{
    [self.model removeAllSections];
    
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];
    
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
    NSIndexPath* negativeIndexPath = [NSIndexPath indexPathForItem:arc4random()
                                                         inSection:arc4random()];
    
    expect([self.model itemAtIndexPath:negativeIndexPath]).to.beNil();
}

- (void)test_itemAtIndexPath_negative_indexPathIsNil
{
    __block id obj = nil;
    
    void(^testBlock)() = ^{
        obj = [self.model itemAtIndexPath:nil];
    };
    
    expect(testBlock).notTo.raiseAny();
    expect(obj).to.beNil();
}

- (void)test_itemAtIndexPath_negative_indexPathIsNotAValidClass
{
    __block id obj = nil;
    void(^testBlock)() = ^{
        obj = [self.model itemAtIndexPath:(NSIndexPath*)@""];
    };
    
    expect(testBlock).notTo.raiseAny();
    expect(obj).to.beNil();
}

@end
