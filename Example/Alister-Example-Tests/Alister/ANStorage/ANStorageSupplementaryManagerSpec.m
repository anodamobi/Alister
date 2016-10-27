//
//  ANStorageSupplementaryManagerSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/15/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageSupplementaryManager.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageSectionModel.h>

SpecBegin(ANStorageSupplementaryManager)

__block ANStorageModel* storage = nil;
__block ANStorageSupplementaryManager* supplementaryManager = nil;

beforeEach(^{
    storage = [ANStorageModel new];
    supplementaryManager = [ANStorageSupplementaryManager supplementatyManagerWithStorageModel:storage
                                                                                updateDelegate:nil];
});

describe(@"updateSectionHeaderModel: forSectionIndex: inStorage:", ^{
    
    beforeEach(^{
        storage.headerKind = @"testKind";
    });
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        [supplementaryManager updateSectionHeaderModel:item
                                                forSectionIndex:0];
        
        expect([[storage sectionAtIndex:0] supplementaryModelOfKind:storage.headerKind]).equal(item);
    });
    
    it(@"no assert if model is nil", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionHeaderModel:nil forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionHeaderModel:@"test" forSectionIndex:10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionHeaderModel:@"test" forSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionHeaderModel:@"test" forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionHeaderModel:@"test" forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"updateSectionFooterModel: forSectionIndex: inStorage:", ^{
   
    beforeEach(^{
        storage.footerKind = @"testKind";
    });
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        [supplementaryManager updateSectionFooterModel:item forSectionIndex:0];
        
        expect([[storage sectionAtIndex:0] supplementaryModelOfKind:storage.footerKind]).equal(item);
    });
    
    it(@"no assert if model is nil", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionFooterModel:nil forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionFooterModel:@"test" forSectionIndex:10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionFooterModel:@"test" forSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionFooterModel:@"test" forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [supplementaryManager updateSectionFooterModel:@"test" forSectionIndex:0];
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
        id model = [supplementaryManager supplementaryModelOfKind:kind forSectionIndex:0];
        expect(model).equal(item);
    });
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [supplementaryManager supplementaryModelOfKind:nil forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [supplementaryManager supplementaryModelOfKind:kind forSectionIndex:5];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [supplementaryManager supplementaryModelOfKind:kind forSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [supplementaryManager supplementaryModelOfKind:kind forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [supplementaryManager supplementaryModelOfKind:kind forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
});

SpecEnd
