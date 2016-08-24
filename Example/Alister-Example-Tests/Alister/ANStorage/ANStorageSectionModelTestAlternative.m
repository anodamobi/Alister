//
//  ANStorageSectionModelTestAlternative.m
//  FStop
//
//  Created by Maxim Eremenko on 8/19/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "ANStorageSectionModel.h"

static NSInteger const kMaxObjectsCount = 4;

@interface ANStorageSectionModelTestAlternative : XCTestCase

@property (nonatomic, strong) ANStorageSectionModel* sectionModel;

@end

@implementation ANStorageSectionModelTestAlternative

- (void)setUp
{
    [super setUp];
    self.sectionModel = [ANStorageSectionModel new];
}

- (void)tearDown
{
    self.sectionModel = nil;
    [super tearDown];
}

- (void)test_conformsProtocol_positive
{
    expect(self.sectionModel).conformTo(@protocol(ANStorageSectionModelInterface));
}

#pragma mark - Test addItem

- (void)test_addItem_positive_countOfObjectsIncreaseByOne
{
    // given
    id obj = [NSObject new];
    NSUInteger countBefore = self.sectionModel.objects.count;
    
    // when
    [self.sectionModel addItem:obj];
    
    // then
    NSUInteger countAfter = self.sectionModel.objects.count;
    expect(countBefore + 1).to.equal(countAfter);
}

- (void)test_addItem_negative_toNotRaiseExceptionWhenAddNil
{
    // given
    id obj = nil;
    // when
    void(^block)() = ^() {
        [self.sectionModel addItem:obj];
    };
    // then
    expect(block).notTo.raiseAny();
}

- (void)test_addItem_positive_whenValid
{
    //given
    id obj = [NSObject new];
    
    //when
    [self.sectionModel addItem:obj];
    
    //then
    expect(self.sectionModel.objects[0]).equal(obj);
}


#pragma mark - Test insertItem: atIndex:

- (void)test_insertItem_positive_countOfObjectsIncreasedByOne
{
    // given
    id obj = [NSObject new];
    NSUInteger countBefore = self.sectionModel.objects.count;
    // when
    [self.sectionModel insertItem:obj atIndex:0];
    // then
    NSUInteger countAfter = self.sectionModel.objects.count;
    expect(countBefore + 1).to.equal(countAfter);
}

- (void)test_insertItemAtIndex_positive_whenValidData
{
    // given
    id obj = [NSObject new];
    NSInteger index = 0;
    
    //when
    [self.sectionModel insertItem:obj atIndex:index];
    
    //then
    expect(self.sectionModel.objects[index]).equal(obj);
}

- (void)test_insertItemAtIndex_positive_toNotRaiseExceptionWhenGetObjectAtIndex
{
    // given
    id obj = [NSObject new];
    NSInteger index = 0;
    
    //when
    [self.sectionModel insertItem:obj atIndex:index];
    
    //then
    expect(^{
        [self.sectionModel.objects objectAtIndex:index];
    }).notTo.raiseAny();
}

- (void)test_insertItem_negative_toNotRaiseExceptionWhenInsertAdd
{
    // given
    id obj = nil;
    // when
    void(^block)() = ^() {
        [self.sectionModel insertItem:obj atIndex:0];
    };
    // then
    expect(block).notTo.raiseAny();
}

- (void)test_insertItem_negative_toNotRaiseExceptionWhenInsertNegativeIndex
{
    // given
    id obj = [NSObject new];
    // when
    void(^block)() = ^() {
        [self.sectionModel insertItem:obj atIndex:-20];
    };
    // then
    expect(block).notTo.raiseAny();
}

- (void)test_insertItem_negative_toNotRaiseExceptionWhenInsertNotExistingIndex
{
    // given
    id obj = [NSObject new];
    NSUInteger index = (NSUInteger)arc4random();
    // when
    void(^block)() = ^() {
        [self.sectionModel insertItem:obj atIndex:index];
    };
    // then
    expect(block).notTo.raiseAny();
}

- (void)test_insertItem_negative_toNotRaiseExceptionWhenAddBoundaryElement
{
    // given
    id obj = [NSObject new];
    [self.sectionModel addItem:obj];
    // when
    void(^block)() = ^() {
        [self.sectionModel insertItem:obj atIndex:1];
    };
    // then
    expect(block).notTo.raiseAny();
}

