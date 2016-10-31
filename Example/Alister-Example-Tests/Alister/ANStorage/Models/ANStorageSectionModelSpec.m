//
//  ANStorageSectionModelTest.m
//  Alister
//
//  Created by Maxim Eremenko on 8/19/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import <Alister/ANStorageSectionModel.h>

SpecBegin(ANStorageSectionModel)

__block ANStorageSectionModel* model = nil;
__block id nilValue = nil;

beforeEach(^{
    model = [ANStorageSectionModel new];
    nilValue = nil;
});

describe(@"default state", ^{
   
    it(@"conforms to model protocol", ^{
        expect(model).conformTo(@protocol(ANStorageSectionModelInterface));
    });
    
    it(@"has non nil objects", ^{
        expect(model.objects).notTo.beNil();
    });
    
    it(@"has non nil supplementaties", ^{
        expect(model.supplementaryObjects).notTo.beNil();
    });
});


describe(@"addItem:", ^{
    
    it(@"item exists in objects array after adding", ^{
        NSString* test = @"Test";
        [model addItem:test];
        expect(model.objects).contain(test);
    });
    
    it(@"no assert if add nil", ^{
        void(^block)() = ^() {
            NSString* string = nil;
            [model addItem:string];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"item added on at 0 index", ^{
        NSString* test = @"Test";
        [model addItem:test];
        expect(model.objects[0]).equal(test);
    });
});


describe(@"insertItem: atIndex:", ^{
    
    it(@"no assert on insert at index 0 when model is empty", ^{
        void(^block)() = ^() {
            [model insertItem:@"test" atIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert when insert nil", ^{
        void(^block)() = ^() {
            [model insertItem:nilValue atIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert when insert index out of bounds", ^{
        void(^block)() = ^() {
            [model insertItem:@"test" atIndex:123];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"item added successfully", ^{
        [model insertItem:@"Test" atIndex:0];
        [model insertItem:@"Test2" atIndex:1];
        expect(model.objects).haveCount(2);
    });
    
    it(@"item inserted at correct index", ^{
        NSString* testItem = @"Test2";
        [model insertItem:@"Test" atIndex:0];
        [model insertItem:testItem atIndex:1];
        expect(model.objects[1]).equal(testItem);
    });
    
    it(@"no assert when index is negative", ^{
        void(^block)() = ^() {
            [model insertItem:@"item" atIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    //regression bug
    it(@"no assert when insert at index equal current objects count", ^{
        [model insertItem:@"test" atIndex:0];
        void(^block)() = ^() {
            [model insertItem:@"test2" atIndex:1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert when insert at NSNotFound index", ^{
        void(^block)() = ^() {
            [model insertItem:@"test" atIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeItemAtIndex:", ^{
    
    it(@"item not in objects array after remove", ^{
        NSString* testItem = @"test";
        [model addItem:testItem];
        [model removeItemAtIndex:0];
        expect(model.objects).notTo.contain(testItem);
    });
    
    it(@"no assert when remove object at non existing index", ^{
        void(^block)() = ^() {
            [model removeItemAtIndex:10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"removes only specified object", ^{
        NSString* testItem = @"test";
        [model addItem:@"test2"];
        [model addItem:testItem];
        [model removeItemAtIndex:0];
        expect(model.objects).contain(testItem);
    });
    
    it(@"no assert when remove at negative index", ^{
        void(^block)() = ^() {
            [model removeItemAtIndex:-10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert when index is NSNotFound", ^{
        void(^block)() = ^() {
            [model removeItemAtIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"replaceItemAtIndex: withItem:", ^{
    
    beforeEach(^{
        [model addItem:@"test"];
    });
    
    it(@"no assert when index is negative", ^{
        void(^block)() = ^() {
            [model replaceItemAtIndex:-1 withItem:@"test2"];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert when index is NSNotFound", ^{
        void(^block)() = ^() {
            [model replaceItemAtIndex:NSNotFound withItem:@"test2"];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"successfully replaces existing item", ^{
        NSString* item = @"test2";
        [model replaceItemAtIndex:0 withItem:item];
        expect(model.objects).haveCount(1);
        expect(model.objects).contain(item);
    });
    
    it(@"no assert when index is out of bounds", ^{
        void(^block)() = ^() {
            [model replaceItemAtIndex:12 withItem:@"test2"];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            NSString* item = nil;
            [model replaceItemAtIndex:0 withItem:item];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"numberOfObjects", ^{
    
    it(@"equal to objects count", ^{
        [model addItem:@"test"];
        expect(model.objects).haveCount([model numberOfObjects]);
    });
});


context(@"supplementaries", ^{
   
    __block NSString* kind = @"test";
    __block NSString* item = @"testmodel";
    
    beforeEach(^{
        [model updateSupplementaryModel:item forKind:kind];
    });
    
    
    describe(@"supplementaryModelOfKind:", ^{
        
        it(@"equal to initial item", ^{
            expect([model supplementaryModelOfKind:kind]).equal(item);
        });
        
        it(@"no assert when kind is nil", ^{
            void(^block)() = ^() {
                [model supplementaryModelOfKind:nilValue];
            };
            expect(block).notTo.raiseAny();
        });
        
        it(@"returns nil if kind not exist", ^{
            expect([model supplementaryModelOfKind:@"some"]).to.beNil();
        });
    });
    
    
    describe(@"updateSupplementaryModel: forKind:", ^{
        
        it(@"supplementary was added in dict", ^{
            expect(model.supplementaryObjects[kind]).equal(item);
        });
        
        it(@"no assert if kind is nil", ^{
            void(^block)() = ^() {
                [model updateSupplementaryModel:@"test" forKind:nilValue];
            };
            expect(block).notTo.raiseAny();
        });
        
        it(@"no assert if model is nil", ^{
            void(^block)() = ^() {
                [model updateSupplementaryModel:nilValue forKind:@"test"];
            };
            expect(block).notTo.raiseAny();
        });
        
        it(@"no assert when model and kind are nil", ^{
            void(^block)() = ^() {
                [model updateSupplementaryModel:nilValue forKind:nilValue];
            };
            expect(block).notTo.raiseAny();
        });
        
    });
});


SpecEnd
