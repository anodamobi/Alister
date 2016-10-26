//
//  ANStorageRemoverSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/12/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

#import <Alister/ANStorageUpdater.h>
#import <Alister/ANStorageRemover.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageUpdateModel.h>

SpecBegin(ANStorageRemover)

__block ANStorageModel* storage = nil;
__block ANStorageRemover* remover = nil;
__block ANStorageUpdater* updater = nil;

beforeEach(^{
    storage = [ANStorageModel new];
    remover = [ANStorageRemover removerWithStorageModel:storage andUpdateDelegate:nil];
    updater = [ANStorageUpdater updaterWithStorageModel:storage updateDelegate:nil];
});

describe(@"removeItem:", ^{
    
    it(@"successfully removes item", ^{
        NSString* item = @"test";
        [updater addItem:item];
        [remover removeItem:item];
        
        expect([storage itemsInSection:0]).notTo.contain(item);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [remover removeItem:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            remover = [ANStorageRemover removerWithStorageModel:nil andUpdateDelegate:nil];
            [remover removeItem:@"test"];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item not exist in storageModel", ^{
        void(^block)() = ^() {
            [remover removeItem:@"test"];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeItemsAtIndexPaths:", ^{
    
    __block NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    it(@"removes only specified indexPaths", ^{
        NSString* item = @"test";
        [updater addItem:item];
        [updater addItem:@"smt" atIndexPath:indexPath];
        [remover removeItemsAtIndexPaths:[NSSet setWithObject:indexPath]];
        
        expect([storage itemsInSection:0]).haveCount(1);
        expect([storage itemsInSection:0]).contain(item);
    });
    
    it(@"no assert if indexPaths are nil", ^{
        void(^block)() = ^() {
            [remover removeItemsAtIndexPaths:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [remover removeItemsAtIndexPaths:[NSSet setWithObject:indexPath]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if indexPaths are not exist in storageModel", ^{
        void(^block)() = ^() {
            [remover removeItemsAtIndexPaths:[NSSet setWithObject:indexPath]];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeItems:", ^{
    
    it(@"removes only specified items", ^{
        NSArray* specifiedItems = @[@"test1", @"test2", @"test3"];
        
        [updater addItems:[specifiedItems arrayByAddingObjectsFromArray:@[@"test10", @"test30"]]];
        [remover removeItems:[NSSet setWithArray:specifiedItems]];
        
        expect([storage itemsInSection:0]).haveCount(2);
    });
    
    it(@"no assert if items are nil", ^{
        void(^block)() = ^() {
            [remover removeItems:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no asert if items not exist in storageModel", ^{
        void(^block)() = ^() {
            [remover removeItems:[NSSet setWithObject:@"test"]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            remover = [ANStorageRemover removerWithStorageModel:nil andUpdateDelegate:nil];
            [remover removeItems:[NSSet setWithObject:@"test"]];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeAllItemsAndSections", ^{
    
    beforeEach(^{
        [updater addItem:@"test"];
        [updater addItem:@"test2" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    });
    
    it(@"removes all sections", ^{
        [remover removeAllItemsAndSections];
        expect([storage sections]).haveCount(0);
        expect([storage isEmpty]).beTruthy();
    });
    
    it(@"storageModel is empty after call", ^{
        [remover removeAllItemsAndSections];
        expect(storage.isEmpty).beTruthy();
    });
    
    it(@"no assert if storage is empty", ^{
        void(^block)() = ^() {
            [remover removeAllItemsAndSections];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            remover = [ANStorageRemover removerWithStorageModel:nil andUpdateDelegate:nil];
            [remover removeAllItemsAndSections];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"removeSections:", ^{
    
    it(@"removes only specified sections", ^{
        
        NSString* testModel = @"test0";
        NSArray* items = @[@"test1", @"test2", @"test3"];
        
        [updater addItem:testModel toSection:1];
        [updater addItems:items toSection:0];
        [remover removeSections:[NSIndexSet indexSetWithIndex:0]];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel);
        expect([storage sections]).haveCount(1);
    });
    
    it(@"no assert if section is not exist", ^{
        void(^block)() = ^() {
            [remover removeSections:[NSIndexSet indexSetWithIndex:2]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if indexSet is nil", ^{
        void(^block)() = ^() {
            [remover removeSections:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            remover = [ANStorageRemover removerWithStorageModel:nil andUpdateDelegate:nil];
            [remover removeSections:[NSIndexSet indexSetWithIndex:0]];
        };
        expect(block).notTo.raiseAny();
    });
});

SpecEnd

#pragma clang diagnostic pop
