//
//  ANStorageUpdaterSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageUpdater.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageUpdateModel.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

SpecBegin(ANStorageUpdater_CRUD)

__block ANStorageModel* storage = nil;

beforeEach(^{
   storage = [ANStorageModel new];
});

//Add items

describe(@"addItem:", ^{
    
    it(@"item added in 0 section by default", ^{
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toStorage:storage];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
    });
    
    it(@"item added at last position in 0 section", ^{
        NSString* item = @"test";
        NSString* secondItem = @"test2";
        [ANStorageUpdater addItem:item toStorage:storage];
        [ANStorageUpdater addItem:secondItem toStorage:storage];

        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).equal(secondItem);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:nil toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:@"test" toStorage:nil];
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
        [ANStorageUpdater addItems:testModel toStorage:storage];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel[0]);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).equal(testModel[1]);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).equal(testModel[2]);
    });
    
    it(@"no assert if add nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItems:nil toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItems:@[@"test"] toStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"items count in array equals items count in section", ^{
        
        NSArray* testModel = @[@"one", @"two", @"three"];
        [ANStorageUpdater addItems:testModel toStorage:storage];
        
        expect([storage itemsInSection:0]).haveCount(testModel.count);
    });
});


describe(@"adding objects in non-existing section creating required sections with method", ^{
    
    it(@"addItems", ^{
        NSArray* testModel = @[@"one", @"two", @"three"];
        [ANStorageUpdater addItems:testModel toStorage:storage];
        
        expect(storage.sections).haveCount(1);
    });
    
    it(@"addItem", ^{
        [ANStorageUpdater addItem:@"test" toStorage:storage];
        expect(storage.sections).haveCount(1);
    });
    
    it(@"addItem: toSection:", ^{
        [ANStorageUpdater addItem:@"Test" toSection:2 toStorage:storage];
        
        expect([storage itemsInSection:0]).haveCount(0);
        expect([storage itemsInSection:1]).haveCount(0);
        expect([storage itemsInSection:2]).haveCount(1);
        expect([storage sections]).haveCount(3);
    });
});


describe(@"addItem: toSection:", ^{
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:nil toSection:2 toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section not exists", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:@"test" toSection:2 toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"added item equal to retrived", ^{
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toSection:0 toStorage:storage];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
    });
    
    it(@"no assert if section index is NSNotFound", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:@"test" toSection:NSNotFound toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:@"test" toStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"addItems: toSection:", ^{
    
    it(@"items added in a correct order", ^{
        NSArray* testModel = @[@"test0", @"test1", @"test2"];
        [ANStorageUpdater addItems:testModel toSection:3 toStorage:storage];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]]).equal(testModel[0]);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]]).equal(testModel[1]);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:3]]).equal(testModel[2]);
    });
    
    it(@"no assert if items are nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItems:nil toSection:0 toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section index is negative", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItems:@[] toSection:-1 toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    //regression
    it(@"no assert if section index NSNotFound", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItems:@[] toSection:NSNotFound toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItems:@[] toStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"addItem: atIndexPath:", ^{
    
    it(@"added item equal to retrived from storage", ^{
        NSString* item = @"test";
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [ANStorageUpdater addItem:@"item" toStorage:storage];
        [ANStorageUpdater addItem:item atIndexPath:indexPath toStorage:storage];
        
        expect([storage itemAtIndexPath:indexPath]).equal(item);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:nil atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if indexPath is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:@"test" atIndexPath:nil toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if row out of bounds", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section is out of bounds", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] toStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] toStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"reloadItem:", ^{
    
    it(@"no assert if item not exists in storageModel", ^{
        void(^block)() = ^() {
            [ANStorageUpdater reloadItem:@"test" inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater reloadItem:nil inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater reloadItem:@"test" inStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"reloadItems: inStorage:", ^{
    
    it(@"no assert if items not exists in storageModel", ^{
        void(^block)() = ^() {
            [ANStorageUpdater reloadItems:@[@"test"] inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater reloadItems:nil inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater reloadItems:@[@"test"] inStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"replaceItem: withItem:", ^{
    
    it(@"no assert if new item is nil", ^{
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toStorage:storage];
        
        void(^block)() = ^() {
            [ANStorageUpdater replaceItem:item withItem:nil inStorage:storage];
        };
        
        expect(block).notTo.raiseAny();
    });
    
    it(@"no aseert if both items are nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater replaceItem:nil withItem:nil inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"old item stays in storage if new item is nil", ^{
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toStorage:storage];
        [ANStorageUpdater replaceItem:item withItem:nil inStorage:storage];
        
        expect([storage itemsInSection:0]).contain(item);
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater replaceItem:nil withItem:@"test"  inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if old item is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater replaceItem:@"test" withItem:@"test"  inStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"successfully replaces item", ^{
        NSString* testModel = @"test0";
        NSString* testModel1 = @"test1";
        
        [ANStorageUpdater addItem:testModel toSection:0 toStorage:storage];
        [ANStorageUpdater replaceItem:testModel withItem:testModel1 inStorage:storage];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel1);
        expect([storage sections]).haveCount(1);
        expect([storage itemsInSection:0]).haveCount(1);
    });
});


describe(@"moveItemFromIndexPath: toIndexPath:", ^{
    
    __block NSIndexPath* fromIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    __block NSIndexPath* toIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    __block NSString* item = @"test";
    
    beforeEach(^{
        [ANStorageUpdater addItem:item toStorage:storage];
        [ANStorageUpdater addItems:@[@"testing", @"smt", @"thanks"] toSection:1 toStorage:storage];
    });
    
    it(@"no assert if from indexPath is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater moveItemFromIndexPath:nil toIndexPath:toIndexPath inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if to indexPath is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater moveItemFromIndexPath:fromIndexPath toIndexPath:nil inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if both indexPaths are nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater moveItemFromIndexPath:nil toIndexPath:nil inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath inStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"item stays on existing index path if new is nil", ^{
        [ANStorageUpdater moveItemFromIndexPath:fromIndexPath toIndexPath:nil inStorage:storage];
        
        expect([storage itemAtIndexPath:fromIndexPath]).equal(item);
    });
    
    it(@"item successfully moved", ^{
        [ANStorageUpdater moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath inStorage:storage];
        expect([storage itemAtIndexPath:toIndexPath]).equal(item);
        expect([storage itemsInSection:0]).haveCount(0);
    });
});


describe(@"createSectionIfNotExist:inStorage: ", ^{
    
    it(@"successfully created section at specified index", ^{
        [ANStorageUpdater addItem:@"test" toStorage:storage];
        expect([storage sectionAtIndex:0]).notTo.beNil();
    });
    
    it(@"no exception if section already exists", ^{
        [ANStorageUpdater addItem:@"test" toStorage:storage];
        void(^block)() = ^() {
            [ANStorageUpdater createSectionIfNotExist:0 inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [ANStorageUpdater createSectionIfNotExist:-1 inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [ANStorageUpdater createSectionIfNotExist:NSNotFound inStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdater createSectionIfNotExist:0 inStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});

SpecEnd

#pragma clang diagnostic pop
