//
//  ANStorageSectionModelTest.m
//  Alister
//
//  Created by Oksana on 7/5/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANStorageSectionModel.h"

@interface ANStorageSectionModelTest : XCTestCase

@property (nonatomic, strong) ANStorageSectionModel* model;
@property (nonatomic, strong) NSString* fixtureObject;
@property (nonatomic, assign) NSInteger fixtureIndex;

@end

@implementation ANStorageSectionModelTest

- (void)setUp
{
    [super setUp];
    self.model = [ANStorageSectionModel new];
    self.fixtureIndex = 0;
    self.fixtureObject = @"test";
}

- (void)tearDown
{
    self.model = nil;
    self.fixtureObject = nil;
    [super tearDown];
}

- (void)test_conformsProtocol_positive
{
    expect(self.model).conformTo(@protocol(ANStorageSectionModelInterface));
}


#pragma mark - addItem:

- (void)test_addItem_positive_whenValid
{
    //when
    [self.model addItem:self.fixtureObject];
    
    //then
    expect(self.model.objects[0]).equal(self.fixtureObject);
}

- (void)test_addItem_positive_itemAddsOnlyOnce
{
    //when
    [self.model addItem:self.fixtureObject];
    
    //then
    expect(self.model.objects).haveCount(1);
}

- (void)test_addItem_negative_addNilNotThrowException
{
    self.fixtureObject = nil;
    //then
    expect(^{
        //when
        [self.model addItem:self.fixtureObject];
    }).notTo.raiseAny();
}


#pragma mark - insertItem: atIndex:

- (void)test_insertItemAtIndex_positive_whenValidData
{
    //when
    [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    
    //then
    expect(self.model.objects[self.fixtureIndex]).equal(self.fixtureObject);
    expect(^{
        [self.model.objects objectAtIndex:self.fixtureIndex];
    }).notTo.raiseAny();
}

- (void)test_insertItemAtIndex_positive_addsOnlyOnce
{
    //when
    [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    
    //then
    expect(self.model.objects).haveCount(1);
}

- (void)test_insertItemAtIndex_negative_whenIndexNSNotFound
{
    self.fixtureIndex = NSNotFound;
    //then
    expect(^{
        [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    }).notTo.raiseAny();
}

- (void)test_insertItemAtIndex_negative_whenIndexLessThenZero
{
    self.fixtureIndex = -1;
    //then
    expect(^{
        [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    }).notTo.raiseAny();
}

- (void)test_insertItemAtIndex_negative_whenItemIsNilNoExpection
{
    self.fixtureObject = nil;
    //then
    expect(^{
        [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    }).notTo.raiseAny();
}


#pragma mark - removeItemAtIndex:

- (void)test_removeItemAtIndex_positive_indexValid
{
    //given
    [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    
    //when
    [self.model removeItemAtIndex:self.fixtureIndex];
    
    //then
    expect(self.model.objects).haveCount(0);
}

- (void)test_removeItemAtIndex_negative_indexNSNotFound
{
    //when
    self.fixtureIndex = NSNotFound;
    
    //then
    expect(^{
        [self.model removeItemAtIndex:self.fixtureIndex];
    }).notTo.raiseAny();
}

- (void)test_removeItemAtIndex_negative_indexLessThanZero
{
    //when
    self.fixtureIndex = -1;
    
    //then
    expect(^{
        [self.model removeItemAtIndex:self.fixtureIndex];
    }).notTo.raiseAny();
}


#pragma mark - replaceItemAtIndexWithItem:

- (void)test_replaceItemAtIndexWithItem_positive_objectAndIndexValid
{
    //given
    NSString* testObject = @"testObject";
    [self.model addItem:self.fixtureObject];
    
    //when
    [self.model replaceItemAtIndex:self.fixtureIndex withItem:testObject];
    
    //then
    expect([self.model objects][0]).equal(testObject);
}

- (void)test_replaceItemAtIndexWithItem_negative_objectIsNil
{
    //given
    NSString* testObject = nil;
    [self.model addItem:self.fixtureObject];
    
    //then
    expect(^{
        [self.model replaceItemAtIndex:self.fixtureIndex withItem:testObject];
    }).notTo.raiseAny();
}

- (void)test_replaceItemAtIndexWithItem_negative_indexNSNotFound
{
    //given
    [self.model addItem:self.fixtureObject];
    self.fixtureIndex = NSNotFound;
    
    //then
    expect(^{
        [self.model replaceItemAtIndex:self.fixtureIndex withItem:self.fixtureObject];
    }).notTo.raiseAny();
}

- (void)test_replaceItemAtIndexWithItem_negative_indexLessThanZero
{
    //given
    [self.model addItem:self.fixtureObject];
    self.fixtureIndex = -1;
    
    //then
    expect(^{
        [self.model replaceItemAtIndex:self.fixtureIndex withItem:self.fixtureObject];
    }).notTo.raiseAny();
}


#pragma mark - numberOfObjects

- (void)test_numberOfObjects_positive_emptyWhenCreated
{
    expect([self.model numberOfObjects]).equal(0);
}

- (void)test_numberOfObjects_positive_countAfterAddItem
{
    //when
    [self.model addItem:self.fixtureObject];
    
    //then
    expect([self.model numberOfObjects]).equal(1);
}

- (void)test_objects_positive_validObjectsAfterAdding
{
    //when
    [self.model addItem:self.fixtureObject];
    
    //then
    expect([self.model objects]).equal(@[self.fixtureObject]);
}


#pragma mark - supplementaryModelOfKind

- (void)test_supplementaryModelOfKind_positive
{
	//given
    NSString* kind = @"testKind";
    
    //when
    [self.model updateSupplementaryModel:self.fixtureObject forKind:kind];
    
    //then
    expect([self.model supplementaryModelOfKind:kind]).equal(self.fixtureObject);
}

- (void)test_supplementaryModelOfKind_negative_kindIsNil
{
    //given
    NSString* kind = @"testKind";
    
    //when
    [self.model updateSupplementaryModel:self.fixtureObject forKind:kind];
    
    //then
    expect(^{
        [self.model supplementaryModelOfKind:nil];
    }).notTo.raiseAny();
}


#pragma mark - updateSupplementaryModelForKind

- (void)test_updateSupplementaryModelForKind_positive_dataIsValid
{
    //given
    NSString* kind = @"testKind";
    
    //when
    [self.model updateSupplementaryModel:self.fixtureObject forKind:kind];
    
    //then
    expect([self.model supplementaryModelOfKind:kind]).equal(self.fixtureObject);
}

- (void)test_updateSupplementaryModelForKind_negative_kindIsNil
{
    //then
    expect(^{
        [self.model updateSupplementaryModel:self.fixtureObject forKind:nil];
    }).notTo.raiseAny();
}

- (void)test_updateSupplementaryModelForKind_negative_modelIsNil
{
    //given
    NSString* kind = @"testKind";
    self.fixtureObject = nil;
    
    //then
    expect(^{
        [self.model updateSupplementaryModel:nil forKind:kind];
    }).notTo.raiseAny();
}

@end
