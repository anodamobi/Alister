//
//  ANStorageModelTest.m
//  Alister
//
//  Created by Oksana on 7/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANStorageModel.h"

@interface ANStorageModelTest : XCTestCase

@property (nonatomic, strong) ANStorageModel* model;

@end

@implementation ANStorageModelTest

- (void)setUp
{
    [super setUp];

    self.model = [ANStorageModel new];
}

- (void)tearDown
{
    self.model = nil;
    [super tearDown];
}


#pragma mark - itemAtIndexPath

- (void)test_itemAtIndexPath_positive_dataIsValid
{
	//given
    
    //when
    
    //then
}

- (void)test_itemAtIndexPath_negative_indexPathIsNil
{
    //given
    
    //when
    
    //then
}

- (void)test_itemAtIndexPath_negative_indexPathInvalid
{
    //given
    
    //when
    
    //then
}


#pragma mark - itemsInSection

- (void)test_itemsInSection_positive_modelHasItems
{
    //given
    
    //when
    
    //then
}

- (void)test_itemsInSection_positive_modelIsEmpty
{
    //given
    
    //when
    
    //then
}

- (void)test_itemsInSection_negative_sectionNotExists
{
    //given
    
    //when
    
    //then
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
    
    //then
}

- (void)test_sections_positive_sectionAddedAndCountIsOne
{
    //given
    
    //when
    
    //then
}


#pragma mark - sectionAtIndex:

- (void)test_sectionAtIndex_positive_storageIsEmpty
{
    //given
    
    //when
    
    //then
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
    
    //when
    
    //then
}

- (void)test_sectionAtIndex_negative_indexIsNsNotFound
{
    //given
    
    //when
    
    //then
}

- (void)test_sectionAtIndex_negative_indexNotExists
{
    //given
    
    //when
    
    //then
}


#pragma mark - addSection:

- (void)test_addSection_positive_sectionIsValid
{
    //given
    
    //when
    
    //then
}

- (void)test_addSection_negative_sectionIsNil
{
    //given
    
    //when
    
    //then
}

- (void)test_addSection_negative_sectionIsNotKindSectionModel
{
    //given
    
    //when
    
    //then
}


#pragma mark - removeSectionAtIndex:

- (void)test_removeSectionAtIndex_positive_indexIsValid
{
    //given
    
    //when
    
    //then
}

- (void)test_removeSectionAtIndex_negative_indexIsZeroWhenModelIsEmpty
{
    //given
    
    //when
    
    //then
}

- (void)test_removeSectionAtIndex_negative_indexIsLessThanZero
{
    //given
    
    //when
    
    //then
}

- (void)test_removeSectionAtIndex_negative_indexIsNSNotFound
{
    //given
    
    //when
    
    //then
}


#pragma mark - removeAllSections

- (void)test_removeAllSections_positive_sectionsEmptyAfterAddOne
{
    //given
    
    //when
    
    //then
}

- (void)test_removeAllSections_positive_removeAllSectionsWhenModelIsEmpty
{
    //given
    
    //when
    
    //then
}

@end
