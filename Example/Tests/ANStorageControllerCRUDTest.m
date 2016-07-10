//
//  ANStorageControllerTest.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/2/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANStorageController.h"
#import <Expecta/Expecta.h>
#import "ANStorageSectionModel.h"
#import "ANStorageModel.h"

@interface ANStorageController ()

@property (nonatomic, copy) NSString* footerKind;
@property (nonatomic, copy) NSString* headerKind;

@end

@interface ANStorageControllerTest : XCTestCase

@property (nonatomic, strong) ANStorageController* controller;
@property (nonatomic, copy) NSString* testFixture;
@property (nonatomic, copy) NSString* testKind;

@end

@implementation ANStorageControllerTest

- (void)setUp
{
    [super setUp];
    self.controller = [ANStorageController new];
    self.testFixture = @"testFixture";
    self.testKind = @"testKind";
}

- (void)tearDown
{
    self.controller = nil;
    self.testFixture = nil;
    self.testKind = nil;
    [super tearDown];
}


#pragma mark - addItem

- (void)test_addItem_positive_objectExistsAtIndexPath
{
    //when
    [self.controller addItem:self.testFixture];
    
    //then
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(self.testFixture);
}

- (void)test_addItem_positive_sectionWasCreated
{
    //when
    [self.controller addItem:self.testFixture];
    
    //then
    expect(self.controller.sections).haveCount(1);
}

- (void)test_addItem_negative_itemIsNil
{
    expect(^{
    [self.controller addItem:nil];
    }).notTo.raiseAny();
}


#pragma mark - addItems

- (void)test_addItems_positive_dataIsValidAndHasCorrectOrder
{
    //given
    NSString* testModel0 = @"test0";
    NSString* testModel1 = @"test1";
    NSString* testModel2 = @"test2";
    NSArray* testModel = @[testModel0, testModel1, testModel2];
    
    //when
    [self.controller addItems:testModel];
    
    //then
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel[0]);
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).equal(testModel[1]);
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).equal(testModel[2]);
}

- (void)test_addItems_positive_dataAddedOnlyOnce
{
    //given
    NSArray* testModel = @[@"one", @"two", @"three"];
    
    //when
    [self.controller addItems:testModel];
    
    //then
    expect([self.controller itemsInSection:0]).haveCount(testModel.count);
}

- (void)test_addItems_negative_dataIsNil
{
    //then
    expect(^{
        [self.controller addItems:nil];
    }).notTo.raiseAny();
}

- (void)test_addItems_positive_addedEmptyArrayDontChangeTotalCount
{
    //given
    NSArray* testModel = @[];
    
    //when
    [self.controller addItems:testModel];
    
    //then
    expect([self.controller itemsInSection:0]).haveCount(0);
}


#pragma mark - addItemToSection:

- (void)test_addItemToSection_positive_dataIsValid
{
    //when
    [self.controller addItem:self.testFixture toSection:0];
    
    //then
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(self.testFixture);
}

- (void)test_addItemToSection_positive_generatesEmptySectionsIfNeeded
{
    //when
    [self.controller addItem:self.testFixture toSection:2];
    
    //then
    expect([self.controller itemsInSection:0]).haveCount(0);
    expect([self.controller itemsInSection:1]).haveCount(0);
    expect([self.controller itemsInSection:2]).haveCount(1);
    expect([self.controller sections]).haveCount(3);
}

//- (void)test_addItemToSection_negative_indexNSNotFound
//{
//    //then
//    expect(^{
//        [self.controller addItem:self.testFixture toSection:NSNotFound];
//    }).notTo.raiseAny();
//}

- (void)test_addItemToSection_negative_indexLessThanZero
{
    //then
    expect(^{
        [self.controller addItem:self.testFixture toSection:-1];
    }).notTo.raiseAny();
}

- (void)test_addItemToSection_negative_itemIsNil
{
    //then
    expect(^{
        [self.controller addItem:nil toSection:0];
    }).notTo.raiseAny();
}


#pragma mark - addItems: toSection:

- (void)test_addItemsToSection_positive_dataIsValidAndItemsHaveSameOrder
{
    //given
    NSString* testModel0 = @"test0";
    NSString* testModel1 = @"test1";
    NSString* testModel2 = @"test2";
    NSArray* testModel = @[testModel0, testModel1, testModel2];
    
    //when
    [self.controller addItems:testModel toSection:3];
    
    //then
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]]).equal(testModel[0]);
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]]).equal(testModel[1]);
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:3]]).equal(testModel[2]);
}

- (void)test_addItemsToSection_negative_itemsIsNil
{
    //then
    expect(^{
        [self.controller addItems:nil toSection:0];
    }).notTo.raiseAny();
}

- (void)test_addItemsToSection_negative_itemsAreEmpty
{
    //when
    [self.controller addItems:@[] toSection:0];
    
    //then
    expect(self.controller.sections).haveCount(0);
}

