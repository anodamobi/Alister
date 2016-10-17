//
//  ANStorageRemoverSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/12/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageUpdater.h>
#import <Alister/ANStorageRemover.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageUpdateModel.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

SpecBegin(ANStorageRemover)

__block ANStorageModel* storage = nil;

beforeEach(^{
    storage = [ANStorageModel new];
});

describe(@"removeItem:", ^{
    
    it(@"successfully removes item", ^{
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toStorage:storage];
        [ANStorageRemover removeItem:item fromStorage:storage];
        
        expect([storage itemsInSection:0]).notTo.contain(item);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItem:nil fromStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItem:@"test" fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item not exist in storageModel", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItem:@"test" fromStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeItemsAtIndexPaths:", ^{
    
    __block NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    it(@"removes only specified indexPaths", ^{
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toStorage:storage];
        [ANStorageUpdater addItem:@"smt" atIndexPath:indexPath toStorage:storage];
        [ANStorageRemover removeItemsAtIndexPaths:[NSSet setWithObject:indexPath] fromStorage:storage];
        
        expect([storage itemsInSection:0]).haveCount(1);
        expect([storage itemsInSection:0]).contain(item);
    });
    
    it(@"no assert if indexPaths are nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItemsAtIndexPaths:nil fromStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItemsAtIndexPaths:[NSSet setWithObject:indexPath] fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if indexPaths are not exist in storageModel", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItemsAtIndexPaths:[NSSet setWithObject:indexPath] fromStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeItems:", ^{
    
    it(@"removes only specified items", ^{
        NSArray* specifiedItems = @[@"test1", @"test2", @"test3"];
        
        [ANStorageUpdater addItems:[specifiedItems arrayByAddingObjectsFromArray:@[@"test10", @"test30"]] toStorage:storage];
        [ANStorageRemover removeItems:[NSSet setWithArray:specifiedItems] fromStorage:storage];
        
        expect([storage itemsInSection:0]).haveCount(2);
    });
    
    it(@"no assert if items are nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItems:nil fromStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no asert if items not exist in storageModel", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItems:[NSSet setWithObject:@"test"] fromStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItems:[NSSet setWithObject:@"test"] fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeAllItemsAndSections", ^{
    
    beforeEach(^{
        [ANStorageUpdater addItem:@"test" toStorage:storage];
        [ANStorageUpdater addItem:@"test2" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] toStorage:storage];
    });
    
    it(@"removes all sections", ^{
        [ANStorageRemover removeAllItemsAndSectionsFromStorage:storage];
        expect([storage sections]).haveCount(0);
        expect([storage isEmpty]).beTruthy();
    });
    
    it(@"storageModel is empty after call", ^{
        [ANStorageRemover removeAllItemsAndSectionsFromStorage:storage];
        expect(storage.isEmpty).beTruthy();
    });
    
    it(@"no assert if storage is empty", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeAllItemsAndSectionsFromStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeAllItemsAndSectionsFromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeSections:", ^{
    
    it(@"removes only specified sections", ^{
        
        NSString* testModel = @"test0";
        NSArray* items = @[@"test1", @"test2", @"test3"];
        
        [ANStorageUpdater addItem:testModel toSection:1 toStorage:storage];
        [ANStorageUpdater addItems:items toSection:0 toStorage:storage];
        [ANStorageRemover removeSections:[NSIndexSet indexSetWithIndex:0] fromStorage:storage];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel);
        expect([storage sections]).haveCount(1);
    });
    
    it(@"no assert if section is not exist", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeSections:[NSIndexSet indexSetWithIndex:2] fromStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if indexSet is nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeSections:nil fromStorage:storage];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeSections:[NSIndexSet indexSetWithIndex:0] fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});

SpecEnd

#pragma clang diagnostic pop
