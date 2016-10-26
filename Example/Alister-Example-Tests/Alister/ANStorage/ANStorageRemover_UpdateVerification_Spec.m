//
//  ANStorageRemover_UpdateVerification_Spec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/12/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageUpdater.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageUpdateModel.h>
#import <Alister/ANStorageRemover.h>
#import "ANStorageFakeOperationDelegate.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

SpecBegin(ANStorageRemover_UpdateVerification_Spec)

__block ANStorageRemover* remover = nil;
__block ANStorageUpdater* updater = nil;

__block ANStorageFakeOperationDelegate* fakeDelegate = nil;

beforeEach(^{
    ANStorageModel* storage = [ANStorageModel new];
    
    fakeDelegate = [ANStorageFakeOperationDelegate new];
    updater = [ANStorageUpdater updaterWithStorageModel:storage delegate:nil];
    remover = [ANStorageRemover removerWithStorageModel:storage andUpdateDelegate:fakeDelegate];
});

describe(@"removeItem:", ^{
    
    it(@"successfully removes item", ^{
        NSString* item = @"test";
        [updater addItem:item];
        [remover removeItem:item];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addDeletedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty if item is nil", ^{
        [remover removeItem:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        [remover removeItem:@"test"];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if item not exist in storageModel", ^{
        [remover removeItem:@"test"];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"removeItemsAtIndexPaths:", ^{
    
    __block NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    it(@"removes only specified indexPaths", ^{
        NSString* item = @"test";
        [updater addItem:item];
        [updater addItem:@"smt" atIndexPath:indexPath];
        [remover removeItemsAtIndexPaths:[NSSet setWithObject:indexPath]];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addDeletedIndexPaths:@[indexPath]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty if indexPaths are nil", ^{
        [remover removeItemsAtIndexPaths:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        [remover removeItemsAtIndexPaths:[NSSet setWithObject:indexPath]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if indexPaths are not exist in storageModel", ^{
        [remover removeItemsAtIndexPaths:[NSSet setWithObject:indexPath]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"removeItems:", ^{
    
    it(@"removes only specified items", ^{
        
        NSArray* items = @[@"item4", @"item5"];
        [updater addItems:[items arrayByAddingObjectsFromArray:@[@"test1", @"test2"]]];
        [remover removeItems:[NSSet setWithArray:items]];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addDeletedIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0],
                                         [NSIndexPath indexPathForRow:0 inSection:0]]];
        
        expect(fakeDelegate.lastUpdate.deletedRowIndexPaths).equal(expected.deletedRowIndexPaths);
    });
    
    it(@"update will be empty if items are nil", ^{
        [remover removeItems:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no asert if items not exist in storageModel", ^{
        [remover removeItems:[NSSet setWithObject:@"test"]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        [remover removeItems:[NSSet setWithObject:@"test"]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"removeAllItemsAndSections", ^{
    
    it(@"removes all sections", ^{
        
        [updater addItem:@"test"];
        [updater addItem:@"test2" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        
        [remover removeAllItemsAndSections];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        expected.isRequireReload = YES;
        
        //TODO: check this after unit tests on operations
//        [expected addDeletedSectionIndex:0];
//        [expected addDeletedSectionIndex:1];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty if storage is empty", ^{
        [remover removeAllItemsAndSections];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        [remover removeAllItemsAndSections];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"removeSections:", ^{
    
    it(@"removes only specified sections", ^{
        NSString* testModel = @"test0";
        NSArray* items = @[@"test1", @"test2", @"test3"];
        
        [updater addItem:testModel toSection:1];
        [updater addItems:items toSection:0];
        [remover removeSections:[NSIndexSet indexSetWithIndex:0]];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addDeletedSectionIndex:0];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty if section is not exist", ^{
        [remover removeSections:[NSIndexSet indexSetWithIndex:2]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if indexSet is nil", ^{
        [remover removeSections:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        [remover removeSections:[NSIndexSet indexSetWithIndex:0]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


SpecEnd

#pragma clang diagnostic pop