- (void)test_addItemsToSection_negative_indexLessThanZero
{
    //then
    expect(^{
        [self.controller addItems:@[@"one"] toSection:-1];
    }).notTo.raiseAny();
}

//This test have no sence while will create NSIntegerMax sections
//- (void)test_addItemsToSection_negative_indexNSNotFound
//{
//    //then
//    expect(^{
//        [self.controller addItems:@[@"one"] toSection:NSNotFound];
//    }).notTo.raiseAny();
//}


#pragma mark - addItem: atIndexPath

- (void)test_addItemAtIndexPath
{
    //given
    NSString* testModel = @"test";
    
    //when
    [self.controller addItem:testModel atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    //then
    expect([self.controller itemsInSection:0]).haveCount(0);
    expect([self.controller itemsInSection:1]).haveCount(1);
    expect([self.controller sections]).haveCount(2);
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]]).equal(testModel);
}

- (void)testReloadItem
{
	//mock
}

- (void)testReloadItems
{
	//mock
}

- (void)testRemoveItem
{
    //given
    NSString* testModel = @"test";
    [self.controller addItem:testModel];
    
    //when
    [self.controller removeItem:testModel];
    
    //then
    expect([self.controller itemsInSection:0]).haveCount(0);
    expect([self.controller sections]).haveCount(1);
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).beNil();
}

- (void)testRemoveItemsAtIndexPaths
{
    //given
    NSString* testModel = @"test";
    NSArray* indexPaths = @[[NSIndexPath indexPathForRow:0 inSection:0],
                            [NSIndexPath indexPathForRow:1 inSection:0],
                            [NSIndexPath indexPathForRow:2 inSection:0]];
    [self.controller addItem:testModel];
    [self.controller addItem:testModel];
    [self.controller addItem:testModel];
    
    //when
    [self.controller removeItemsAtIndexPaths:indexPaths];
    
    //then
    expect([self.controller itemsInSection:0]).haveCount(0);
    expect([self.controller sections]).haveCount(1);
}

- (void)testRemoveItems
{
    //given
    NSString* testModel = @"test0";
    NSArray* items = @[@"test1", @"test2", @"test3"];
    
    [self.controller addItem:testModel];
    [self.controller addItems:items];
    
    //when
    [self.controller removeItems:items];
    
    //then
    expect([self.controller itemsInSection:0]).haveCount(1);
}

- (void)testRemoveAllItems
{
    //given
    NSString* testModel = @"test0";
    NSArray* items = @[@"test1", @"test2", @"test3"];
    
    [self.controller addItem:testModel];
    [self.controller addItems:items];
    
    //when
    [self.controller removeAllItemsAndSections];
    
    //then
    expect([self.controller sections]).haveCount(0);
    expect(self.controller.isEmpty).beTruthy();
}

- (void)testRemoveSections:(NSIndexSet*)indexSet
{
    //given
    NSString* testModel = @"test0";
    NSArray* items = @[@"test1", @"test2", @"test3"];
    
    [self.controller addItem:testModel toSection:1];
    [self.controller addItems:items toSection:0];
    
    //when
    [self.controller removeSections:[NSIndexSet indexSetWithIndex:0]];
    
    //then
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel);
    expect([self.controller sections]).haveCount(1);
    expect(self.controller.isEmpty).beFalsy();
}

- (void)testReplaceItemWithItem
{
    //given
    NSString* testModel = @"test0";
    NSString* testModel1 = @"test1";
    
    [self.controller addItem:testModel toSection:0];
    
    //when
    [self.controller replaceItem:testModel withItem:testModel1];
    
    //then
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel1);
    expect([self.controller sections]).haveCount(1);
    expect([self.controller itemsInSection:0]).haveCount(1);
}

- (void)testMoveItemFromIndexPathToIndexPath
{
    //given
    NSString* testModel = @"test0";
    
    [self.controller addItem:testModel toSection:0];
    
    //when
    [self.controller moveItemFromIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                               toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    //then
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]]).equal(testModel);
    expect([self.controller itemsInSection:0]).haveCount(0);
}

- (void)testSections
{
    //given
    NSString* testModel = @"test0";
    
    //when
    [self.controller addItem:testModel toSection:0];
    [self.controller addItem:testModel toSection:1];
    [self.controller addItem:testModel toSection:2];
    
    //then
    expect([self.controller sections]).haveCount(3);
}

