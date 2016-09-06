//
//  ANStorageSectionModelTestAlternative.m
//  Alister
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

- (void)test_addItem_positive_countOfObjectsIncreasedByOne
{
    id obj = [NSObject new];
    NSUInteger countBefore = self.sectionModel.objects.count;
    
    [self.sectionModel addItem:obj];
    
    expect(countBefore + 1).haveCount(self.sectionModel.objects.count);
}

- (void)test_addItem_negative_toNotRaisedExceptionWhenAddNil
{
    id obj = nil;

    void(^block)() = ^() {
        [self.sectionModel addItem:obj];
    };

    expect(block).notTo.raiseAny();
}

- (void)test_addItem_positive_whenAddedObjectIsValid
{
    id obj = [NSObject new];
    
    [self.sectionModel addItem:obj];
    
    expect(self.sectionModel.objects[0]).equal(obj);
}


#pragma mark - Test insertItem: atIndex:

- (void)test_insertItem_positive_countOfObjectsIncreasedByOne
{
    id obj = [NSObject new];
    NSUInteger countBefore = self.sectionModel.objects.count;

    [self.sectionModel insertItem:obj atIndex:0];

    expect(countBefore + 1).haveCount(self.sectionModel.objects.count);
}

- (void)test_insertItemAtIndex_positive_whenValidData
{
    id obj = [NSObject new];
    NSInteger index = 0;
    
    [self.sectionModel insertItem:obj atIndex:index];
    
    expect(self.sectionModel.objects[index]).equal(obj);
}

- (void)test_insertItemAtIndex_positive_toNotRaiseExceptionWhenGetObjectAtValidIndex
{
    id obj = [NSObject new];
    NSInteger index = 0;
    
    [self.sectionModel insertItem:obj atIndex:index];
    
    expect(^{
        [self.sectionModel.objects objectAtIndex:index];
    }).notTo.raiseAny();
}

- (void)test_insertItem_negative_toNotRaiseExceptionWhenInsertNil
{
    id obj = nil;

    void(^block)() = ^() {
        [self.sectionModel insertItem:obj atIndex:0];
    };

    expect(block).notTo.raiseAny();
}

- (void)test_insertItem_negative_toNotRaiseExceptionWhenInsertNegativeIndex
{
    id obj = [NSObject new];

    void(^block)() = ^() {
        [self.sectionModel insertItem:obj atIndex:-20];
    };

    expect(block).notTo.raiseAny();
}

- (void)test_insertItem_negative_toNotRaiseExceptionWhenInsertOutOfBoundsIndex
{
    id obj = [NSObject new];
    NSUInteger index = (NSUInteger)arc4random();

    void(^block)() = ^() {
        [self.sectionModel insertItem:obj atIndex:index];
    };

    expect(block).notTo.raiseAny();
}

- (void)test_insertItem_negative_toNotRaiseExceptionWhenAddBoundaryElement
{
    id obj = [NSObject new];
    [self.sectionModel addItem:obj];

    void(^block)() = ^() {
        [self.sectionModel insertItem:obj atIndex:1];
    };

    expect(block).notTo.raiseAny();
}

