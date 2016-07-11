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


#pragma mark - itemAtIndexPath

- (void)test_itemAtIndexPath_positive_dataIsValidForFirstItem
{
	//given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.fixtureObject];
    [self.model addSection:section];
    
    //when
    NSIndexPath* firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    id object = [self.model itemAtIndexPath:firstItemIndexPath];
    //then
    XCTAssertEqualObjects(self.fixtureObject, object, @"%@ is equal to object %@", self.fixtureObject, object);
}

- (void)test_itemAtIndexPath_negative_indexPathIsNil
{
    //given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.fixtureObject];
    [self.model addSection:section];
    //when
    NSIndexPath* negativeIndexPath = [NSIndexPath indexPathForItem:-1 inSection:0];
    id object = [self.model itemAtIndexPath:negativeIndexPath];
    //then
    XCTAssertNil(object, @"object %@ is equal nil", object);
}

- (void)test_itemAtIndexPath_negative_indexPathInvalid
{
    //given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.fixtureObject];
    [self.model addSection:section];
    //when
    NSIndexPath* invalideIndexPath = nil;
    //then
    id object = [self.model itemAtIndexPath:invalideIndexPath];
    
     XCTAssertNil(object, @"object %@ is equal nil", object);
}


#pragma mark - itemsInSection

- (void)test_itemsInSection_positive_modelHasItems
{
    //given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [section addItem:self.fixtureObject];
    [section addItem:self.fixtureObject];
    
    NSInteger expectedModelsCount = section.objects.count;
    [self.model addSection:section];
    
    //when
    ANStorageSectionModel* firstSection = self.model.sections.firstObject;
    //then
    XCTAssertEqual(section.objects.count, firstSection.objects.count);
}

- (void)test_itemsInSection_positive_modelIsEmpty
{
    //given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];
    //when
    ANStorageSectionModel* firstSection = self.model.sections.firstObject;
    //then
    NSInteger objectsCount = (NSInteger)firstSection.objects.count;
    XCTAssertEqual(objectsCount, 0);
}

- (void)test_itemsInSection_negative_sectionNotExists
{
    //given
    
    //when
    id section = self.model.sections.firstObject;
    //then
    XCTAssertNil(section);
}

- (void)test_itemsInSection_negative_sectionIndexLessThanZero
{
    //given
    
    //when
    
    //then
}


#pragma mark - sections

- (void)test_sections_positive_sectionsAreEmpty
{
    //given
    //when
    id firstSection = self.model.sections.firstObject;
    //then
    XCTAssertNil(firstSection, @"first section is not empty");
}

- (void)test_sections_positive_sectionAddedAndCountIsOne
{
    //given
    NSInteger expectedSectionsCount = 1;
    ANStorageSectionModel* sectionModel = [ANStorageSectionModel new];
    [self.model addSection:sectionModel];
    //when
    
    //then
    XCTAssertNotNil(self.model.sections.firstObject);
    XCTAssertEqual((NSInteger)self.model.sections.count, expectedSectionsCount);
}


#pragma mark - sectionAtIndex:

- (void)test_sectionAtIndex_positive_storageIsEmpty
{
    //given
    NSInteger notExistSectionIndex = 2;
    //when
    id section = [self.model sectionAtIndex:notExistSectionIndex];
    //then
    XCTAssertNil(section, @"section not nil");
}

- (void)test_sectionAtIndex_positive_whenItemAddedZeroSectionExists
{
    //given
    
    //when
    
    //then
}

- (void)test_sectionAtIndex_negative_indexIsLessThanZero
{
    //given
    NSInteger negativeIndex = -1;
    //when
    id section = [self.model sectionAtIndex:negativeIndex];
    //then
    XCTAssertNil(section,@"section %@ is nil", section);
}

- (void)test_sectionAtIndex_negative_indexIsNsNotFound
{
    //given
    NSInteger index = NSNotFound;
    //when
    id section = [self.model sectionAtIndex:index];
    //then
    XCTAssertNil(section,@"section %@ is nil with index equal NSNotFound ", section);
}

- (void)test_sectionAtIndex_negative_indexNotExists
{
    //given
    NSInteger notexistIndex = 5;
    ANStorageSectionModel* section  = [ANStorageSectionModel new];
    [self.model addSection:section];
    
    //when
    id object = [self.model sectionAtIndex:notexistIndex];
    //then
    XCTAssertNil(object, @"section %@ is nil with not exist index", object);
}


#pragma mark - addSection:

- (void)test_addSection_positive_sectionIsValid
{
    //given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];
    //when
    id object = [self.model sectionAtIndex:0];
    //then
    XCTAssertNotNil(object);
    XCTAssertEqualObjects(NSStringFromClass([section class]), NSStringFromClass([object class]), @"class %@ is equal %@",NSStringFromClass([section class]), NSStringFromClass([object class]));
}

- (void)test_addSection_negative_sectionIsNil
{
    //given
    void (^testBlock)() = ^{
        [self.model addSection:nil];
    };
    //when
    
    //then
    XCTAssertThrows(testBlock());
}

- (void)test_addSection_negative_sectionIsNotKindSectionModel
{
    //given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];
    //when
    id object = [self.model sectionAtIndex:0];
    //then
    XCTAssertEqualObjects(NSStringFromClass([section class]), NSStringFromClass([object class]), @"class %@ is equal %@",NSStringFromClass([section class]), NSStringFromClass([object class]));
}


#pragma mark - removeSectionAtIndex:

- (void)test_removeSectionAtIndex_positive_indexIsValid
{
    //given
    NSUInteger removedSectionIndex;
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];
    //when
    
    XCTAssertEqual(self.model.sections.count, (NSUInteger)1);
    [self.model removeSectionAtIndex:removedSectionIndex];
    //then
    XCTAssertEqual(self.model.sections.count, (NSUInteger)0);
}

- (void)test_removeSectionAtIndex_negative_indexIsZeroWhenModelIsEmpty
{
    //given
    NSInteger notExistSectionIndex = 0;
    //when
    void(^testBlock)() = ^{
        [self.model removeSectionAtIndex:notExistSectionIndex];
    };
    //then
    XCTAssertThrows(testBlock());
}

- (void)test_removeSectionAtIndex_negative_indexIsLessThanZero
{
    //given
    NSInteger negativeIndex = -1;
    //when
    void(^testBlock)() = ^{
        [self.model removeSectionAtIndex:negativeIndex];
    };
    //then
    XCTAssertThrows(testBlock());
}

- (void)test_removeSectionAtIndex_negative_indexIsNSNotFound
{
    //given
    NSInteger index = NSNotFound;
    //when
    void(^testBlock)() = ^{
        [self.model removeSectionAtIndex:index];
    };
    //then
    XCTAssertThrows(testBlock());
}


#pragma mark - removeAllSections

- (void)test_removeAllSections_positive_sectionsEmptyAfterAddOne
{
    //given
    ANStorageSectionModel* section = [ANStorageSectionModel new];
    [self.model addSection:section];
    //when
    XCTAssertNotNil(self.model.sections.firstObject);
    [self.model removeAllSections];
    //then
    XCTAssertNil(self.model.sections.firstObject);
}

//- (void)test_removeAllSections_positive_removeAllSectionsWhenModelIsEmpty
//{
//    //given
//    ANStorageModel* storageModel = nil;
//    //when
//    void(^testBlock)() = ^{
//        [storageModel removeAllSections];
//    };
//    //then
//    XCTAssertThrows(testBlock());
//}

@end
