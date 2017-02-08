//
//  ANStorageLoaderSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/14/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageLoader.h"
#import "ANStorageModel.h"
#import "ANStorageUpdater.h"
#import "ANStorageSectionModel.h"

SpecBegin(ANStorageLoaderSpec)

__block ANStorageModel* storage = nil;
__block ANStorageUpdater* updater = nil;

beforeEach(^{
    storage = [ANStorageModel new];
    updater = [ANStorageUpdater updaterWithStorageModel:storage];
});


describe(@"itemAtIndexPath:", ^{
    
    __block NSString* item = @"test";
    NSInteger index = 4;
    
    beforeEach(^{
        
        [updater addItems:[ANTestHelper randomArray] toSection:0];
        [updater addItems:[ANTestHelper randomArrayIncludingObject:item atIndex:index] toSection:1];
        [updater addItems:[ANTestHelper randomArray]];
    });
    
    it(@"correctly returns item", ^{
        id result = [ANStorageLoader itemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:1] inStorage:storage];
        expect(result).equal(item);
    });
    
    it(@"returns nil if indexPath is nil", ^{
        id result = [ANStorageLoader itemAtIndexPath:nil inStorage:storage];
        expect(result).beNil();
    });
    
    it(@"returns nil if storage is nil", ^{
        id result = [ANStorageLoader itemAtIndexPath:[NSIndexPath indexPathWithIndex:0] inStorage:kANTestNil];
        expect(result).beNil();
    });
});


describe(@"sectionAtIndex:", ^{
    
    it(@"returns nil if section not exist", ^{
        id result = [ANStorageLoader sectionAtIndex:2 inStorage:storage];
        expect(result).beNil();
    });
    
    it(@"returns nil if index is negative", ^{
        id result =  [ANStorageLoader sectionAtIndex:-1 inStorage:storage];
        expect(result).beNil();
    });
    
    it(@"returns nil if storage is nil", ^{
        id result = [ANStorageLoader sectionAtIndex:1 inStorage:nil];
        expect(result).beNil();
    });
    
    it(@"returns correct section if it exists", ^{
        
        ANStorageSectionModel* model = [ANStorageSectionModel new];
        [model addItem:[ANTestHelper randomObject]];
        
        [storage addSection:[ANStorageSectionModel new]];
        [storage addSection:model];
        [storage addSection:[ANStorageSectionModel new]];
        
        ANStorageSectionModel* sectionModel = [ANStorageLoader sectionAtIndex:1 inStorage:storage];
        
        expect(sectionModel).equal(model);
    });
});


describe(@"itemsInSection:", ^{
    
    it(@"returns specified items", ^{
        NSArray* items = @[@"test", @"test2"];
        [updater addItems:items];
        
        expect([ANStorageLoader itemsInSection:0 inStorage:storage]).equal(items);
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [ANStorageLoader itemsInSection:1 inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageLoader itemsInSection:1 inStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert it index is NSNotFound", ^{
        void(^block)() = ^() {
            [ANStorageLoader itemsInSection:NSNotFound inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [ANStorageLoader itemsInSection:-1 inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"indexPathForItem:", ^{
    
    __block NSString* item = @"test";
    
    beforeEach(^{
        [updater addItem:item];
    });
    
    it(@"returns nil if item not exists in storageModel", ^{
        expect([ANStorageLoader indexPathForItem:@"some" inStorage:storage]).to.beNil();
    });
    
    it(@"returns specified item", ^{
        expect([ANStorageLoader indexPathForItem:item inStorage:storage]).equal([NSIndexPath indexPathForRow:0 inSection:0]);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [ANStorageLoader indexPathForItem:kANTestNil inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageLoader indexPathForItem:[NSIndexPath indexPathWithIndex:0] inStorage:kANTestNil];
        };
        expect(block).notTo.raiseAny();
    });
});

describe(@"supplementaryModelOfKind: forSectionIndex: inStorage:", ^{
    
    __block NSString* kind = @"testKind";
    __block NSString* item = @"item";
    
    beforeEach(^{
        storage.footerKind = kind;
        ANStorageSectionModel* section = [ANStorageSectionModel new];
        [section updateSupplementaryModel:item forKind:kind];
        [storage addSection:section];
    });
    
    it(@"returns successfully", ^{
        id model = [ANStorageLoader supplementaryModelOfKind:kind forSectionIndex:0 inStorage:storage];
        expect(model).equal(item);
    });
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [ANStorageLoader supplementaryModelOfKind:kANTestNil forSectionIndex:0 inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [ANStorageLoader supplementaryModelOfKind:kind forSectionIndex:5 inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [ANStorageLoader supplementaryModelOfKind:kind forSectionIndex:-1 inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [ANStorageLoader supplementaryModelOfKind:kind forSectionIndex:NSNotFound inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageLoader supplementaryModelOfKind:kind forSectionIndex:0 inStorage:kANTestNil];
        };
        expect(block).notTo.raiseAny();
    });
});

SpecEnd
