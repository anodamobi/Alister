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
	
}

- (void)test_itemsInSection_positive_modelIsEmpty
{
    
}

- (void)test_itemsInSection_negative_sectionNotExists
{
    
}

- (void)test_itemsInSection_negative_sectionIndexLessThanZero
{
    
}


#pragma mark - sections

- (void)test_sections_positive_sectionsAreEmpty
{
	
}

- (void)test_sections_positive_sectionAddedAndCountIsOne
{
    
}


#pragma mark - sectionAtIndex:

- (void)test_sectionAtIndex_positive_storageIsEmpty
{
	
}

- (void)test_sectionAtIndex_positive_whenItemAddedZeroSectionExists
{
    
}

- (void)test_sectionAtIndex_negative_indexIsLessThanZero
{
    
}

- (void)test_sectionAtIndex_negative_indexIsNsNotFound
{
    
}

- (void)test_sectionAtIndex_negative_indexNotExists
{
    
}


#pragma mark - addSection:

- (void)test_addSection_positive_sectionIsValid
{
	
}

- (void)test_addSection_negative_sectionIsNil
{
    
}

- (void)test_addSection_negative_sectionIsNotKindSectionModel
{
    
}


#pragma mark - removeSectionAtIndex:

- (void)test_removeSectionAtIndex_positive_indexIsValid
{
	
}

- (void)test_removeSectionAtIndex_negative_indexIsZeroWhenModelIsEmpty
{
    
}

- (void)test_removeSectionAtIndex_negative_indexIsLessThanZero
{
    
}

- (void)test_removeSectionAtIndex_negative_indexIsNSNotFound
{
    
}


#pragma mark - removeAllSections

- (void)test_removeAllSections_positive_sectionsEmptyAfterAddOne
{
	
}

- (void)test_removeAllSections_positive_removeAllSectionsWhenModelIsEmpty
{
    
}

@end
