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

@end

@implementation ANStorageSectionModelTest

- (void)setUp
{
    [super setUp];
    self.model = [ANStorageSectionModel new];
}

- (void)tearDown
{
    self.model = nil;
    [super tearDown];
}

- (void)test_conformsProtocol_positive
{
    expect(self.model).conformTo(@protocol(ANStorageSectionModelInterface));
}


/**
 *  - (void)addItem:(id)item
 */
- (void)test_addItem_positive_whenNotNil
{
    //given
    NSString* test = @"test";
    
    //when
    [self.model addItem:test];
    
    //then
    expect(self.model.objects[0]).equal(test);
}

- (void)test_addItem_positive_itemAddsOnlyOnce
{
    //given
    NSString* test = @"test";
    
    //when
    [self.model addItem:test];
    
    //then
    expect(self.model.objects).haveCount(1);
}

- (void)test_addItem_negative_addNilThrowsException
{
    //given
    NSString* test = nil;

    //then
    expect(^{
        //when
        [self.model addItem:test];
    }).to.raiseAny();
}

- (void)test_insertItemAtIndex_positive_whenNotNilAndValidIndex
{
	//given
    NSString* item = @"test";
    NSUInteger index = 0;
    
    //when
    [self.model insertItem:item atIndex:index];
    
    //then
    expect(self.model.objects).haveCount(1);
    expect(self.model.objects[index]).equal(item);
    expect(^{
        [self.model.objects objectAtIndex:index];
    }).notTo.raiseAny();
}

- (void)test_removeItemAtIndex_success_whenObjectAtIndexExists
{
    //given
    NSString* item = @"test";
    NSUInteger index = 0;
    [self.model insertItem:item atIndex:index];
    
    //when
    [self.model removeItemAtIndex:index];
    
    //then
    expect(self.model.objects).haveCount(0);
    expect(^{
        [self.model.objects objectAtIndex:index];
    }).to.raise(NSRangeException);
}

- (void)test_replaceItemAtIndexWithItem_success
{
	
}

- (void)testNumberOfObjects
{
	
}

- (void)testObjects
{
	
}

- (void)testSupplementaryModelOfKind
{
	
}

- (void)updateSupplementaryModel:(id)model forKind:(NSString*)kind
{
	
}


@end
