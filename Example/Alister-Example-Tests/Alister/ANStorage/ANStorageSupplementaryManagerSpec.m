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

beforeEach(^{
    storage = [ANStorageModel new];
});

describe(@"updateSectionHeaderModel: forSectionIndex: inStorage:", ^{
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        [ANStorageSupplementaryManager updateSectionFooterModel:item
                                                forSectionIndex:0
                                                      inStorage:storage];
        
        expect([[storage sectionAtIndex:0] supplementaryModelOfKind:storage.footerKind]).equal(item);
    });
    
    it(@"no assert if model is nil", ^{
        void(^block)() = ^() {
            [ANStorageSupplementaryManager updateSectionFooterModel:nil
                                                    forSectionIndex:0
                                                          inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [ANStorageSupplementaryManager updateSectionFooterModel:@"test"
                                                    forSectionIndex:10
                                                          inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [ANStorageSupplementaryManager updateSectionFooterModel:@"test"
                                                    forSectionIndex:-1
                                                          inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [ANStorageSupplementaryManager updateSectionFooterModel:@"test"
                                                    forSectionIndex:NSNotFound
                                                          inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageSupplementaryManager updateSectionFooterModel:@"test"
                                                    forSectionIndex:0
                                                          inStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"updateSectionFooterModel: forSectionIndex: inStorage:", ^{
   
    it(@"no assert if model is nil", ^{
        failure(@"Pending");
    });
});


describe(@"supplementaryModelOfKind: forSectionIndex: inStorage:", ^{
    
    it(@"no assert if model is nil", ^{
        failure(@"Pending");
    });
});

SpecEnd
