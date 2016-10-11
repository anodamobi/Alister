//
//  ANStorageController_Supplemetaries.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageSectionModel.h>
#import <Alister/ANStorageController.h>
#import <Alister/ANStorageModel.h>

SpecBegin(ANStorageController_SupplemetariesTest)

__block ANStorageController* controller = nil;

beforeEach(^{
    controller = [ANStorageController new];
});


describe(@"updateSectionHeaderModel: forSectionIndex:", ^{
    
    beforeEach(^{
        [controller updateSupplementaryHeaderKind:@"some kind"];
    });
    
    it(@"no assert when header is nil", ^{
        void(^block)() = ^() {
            [controller updateSectionHeaderModel:nil forSectionIndex:1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [controller updateSectionHeaderModel:@"test" forSectionIndex:1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller updateSectionHeaderModel:@"test" forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [controller updateSectionHeaderModel:@"test" forSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"successfully updates header model for specified section", ^{
        NSString* item = @"test";
        [controller updateSectionHeaderModel:item forSectionIndex:0];
        
        expect([controller headerModelForSectionIndex:0]).equal(item);
        expect([controller footerModelForSectionIndex:1]).beNil();
    });
});


describe(@"updateSectionFooterModel: forSectionIndex:", ^{
    
    beforeEach(^{
        [controller updateSupplementaryFooterKind:@"some kind"];
    });
    
    it(@"no assert if model is nil", ^{
        void(^block)() = ^() {
            [controller updateSectionFooterModel:nil forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [controller updateSectionFooterModel:@"test" forSectionIndex:2];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller updateSectionFooterModel:@"test" forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [controller updateSectionFooterModel:@"test" forSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"successfully updated for specified section", ^{
        NSString* item = @"test";
        [controller updateSectionFooterModel:item forSectionIndex:0];
        
        expect([controller footerModelForSectionIndex:0]).equal(item);
        expect([controller headerModelForSectionIndex:1]).beNil();
    });
});


describe(@"updateSupplementaryHeaderKind:", ^{
    
    it(@"no assert if nil", ^{
        void(^block)() = ^() {
            [controller updateSupplementaryHeaderKind:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"successfully updates only header kind", ^{
        NSString* item = @"test";
        [controller updateSupplementaryHeaderKind:item];
        expect(controller.headerSupplementaryKind).equal(item);
        expect(controller.footerSupplementaryKind).beNil();
    });
});


describe(@"updateSupplementaryFooterKind:", ^{
    
    it(@"no assert if nil", ^{
        void(^block)() = ^() {
            [controller updateSupplementaryFooterKind:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"successfully updates only header kind", ^{
        NSString* item = @"test";
        [controller updateSupplementaryFooterKind:item];
        expect(controller.footerSupplementaryKind).equal(item);
        expect(controller.headerSupplementaryKind).beNil();
    });
});


describe(@"updateSectionHeaderModel: forSectionIndex:", ^{
    
    beforeEach(^{
        [controller updateSupplementaryHeaderKind:@"testing"];
    });
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [controller updateSectionHeaderModel:nil forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"if kind it nil it resets existing kind", ^{
        
        [controller updateSectionHeaderModel:@"test" forSectionIndex:0];
        [controller updateSectionHeaderModel:nil forSectionIndex:0];
        
        expect([controller headerModelForSectionIndex:0]).beNil();
    });
    
    it(@"no assert if section index is out of bounds", ^{
        void(^block)() = ^() {
            [controller updateSectionHeaderModel:@"test" forSectionIndex:10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller updateSectionHeaderModel:@"test" forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section index is negative", ^{
        void(^block)() = ^() {
            [controller updateSectionHeaderModel:@"test" forSectionIndex:-10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"sucessfully updates existing kind on a new value", ^{
        NSString* item = @"test";
        [controller updateSectionHeaderModel:item forSectionIndex:0];
        
        expect([controller headerModelForSectionIndex:0]).equal(item);
    });
});


describe(@"updateSectionFooterModel: forSectionIndex:", ^{
    
    beforeEach(^{
        [controller updateSupplementaryFooterKind:@"testing"];
    });
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [controller updateSectionFooterModel:nil forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"if kind it nil it resets existing kind", ^{
        
        [controller updateSectionFooterModel:@"test" forSectionIndex:0];
        [controller updateSectionFooterModel:nil forSectionIndex:0];
        
        expect([controller footerModelForSectionIndex:0]).beNil();
    });
    
    it(@"no assert if section index is out of bounds", ^{
        void(^block)() = ^() {
            [controller updateSectionFooterModel:@"test" forSectionIndex:10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller updateSectionFooterModel:@"test" forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section index is negative", ^{
        void(^block)() = ^() {
            [controller updateSectionFooterModel:@"test" forSectionIndex:-10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"sucessfully updates existing kind on a new value", ^{
        NSString* item = @"test";
        [controller updateSectionFooterModel:item forSectionIndex:0];
        
        expect([controller footerModelForSectionIndex:0]).equal(item);
    });
});


describe(@"footerModelForSectionIndex:", ^{
    
    it(@"returns nil if not set", ^{
        expect([controller footerModelForSectionIndex:0]).beNil();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [controller footerModelForSectionIndex:2];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [controller footerModelForSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller footerModelForSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"headerModelForSectionIndex:", ^{
    
    it(@"returns nil if not set", ^{
        expect([controller headerModelForSectionIndex:0]).beNil();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [controller headerModelForSectionIndex:2];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [controller headerModelForSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller headerModelForSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"supplementaryModelOfKind: forSectionIndex:", ^{
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [controller supplementaryModelOfKind:nil forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section index is out of bounds", ^{
        
        void(^block)() = ^() {
            [controller supplementaryModelOfKind:@"test" forSectionIndex:12];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"returns nil if model is not set", ^{
        expect([controller supplementaryModelOfKind:@"test" forSectionIndex:0]).beNil();
    });
    
    it(@"no assert if section index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller supplementaryModelOfKind:@"test" forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section index is negative", ^{
        void(^block)() = ^() {
            [controller supplementaryModelOfKind:@"test" forSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
});

SpecEnd