- (void)test_insertItemAtIndex_negative_whenIndexNSNotFound
{
    // when
    void(^testBlock)() = ^() {
        [self.sectionModel insertItem:[NSObject new] atIndex:NSNotFound];
    };
    
    //then
    expect(testBlock).notTo.raiseAny();
}

#pragma mark - removeItemAtIndex

- (void)test_removeItemAtIndex_positive_modelNotContainsObject
{
    // given
    NSUInteger maxIndex = arc4random_uniform(kMaxObjectsCount) + 1;
    
    for (NSUInteger counter = 0; counter < maxIndex; counter++)
    {
        id item = [NSObject new];
        [self.sectionModel addItem:item];
    }
    
    // when
    NSUInteger randomIndex = arc4random_uniform((u_int32_t)maxIndex);
    NSObject* removedObject = self.sectionModel.objects[randomIndex];
    
    [self.sectionModel removeItemAtIndex:randomIndex];
    
    // then
    expect(self.sectionModel.objects).notTo.contain(removedObject);
}

- (void)test_removeItemAtIndex_positive_objectsDeletedOnce
{
    // given
    NSUInteger maxIndex = (NSUInteger)arc4random_uniform((u_int32_t)kMaxObjectsCount);
    
    for (NSUInteger counter = 0; counter < maxIndex; counter++)
    {
        id item = [NSObject new];
        [self.sectionModel addItem:item];
    }
    
    // when
    NSUInteger objectsCount = self.sectionModel.objects.count;

    NSUInteger countDeletions = arc4random_uniform((u_int32_t)maxIndex);
    for (NSUInteger counter = 0; counter < countDeletions; counter++)
    {
        NSUInteger randomIndex = arc4random_uniform((u_int32_t)self.sectionModel.objects.count);
        [self.sectionModel removeItemAtIndex:randomIndex];
    }
    
    // then
    expect(objectsCount).to.equal(self.sectionModel.objects.count + countDeletions);
}

- (void)test_removeItemAtIndex_negative_toNotRaiseExceptionWhenRemoveNegativeIndex
{
    void(^testBlock)() = ^() {
        [self.sectionModel removeItemAtIndex:-10];
    };
    expect(testBlock).notTo.raiseAny();
}

- (void)test_removeItemAtIndex_negative_toNotRaiseExceptionWhenRemoveNotExistingIndex
{
    // given
    NSUInteger index = (NSUInteger)arc4random();
    
    // when
    void(^testBlock)() = ^() {
        [self.sectionModel removeItemAtIndex:index];
    };
    
    // given
    expect(testBlock).notTo.raiseAny();
}

- (void)test_removeItemAtIndex_negative_indexNSNotFound
{
    //when
    void(^block)() = ^() {
        [self.sectionModel removeItemAtIndex:NSNotFound];
    };
    
    //then
    expect(block).notTo.raiseAny();
}


#pragma mark - Test replaceItemAtIndex: withItem:

- (void)test_replaceItemAtIndexWithItem_positive_modelNotContainsNewObject
{
    // given
    NSUInteger maxObjectsCount = arc4random_uniform(kMaxObjectsCount);
    id initialItem = [NSObject new];

    for (NSUInteger counter = 0; counter < maxObjectsCount; counter++)
    {
        [self.sectionModel addItem:initialItem];
    }
    
    // when
    id object = [NSObject new];
    for (NSUInteger counter = 0; counter < maxObjectsCount; counter++)
    {
        [self.sectionModel replaceItemAtIndex:counter withItem:object];
    }
    
    // then
    expect(self.sectionModel.objects).notTo.contain(initialItem);
}