- (void)testObjectAtIndexPath
{
    //given
    NSString* testModel = @"test0";
    
    //when
    [self.controller addItem:testModel toSection:0];
    
    //then
    expect([self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel);
}

- (void)testSectionAtIndex
{
    //given
    NSString* testModel = @"test0";
    [self.controller addItem:testModel toSection:0];
    
    //when
    ANStorageSectionModel* section = [self.controller sectionAtIndex:0];
    
    //then
    expect(self.controller.storage.sections[0]).equal(section);
    expect(self.controller.storage.sections[0]).notTo.beNil();
}

- (void)testItemsInSection
{
    //given
    NSString* testModel = @"test0";
    [self.controller addItem:testModel toSection:0];
    
    //when
    ANStorageSectionModel* section = [self.controller sectionAtIndex:0];
    
    //then
    expect(self.controller.storage.sections[0]).equal(section);
}

- (void)testItemAtIndexPath
{
    //given
    NSString* testModel = @"test0";
    [self.controller addItem:testModel toSection:0];
    
    //when
    id testableModel = [self.controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    //then
    expect([[self.controller.storage.sections[0] objects] objectAtIndex:0]).equal(testableModel);
    expect(testableModel).notTo.beNil();
}

- (void)testIndexPathForItem
{
    //given
    NSString* testModel = @"test0";
    [self.controller addItem:testModel toSection:0];
    
    //when
    NSIndexPath* indexPath = [self.controller indexPathForItem:testModel];
    
    //then
    expect([[self.controller.storage.sections[0] objects] objectAtIndex:0]).equal(testModel);
    expect(indexPath).notTo.beNil();
    expect(indexPath).equal([NSIndexPath indexPathForRow:0 inSection:0]);
}

- (void)testIsEmpty
{
    //given
    expect(self.controller.isEmpty).beTruthy();
    
    //when
    [self.controller addItem:@"test"];
    
    //then
    expect(self.controller.isEmpty).beFalsy();
    
    //when
    [self.controller removeAllItemsAndSections];
    
    //then
    expect(self.controller.isEmpty).beTruthy();
}

#pragma mark - Supplementaries

- (void)testSetSectionHeaderModelForSectionIndex
{
    //given
    NSString* testModel = @"test";
    [self.controller setSupplementaryHeaderKind:@"testKind"];
    
    //when
    [self.controller setSectionHeaderModel:testModel forSectionIndex:0];
    
    //then
    expect([self.controller itemsInSection:0]).haveCount(0);
    expect([self.controller headerModelForSectionIndex:0]).equal(testModel);
    expect([self.controller headerModelForSectionIndex:1]).beNil();
    expect([self.controller footerModelForSectionIndex:0]).beNil();
}

- (void)testSetSectionFooterModelForSectionIndex
{
    //given
    NSString* testModel = @"test";
    [self.controller setSupplementaryFooterKind:@"testKind"];
    
    //when
    [self.controller setSectionFooterModel:testModel forSectionIndex:0];
    
    //then
    expect([self.controller itemsInSection:0]).haveCount(0);
    expect([self.controller footerModelForSectionIndex:0]).equal(testModel);
    expect([self.controller footerModelForSectionIndex:1]).beNil();
    expect([self.controller headerModelForSectionIndex:0]).beNil();
}

- (void)testSetSupplementaryHeaderKind
{
    //given
    NSString* testModel = @"testKind";
    
    //when
    [self.controller setSupplementaryHeaderKind:testModel];
    
    //then
    expect(self.controller.headerKind).equal(testModel);
    expect(self.controller.headerKind).notTo.beNil();
    expect(self.controller.footerKind).beNil();
}

- (void)testSetSupplementaryFooterKind
{
    //given
    NSString* testModel = @"testKind";
    
    //when
    [self.controller setSupplementaryFooterKind:testModel];
    
    //then
    expect(self.controller.footerKind).equal(testModel);
    expect(self.controller.footerKind).notTo.beNil();
    expect(self.controller.headerKind).beNil();
}

- (void)testHeaderModelForSectionIndex
{
    //given
    NSString* testModel = @"test";
    NSString* testKind = @"testKind";
    [self.controller setSupplementaryHeaderKind:testKind];
    
    //when
    [self.controller setSectionHeaderModel:testModel forSectionIndex:0];
    
    //then
    expect([self.controller headerModelForSectionIndex:0]).equal(testModel);
    expect([self.controller footerModelForSectionIndex:0]).beNil();
    expect([self.controller supplementaryModelOfKind:testKind forSectionIndex:0]).equal(testModel);
}

- (void)testFooterModelForSectionIndex
{
    //given
    NSString* testModel = @"test";
    NSString* testKind = @"testKind";
    [self.controller setSupplementaryFooterKind:testKind];
    
    //when
    [self.controller setSectionFooterModel:testModel forSectionIndex:0];
    
    //then
    expect([self.controller footerModelForSectionIndex:0]).equal(testModel);
    expect([self.controller headerModelForSectionIndex:0]).beNil();
    expect([self.controller supplementaryModelOfKind:testKind forSectionIndex:0]).equal(testModel);
}

- (void)testSupplementaryModelOfKindForSectionIndex
{
    //given
    NSString* testModel = @"test";
    NSString* testKind = @"testKind";
    [self.controller setSupplementaryFooterKind:testKind];
    
    //when
    [self.controller setSectionFooterModel:testModel forSectionIndex:0];
    
    //then
    expect([self.controller supplementaryModelOfKind:testKind forSectionIndex:0]).equal(testModel);
}

@end
