//
//  ANStorageControllerTest.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/2/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageSectionModel.h>
#import <Alister/ANStorageController.h>
#import <Alister/ANStorageModel.h>

SpecBegin(ANStorageController_CRUD_Test)

__block ANStorageController* controller = nil;

beforeEach(^{
    controller = [ANStorageController new];
});


describe(@"default state", ^{
    
    it(@"should have storageModel", ^{
        expect(controller.storageModel).notTo.beNil();
    });
    
    it(@"should have no sections", ^{
        expect(controller.sections).haveCount(0);
    });
});


describe(@"addItem:", ^{
   
    it(@"added item is same as retrieved item", ^{
        
        NSString* item = @"test";
        [controller addItem:item];
        
         expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [controller addItem:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"addItems:", ^{
    
    it(@"objects from array added in a correct order", ^{
       
        NSString* testModel0 = @"test0";
        NSString* testModel1 = @"test1";
        NSString* testModel2 = @"test2";
        NSArray* testModel = @[testModel0, testModel1, testModel2];
        [controller addItems:testModel];
        
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel[0]);
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).equal(testModel[1]);
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).equal(testModel[2]);
    });
    
    it(@"no assert if add nil", ^{
        void(^block)() = ^() {
            [controller addItems:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"items count in array equals items count in section", ^{
        NSArray* testModel = @[@"one", @"two", @"three"];
        [controller addItems:testModel];
        
        expect([controller itemsInSection:0]).haveCount(testModel.count);
    });
});


describe(@"adding objects in non-existing section creating required sections with method", ^{
   
    it(@"addItems", ^{
        NSArray* testModel = @[@"one", @"two", @"three"];
        [controller addItems:testModel];
        
        expect(controller.sections).haveCount(1);
    });
    
    it(@"addItem", ^{
        [controller addItem:@"test"];
        expect(controller.sections).haveCount(1);
    });
    
    it(@"addItem: toSection:", ^{
        [controller addItem:@"Test" toSection:2];
        
        expect([controller itemsInSection:0]).haveCount(0);
        expect([controller itemsInSection:1]).haveCount(0);
        expect([controller itemsInSection:2]).haveCount(1);
        expect([controller sections]).haveCount(3);
    });
});


describe(@"addItem: toSection:", ^{
   
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [controller addItem:nil toSection:2];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section not exists", ^{
        void(^block)() = ^() {
            [controller addItem:@"test" toSection:2];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"added item equal to retrived", ^{
        NSString* item = @"test";
        [controller addItem:item toSection:0];
        
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
    });
    
    it(@"no assert if section index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller addItem:@"test" toSection:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"addItems: toSection:", ^{
    
    it(@"items added in a correct order", ^{
        NSArray* testModel = @[@"test0", @"test1", @"test2"];
        [controller addItems:testModel toSection:3];
        
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]]).equal(testModel[0]);
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]]).equal(testModel[1]);
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:3]]).equal(testModel[2]);
    });
    
    it(@"no assert if add nil", ^{
        void(^block)() = ^() {
            [controller addItems:nil toSection:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section index is negative", ^{
        void(^block)() = ^() {
            [controller addItems:@[] toSection:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    //regression
    it(@"no assert if section index NSNotFound", ^{
        void(^block)() = ^() {
            [controller addItems:@[] toSection:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"addItem: atIndexPath:", ^{
    
    it(@"no assert if item is nil", ^{
        [controller addItem:nil atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    });
    
    it(@"no assert if indexPath is nil", ^{
        [controller addItem:@"test" atIndexPath:nil];
    });
    
    it(@"no assert if item and indexPath are nil", ^{
        
    });
    
    it(@"added item equal to retrived", ^{
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [controller addItem:@"test" atIndexPath:indexPath];
        
        expect([controller itemAtIndexPath:indexPath]).equal(@"test");
    });
    
    it(@"no assert if row out of bounds", ^{
        void(^block)() = ^() {
            [controller addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section is out of bounds", ^{
        void(^block)() = ^() {
            [controller addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        };
        expect(block).notTo.raiseAny();
    });
});

////////////////

describe(@"reloadItem:", ^{
    
    it(@"item reloaded if exists", ^{
        failure(@"Pending"); //TODO: mocks?
    });
    
    it(@"no assert if item not exists in storageModel", ^{
        void(^block)() = ^() {
            [controller reloadItem:@"test"];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [controller reloadItem:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeItem:", ^{
    
    it(@"successfully removes item", ^{
        
        NSString* item = @"test";
        [controller addItem:item];
        [controller removeItem:item];
        
        expect([controller itemsInSection:0]).notTo.contain(item);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [controller removeItem:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item not exist in storageModel", ^{
        void(^block)() = ^() {
            [controller removeItem:@"test"];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeItemsAtIndexPaths:", ^{
    
    it(@"no assert if indexPaths are nil", ^{
        void(^block)() = ^() {
            [controller removeItemsAtIndexPaths:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"removes only specified indexPaths", ^{
        NSString* item = @"test";
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [controller addItem:@"something"];
        [controller addItem:item atIndexPath:indexPath];
        [controller removeItemsAtIndexPaths:@[indexPath]];
        
        expect([controller itemsInSection:0]).haveCount(1);
    });
    
    it(@"no assert if indexPaths are not exist in storageModel", ^{
        void(^block)() = ^() {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller removeItemsAtIndexPaths:@[indexPath]];
        };
        expect(block).notTo.raiseAny();
    });
    
});

describe(@"removeItems:", ^{
    
    it(@"no assert if items are nil", ^{
        void(^block)() = ^() {
            [controller removeItems:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no asert if items not exist in storageModel", ^{
        void(^block)() = ^() {
            [controller removeItems:@[@"test"]];
        };
        expect(block).notTo.raiseAny();
    });
    
    //regression
    it(@"removes only specified items", ^{
        NSString* item = @"test";
        [controller addItems:@[item, @"test2"]];
        [controller removeItem:item];
        
        expect([controller itemsInSection:0]).haveCount(1);
    });
});


describe(@"removeAllItemsAndSections", ^{
    
    beforeEach(^{
        [controller addItem:@"test"];
        [controller addItem:@"test2" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    });
    
    it(@"removes all sections", ^{
        [controller removeAllItemsAndSections];
        expect([controller sections]).haveCount(0);
    });

    it(@"storageModel is empty after call", ^{
        [controller removeAllItemsAndSections];
        expect(controller.isEmpty).beTruthy(); // TODO:
    });
});


describe(@"removeSections:", ^{
    
    it(@"removes only specified sections", ^{
        
        NSString* testModel = @"test0";
        NSArray* items = @[@"test1", @"test2", @"test3"];
        
        [controller addItem:testModel toSection:1];
        [controller addItems:items toSection:0];
        [controller removeSections:[NSIndexSet indexSetWithIndex:0]];
        
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel);
        expect([controller sections]).haveCount(1);
    });
    
    it(@"no assert if section not exists", ^{
        void(^block)() = ^() {
            [controller removeSections:[NSIndexSet indexSetWithIndex:2]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if indexSet is nil", ^{
        void(^block)() = ^() {
            [controller removeSections:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
});


describe(@"replaceItem:withItem:", ^{
   
    it(@"no assert if new item is nil", ^{
        NSString* item = @"test";
        [controller addItem:item];
        
        void(^block)() = ^() {
            [controller replaceItem:item withItem:nil];
        };
        
        expect(block).notTo.raiseAny();
    });
    
    it(@"no aseert if both items are nil", ^{
        void(^block)() = ^() {
            [controller replaceItem:nil withItem:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"old item stays in storage if new item is nil", ^{
        NSString* item = @"test";
        [controller addItem:item];
        [controller replaceItem:item withItem:nil];
        
        expect([controller itemsInSection:0]).contain(item);
    });
    
    it(@"no assert if old item is nil", ^{
        void(^block)() = ^() {
            [controller replaceItem:nil withItem:@"test"];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"successfully replaces item", ^{
        NSString* testModel = @"test0";
        NSString* testModel1 = @"test1";
        
        [controller addItem:testModel toSection:0];
        [controller replaceItem:testModel withItem:testModel1];
        
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel1);
        expect([controller sections]).haveCount(1);
        expect([controller itemsInSection:0]).haveCount(1);
    });
});


describe(@"moveItemFromIndexPath: toIndexPath:", ^{
    
    __block NSIndexPath* fromIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    __block NSIndexPath* toIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    __block NSString* item = @"test";
    
    beforeEach(^{
        [controller addItem:item];
    });
    
    it(@"no assert if from indexPath is nil", ^{
        void(^block)() = ^() {
            [controller moveItemFromIndexPath:nil toIndexPath:toIndexPath];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if to indexPath is nil", ^{
        void(^block)() = ^() {
            [controller moveItemFromIndexPath:fromIndexPath toIndexPath:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if both indexPaths are nil", ^{
        void(^block)() = ^() {
            [controller moveItemFromIndexPath:nil toIndexPath:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"item stays on existing index path if new is nil", ^{
        [controller moveItemFromIndexPath:fromIndexPath toIndexPath:nil];
        
        expect([controller itemAtIndexPath:fromIndexPath]).equal(item);
    });
    
    it(@"item successfully moved", ^{
        [controller moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
        expect([controller itemAtIndexPath:toIndexPath]).equal(item);
    });
});


describe(@"sections", ^{
    
    it(@"should have correct number of sections", ^{
        [controller addItem:@"test" toSection:0];
        [controller addItem:@"test2" toSection:1];
        [controller addItem:@"test3" toSection:2];
        
        expect([controller sections]).haveCount(3);
    });
});


describe(@"itemAtIndexPath:", ^{
    
    __block NSString* item = @"test";
    
    beforeEach(^{
        [controller addItem:item];
    });
    
    it(@"no assert if indexPath is nil", ^{
        void(^block)() = ^() {
            [controller itemAtIndexPath:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"correctly returns item", ^{
        expect([controller itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
    });
});


describe(@"sectionAtIndex:", ^{
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [controller sectionAtIndex:1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"returns nil if section not exist", ^{
        expect([controller sectionAtIndex:1]).to.beNil();
    });
    
    it(@"returns correct section if it exists", ^{
        NSString* item = @"test";
        [controller addItem:item];
        
        expect([controller itemsInSection:0]).contain(item);
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller sectionAtIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [controller sectionAtIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"itemsInSection:", ^{
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [controller itemsInSection:1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert it index is NSNotFound", ^{
        void(^block)() = ^() {
            [controller itemsInSection:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [controller itemsInSection:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"returns specified items", ^{
        NSArray* items = @[@"test", @"test2"];
        [controller addItems:items];
        
        expect([controller itemsInSection:0]).equal(items);
    });
});


describe(@"indexPathForItem:", ^{
    
    __block NSString* item = @"test";
    
    beforeEach(^{
        [controller addItem:item];
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [controller indexPathForItem:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"returns nil if item not exists in storageModel", ^{
        expect([controller indexPathForItem:@"some"]).to.beNil();
    });
    
    it(@"returns specified item", ^{
        expect([controller indexPathForItem:item]).equal([NSIndexPath indexPathForRow:0 inSection:0]);
    });
});


describe(@"isEmpty", ^{
    
    it(@"is empty if have empty sections", ^{
        
        NSString* item = @"item";
        [controller addItem:item];
        [controller removeItem:item];
        
        expect([controller isEmpty]).beTruthy();
    });
    
    it(@"is not empty if have items in sections", ^{
        [controller addItem:@"test"];
        expect([controller isEmpty]).beFalsy();
    });
});

SpecEnd