- (void)test_insertItemAtIndex_negative_toNotRaiseExceptionWhenIndexNSNotFound
{
    void(^testBlock)() = ^() {
        [self.sectionModel insertItem:[NSObject new] atIndex:NSNotFound];
    };
    
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - removeItemAtIndex

- (void)test_removeItemAtIndex_positive_sectionModelNotContainsItems
{
    NSUInteger maxIndex = arc4random_uniform(kMaxObjectsCount) + 1;
    
    for (NSUInteger counter = 0; counter < maxIndex; counter++)
    {
        id item = [NSObject new];
        [self.sectionModel addItem:item];
    }
    
    NSUInteger randomIndex = arc4random_uniform((u_int32_t)maxIndex);
    NSObject* removedObject = self.sectionModel.objects[randomIndex];
    
    [self.sectionModel removeItemAtIndex:randomIndex];
    
    expect(self.sectionModel.objects).notTo.contain(removedObject);
}

- (void)test_removeItemAtIndex_positive_objectsDeletedOnce
{
    NSUInteger maxIndex = (NSUInteger)arc4random_uniform((u_int32_t)kMaxObjectsCount);
    
    for (NSUInteger counter = 0; counter < maxIndex; counter++)
    {
        id item = [NSObject new];
        [self.sectionModel addItem:item];
    }
    
    NSUInteger objectsCount = self.sectionModel.objects.count;

    NSUInteger countDeletions = arc4random_uniform((u_int32_t)maxIndex);
    for (NSUInteger counter = 0; counter < countDeletions; counter++)
    {
        NSUInteger randomIndex = arc4random_uniform((u_int32_t)self.sectionModel.objects.count);
        [self.sectionModel removeItemAtIndex:randomIndex];
    }
    
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
    NSUInteger index = (NSUInteger)arc4random();
    
    void(^testBlock)() = ^() {
        [self.sectionModel removeItemAtIndex:index];
    };
    
    expect(testBlock).notTo.raiseAny();
}

- (void)test_removeItemAtIndex_negative_toNotRaiseExceptionWhenIndexNSNotFound
{
    void(^block)() = ^() {
        [self.sectionModel removeItemAtIndex:NSNotFound];
    };
    
    expect(block).notTo.raiseAny();
}


#pragma mark - replaceItemAtIndex:withItem:

- (void)test_replaceItemAtIndexWithItem_positive_modelNotContainsNewObject
{
    NSUInteger maxObjectsCount = arc4random_uniform(kMaxObjectsCount);
    id initialItem = [NSObject new];

    for (NSUInteger counter = 0; counter < maxObjectsCount; counter++)
    {
        [self.sectionModel addItem:initialItem];
    }
    
    id object = [NSObject new];
    for (NSUInteger counter = 0; counter < maxObjectsCount; counter++)
    {
        [self.sectionModel replaceItemAtIndex:counter withItem:object];
    }
    
    expect(self.sectionModel.objects).notTo.contain(initialItem);
}

- (void)test_replaceItemAtIndex_negative_toNotRaiseExceptionWhenReplaceWithNilObject
{
    id nilObject = nil;
    [self.sectionModel addItem:[NSObject new]];
    
    void(^testBlock)() = ^() {
        [self.sectionModel replaceItemAtIndex:0 withItem:nilObject];
    };
    
    expect(testBlock).notTo.raiseAny();
}

- (void)test_replaceItemAtIndex_negative_toNotRaiseExceptionWhenReplaceWithNegativeIndex
{
    id newItem = [NSObject new];
    
    void(^testBlock)() = ^() {
        [self.sectionModel replaceItemAtIndex:-1 withItem:newItem];
    };
    
    expect(testBlock).notTo.raiseAny();
}

- (void)test_replaceItemAtIndex_negative_toNotRaiseExceptionWhenReplacingNotExistingIndex
{
    id newItem = [NSObject new];
    
    void(^testBlock)() = ^() {
        [self.sectionModel replaceItemAtIndex:0 withItem:newItem];
    };
    
    expect(testBlock).notTo.raiseAny();
}


#pragma mark - numberOfObjects

- (void)test_numberOfObjects_positive_modelReturnsCorrectNumberOfObjects
{
    id item = [NSObject new];
    
    NSInteger maxObjectsCount = arc4random_uniform(kMaxObjectsCount);
    for (NSInteger counter = 0; counter < maxObjectsCount; counter++)
    {
        [self.sectionModel addItem:item];
    }
    
    expect(self.sectionModel.numberOfObjects).to.equal(maxObjectsCount);
}

- (void)test_numberOfObjects_positive_emptyWhenCreated
{
    expect([self.sectionModel numberOfObjects]).equal(0);
}

- (void)test_objects_positive_validObjectsAfterAdding
{
    id item = [NSObject new];
    
    [self.sectionModel addItem:item];
    
    expect([self.sectionModel objects]).equal(@[item]);
}


#pragma mark - supplementaryModelOfKind

- (void)test_supplementaryModelOfKind_positive_initialAndReturnedModelsAreEqual
{
    id model = @"model";
    id modelClassName = NSStringFromClass([model class]);
    
    [self.sectionModel updateSupplementaryModel:model forKind:modelClassName];
    
    id returnedModel = [self.sectionModel supplementaryModelOfKind:modelClassName];
    
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

- (void)test_supplementaryModelOfKind_negative_toNotRaiseExceptionWhenRequestModelWithNilObject
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

- (void)test_updateSupplementaryModelForKind_negative_toNotRaiseExceptionWhenAddNilModel
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

- (void)test_updateSupplementaryModelForKind_negative_toNotRaiseExceptionWhenAddNilClass
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

- (void)test_updateSupplementaryModelForKind_negative_toNotRaiseExceptionWhenUpdateWithBothNilValues
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

- (void)test_objects_positive_returnValidObjectsAfterAdding
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
    
    // then
    expect(self.sectionModel.objects.count).to.equal(maxCountObjects);
    expect(self.sectionModel.objects).to.equal(initialObjects);
}

@end