- (void)test_replaceItemAtIndex_negative_toNotRaiseExceptionWhenReplaceWithNilObject
{
    // given
    id nilObject = nil;
    [self.sectionModel addItem:[NSObject new]];
    
    // when
    void(^testBlock)() = ^() {
        [self.sectionModel replaceItemAtIndex:0 withItem:nilObject];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_replaceItemAtIndex_negative_toNotRaiseExceptionWhenReplaceWithNegativeIndex
{
    // given
    id newItem = [NSObject new];
    
    // when
    void(^testBlock)() = ^() {
        [self.sectionModel replaceItemAtIndex:-1 withItem:newItem];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - numberOfObjects

- (void)test_numberOfObjects_positive_modelReturnsCorrectNumberOfObjects
{
    // given
    id item = [NSObject new];
    
    // when
    [self.sectionModel addItem:item];
    
    // then
    NSInteger objectsCount = self.sectionModel.objects.count;
    expect(self.sectionModel.numberOfObjects).to.equal(objectsCount);
}

- (void)test_numberOfObjects_positive_emptyWhenCreated
{
    expect([self.sectionModel numberOfObjects]).equal(0);
}

- (void)test_objects_positive_validObjectsAfterAdding
{
    //given
    id item = [NSObject new];
    
    //when
    [self.sectionModel addItem:item];
    
    //then
    expect([self.sectionModel objects]).equal(@[item]);
}


#pragma mark - supplementaryModelOfKind

- (void)test_supplementaryModelOfKind_positive_initialAndReturnedModelsAreEqual
{
    // given
    id model = @"model";
    id modelClassName = NSStringFromClass([model class]);
    
    [self.sectionModel updateSupplementaryModel:model forKind:modelClassName];
    
    // when
    id returnedModel = [self.sectionModel supplementaryModelOfKind:modelClassName];
    
    // then
    expect(returnedModel).equal(model);
}

- (void)test_supplementaryModelOfKind_negative_notRegisteredModelIsNil
{
    // given
    id notRegisteredClassName = @"className";
    id returnedModel = [self.sectionModel supplementaryModelOfKind:notRegisteredClassName];
    
    // then
    expect(returnedModel).to.beNil();
}

- (void)test_supplementaryModelOfKind_negative_notRaiseExceptionWhenRequestModelAtNilObject
{
    // given
    id nilClassName = nil;
    
    // when
    void(^testBlock)() = ^() {
        [self.sectionModel supplementaryModelOfKind:nilClassName];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - updateSupplementaryModel: forKind:

- (void)test_updateSupplementaryModelForKind_positive_initialAndReturnedModelsAreEqual
{
    // given
    NSString* initialStringModel = @"model";
    NSNumber* initialNumberModel = @2;
    
    NSString* kString = @"stringClassName";
    NSString* kNumber = @"numberClassName";
    
    // when
    [self.sectionModel updateSupplementaryModel:initialStringModel forKind:kString];
    [self.sectionModel updateSupplementaryModel:initialNumberModel forKind:kNumber];
    
    // then
    id returnedStringModel = [self.sectionModel supplementaryModelOfKind:kString];
    id returnedNumberModel = [self.sectionModel supplementaryModelOfKind:kNumber];
    
    expect(returnedStringModel).to.equal(initialStringModel);
    expect(returnedNumberModel).to.equal(initialNumberModel);
}

- (void)test_updateSupplementaryModelForKind_negative_notRaiseExceptionWhenAddNilModel
{
    // given
    id model = nil;
    id modelClassName = @"modelClassName";
    
    // when
    void(^testBlock)() = ^() {
        [self.sectionModel updateSupplementaryModel:model forKind:modelClassName];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_updateSupplementaryModelForKind_negative_notRaiseExceptionWhenAddNilClass
{
    // given
    id model = @"model";
    id modelClassName = nil;
    
    // when
    void(^testBlock)() = ^() {
        [self.sectionModel updateSupplementaryModel:model forKind:modelClassName];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}

- (void)test_updateSupplementaryModelForKind_negative_notRaiseExceptionWhenUpdateWithBothNilValues
{
    // given
    id model = nil;
    id modelClassName = nil;
    
    // when
    void(^testBlock)() = ^() {
        [self.sectionModel updateSupplementaryModel:model forKind:modelClassName];
    };
    
    // then
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - objects

- (void)test_objects_positive_returnValidObjectsCount
{
    // given
    id item = [NSObject new];
    
    NSInteger maxCountObjects = kMaxObjectsCount;
    
    for (NSInteger counter = 0; counter < maxCountObjects; counter++)
    {
        [self.sectionModel addItem:item];
    }
    
    // then
    expect(self.sectionModel.objects.count).to.equal(maxCountObjects);
}

- (void)test_objects_positive_containsAddedItems
{
    // given
    id item = [NSObject new];

    NSInteger maxCountObjects = kMaxObjectsCount;
    NSMutableArray* initialObjects = [NSMutableArray array];
    
    for (NSInteger counter = 0; counter < maxCountObjects; counter++)
    {
        [self.sectionModel addItem:item];
        [initialObjects addObject:item];
    }
    
    expect(self.sectionModel.objects).to.equal(initialObjects);
}

@end
