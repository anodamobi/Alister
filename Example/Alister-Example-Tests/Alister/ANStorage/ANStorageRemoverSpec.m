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

SpecBegin(ANStorageRemoverSpec)

__block ANStorageModel* storage = nil;

beforeEach(^{
    storage = [ANStorageModel new];
});

describe(@"removeItem:", ^{
    
    it(@"successfully removes item", ^{
        
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toStorage:nil];
        [ANStorageRemover removeItem:item fromStorage:nil];
        
        expect([storage itemsInSection:0]).notTo.contain(item);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItem:nil fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item not exist in storageModel", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItem:@"test" fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeItemsAtIndexPaths:", ^{
    
    it(@"no assert if indexPaths are nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItemsAtIndexPaths:nil fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"removes only specified indexPaths", ^{
        NSString* item = @"test";
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [ANStorageUpdater addItem:@"something" toStorage:nil];
        [ANStorageUpdater addItem:item atIndexPath:indexPath toStorage:nil];
        [ANStorageRemover removeItemsAtIndexPaths:@[indexPath] fromStorage:nil];
        
        expect([storage itemsInSection:0]).haveCount(1);
    });
    
    it(@"no assert if indexPaths are not exist in storageModel", ^{
        void(^block)() = ^() {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [ANStorageRemover removeItemsAtIndexPaths:@[indexPath] fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
});

describe(@"removeItems:", ^{
    
    it(@"no assert if items are nil", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItems:nil fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no asert if items not exist in storageModel", ^{
        void(^block)() = ^() {
            [ANStorageRemover removeItems:@[@"test"] fromStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    //regression
    it(@"removes only specified items", ^{
        NSString* item = @"test";
        [ANStorageUpdater addItems:@[item, @"test2"] toStorage:nil];
        [ANStorageRemover removeItem:item fromStorage:nil];
        
        expect([storage itemsInSection:0]).haveCount(1);
    });
});


describe(@"removeAllItemsAndSections", ^{
    
    beforeEach(^{
        [ANStorageUpdater addItem:@"test" toStorage:storage];
        [ANStorageUpdater addItem:@"test2" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] toStorage:storage];
    });
    
    it(@"removes all sections", ^{
        [ANStorageRemover removeAllItemsAndSections fromStorage:storage];
        expect([storage sections]).haveCount(0);
    });
    
    it(@"storageModel is empty after call", ^{
        [ANStorageRemover removeAllItemsAndSections fromStorage:storage];
        expect(storage.isEmpty).beTruthy(); // TODO:
    });
});


describe(@"removeSections:", ^{
    
    it(@"removes only specified sections", ^{
        
        NSString* testModel = @"test0";
        NSArray* items = @[@"test1", @"test2", @"test3"];
        
        [ANStorageUpdater addItem:testModel toSection:1 toStorage:nil];
        [ANStorageUpdater addItems:items toSection:0 toStorage:nil];
        [ANStorageRemover removeSections:[NSIndexSet indexSetWithIndex:0] fromStorage:storage];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel);
        expect([storage sections]).haveCount(1);
    });
    
    it(@"no assert if section not exists", ^{
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
    
});

SpecEnd
