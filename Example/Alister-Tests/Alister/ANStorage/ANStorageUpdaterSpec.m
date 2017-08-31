//
//  ANStorageUpdaterSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageUpdater.h"
#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"
#import "ANStorageUpdateModel.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

SpecBegin(ANStorageUpdater_CRUD)

__block ANStorageModel* storage = nil;
__block ANStorageUpdater* updater = nil;

beforeEach(^{
    storage = [ANStorageModel new];
    updater = [ANStorageUpdater updaterWithStorageModel:storage];
});


describe(@"addItem:", ^{
    
    it(@"item added in 0 section by default", ^{
        NSString* item = @"test";
        [updater addItem:item];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
    });
    
    it(@"item added at last position in 0 section", ^{
        NSString* item = @"test";
        NSString* secondItem = @"test2";
        [updater addItem:item];
        [updater addItem:secondItem];

        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).equal(secondItem);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [updater addItem:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater addItem:@"test"];
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
        [updater addItems:testModel];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel[0]);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).equal(testModel[1]);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).equal(testModel[2]);
    });
    
    it(@"no assert if add nil", ^{
        void(^block)() = ^() {
            [updater addItems:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater addItems:@[@"test"]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"items count in array equals items count in section", ^{
        
        NSArray* testModel = @[@"one", @"two", @"three"];
        [updater addItems:testModel];
        
        expect([storage itemsInSection:0]).haveCount(testModel.count);
    });
});


describe(@"adding objects in non-existing section creating required sections with method", ^{
    
    it(@"addItems", ^{
        NSArray* testModel = @[@"one", @"two", @"three"];
        [updater addItems:testModel];
        
        expect(storage.sections).haveCount(1);
    });
    
    it(@"addItem", ^{
        [updater addItem:@"test"];
        expect(storage.sections).haveCount(1);
    });
    
    it(@"addItem: toSection:", ^{
        [updater addItem:@"Test" toSection:2];
        
        expect([storage itemsInSection:0]).haveCount(0);
        expect([storage itemsInSection:1]).haveCount(0);
        expect([storage itemsInSection:2]).haveCount(1);
        expect([storage sections]).haveCount(3);
    });
});


describe(@"addItem: toSection:", ^{
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [updater addItem:nil toSection:2];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section not exists", ^{
        void(^block)() = ^() {
            [updater addItem:@"test" toSection:2];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"added item equal to retrived", ^{
        NSString* item = @"test";
        [updater addItem:item toSection:0];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
    });
    
    it(@"no assert if section index is NSNotFound", ^{
        void(^block)() = ^() {
            [updater addItem:@"test" toSection:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater addItem:@"test"];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"addItems: toSection:", ^{
    
    it(@"items added in a correct order", ^{
        NSArray* testModel = @[@"test0", @"test1", @"test2"];
        [updater addItems:testModel toSection:3];
        
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]]).equal(testModel[0]);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]]).equal(testModel[1]);
        expect([storage itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:3]]).equal(testModel[2]);
    });
    
    it(@"no assert if items are nil", ^{
        void(^block)() = ^() {
            [updater addItems:nil toSection:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section index is negative", ^{
        void(^block)() = ^() {
            [updater addItems:@[] toSection:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    //regression
    it(@"no assert if section index NSNotFound", ^{
        void(^block)() = ^() {
            [updater addItems:@[] toSection:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater addItems:@[]];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"addItem: atIndexPath:", ^{
    
    it(@"added item equal to retrived from storage", ^{
        NSString* item = @"test";
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [updater addItem:@"item"];
        [updater addItem:item atIndexPath:indexPath];
        
        expect([storage itemAtIndexPath:indexPath]).equal(item);
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [updater addItem:nil atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if indexPath is nil", ^{
        void(^block)() = ^() {
            [updater addItem:@"test" atIndexPath:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if row out of bounds", ^{
        void(^block)() = ^() {
            [updater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if section is out of bounds", ^{
        void(^block)() = ^() {
            [updater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"reloadItem:", ^{
    
    it(@"no assert if item not exists in storageModel", ^{
        void(^block)() = ^() {
            [updater reloadItem:@"test"];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [updater reloadItem:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater reloadItem:@"test"];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"reloadItems: inStorage:", ^{
    
    it(@"no assert if items not exists in storageModel", ^{
        void(^block)() = ^() {
            [updater reloadItems:@[@"test"]];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if item is nil", ^{
        void(^block)() = ^() {
            [updater reloadItems:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater reloadItems:@[@"test"]];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"replaceItem: withItem:", ^{
    
    it(@"no assert if new item is nil", ^{
        NSString* item = @"test";
        [updater addItem:item];
        
        void(^block)() = ^() {
            [updater replaceItem:item withItem:nil];
        };
        
        expect(block).notTo.raiseAny();
    });
    
    it(@"no aseert if both items are nil", ^{
        void(^block)() = ^() {
            [updater replaceItem:nil withItem:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"old item stays in storage if new item is nil", ^{
        NSString* item = @"test";
        [updater addItem:item];
        [updater replaceItem:item withItem:nil];
        
        expect([storage itemsInSection:0]).contain(item);
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater replaceItem:nil withItem:@"test" ];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if old item is nil", ^{
        void(^block)() = ^() {
            [updater replaceItem:@"test" withItem:@"test" ];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"successfully replaces item", ^{
        NSString* testModel = @"test0";
        NSString* testModel1 = @"test1";
        
        [updater addItem:testModel toSection:0];
        [updater replaceItem:testModel withItem:testModel1];
        
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
        [updater addItem:item];
        [updater addItems:@[@"testing", @"smt", @"thanks"] toSection:1];
    });
    
    it(@"no assert if from indexPath is nil", ^{
        void(^block)() = ^() {
            [updater moveItemFromIndexPath:nil toIndexPath:toIndexPath];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if to indexPath is nil", ^{
        void(^block)() = ^() {
            [updater moveItemFromIndexPath:fromIndexPath toIndexPath:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if both indexPaths are nil", ^{
        void(^block)() = ^() {
            [updater moveItemFromIndexPath:nil toIndexPath:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"item stays on existing index path if new is nil", ^{
        [updater moveItemFromIndexPath:fromIndexPath toIndexPath:nil];
        
        expect([storage itemAtIndexPath:fromIndexPath]).equal(item);
    });
    
    it(@"item successfully moved", ^{
        [updater moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
        expect([storage itemAtIndexPath:toIndexPath]).equal(item);
        expect([storage itemsInSection:0]).haveCount(0);
    });
});


describe(@"createSectionIfNotExist:inStorage: ", ^{
    
    it(@"successfully created section at specified index", ^{
        [updater addItem:@"test"];
        expect([storage sectionAtIndex:0]).notTo.beNil();
    });
    
    it(@"no exception if section already exists", ^{
        [updater addItem:@"test"];
        void(^block)() = ^() {
            [updater createSectionIfNotExist:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [updater createSectionIfNotExist:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [updater createSectionIfNotExist:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater createSectionIfNotExist:0];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"updateSectionHeaderModel: forSectionIndex: inStorage:", ^{
    
    beforeEach(^{
        storage.headerKind = @"testKind";
    });
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        [updater updateSectionHeaderModel:item forSectionIndex:0];
        
        expect([[storage sectionAtIndex:0] supplementaryModelOfKind:storage.headerKind]).equal(item);
    });
    
    it(@"no assert if model is nil", ^{
        void(^block)() = ^() {
            [updater updateSectionHeaderModel:nil forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [updater updateSectionHeaderModel:@"test" forSectionIndex:10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [updater updateSectionHeaderModel:@"test" forSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [updater updateSectionHeaderModel:@"test" forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater updateSectionHeaderModel:@"test" forSectionIndex:0];
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
        [updater updateSectionFooterModel:item forSectionIndex:0];
        
        expect([[storage sectionAtIndex:0] supplementaryModelOfKind:storage.footerKind]).equal(item);
    });
    
    it(@"no assert if model is nil", ^{
        void(^block)() = ^() {
            [updater updateSectionFooterModel:nil forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is out of bounds", ^{
        void(^block)() = ^() {
            [updater updateSectionFooterModel:@"test" forSectionIndex:10];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is negative", ^{
        void(^block)() = ^() {
            [updater updateSectionFooterModel:@"test" forSectionIndex:-1];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if index is NSNotFound", ^{
        void(^block)() = ^() {
            [updater updateSectionFooterModel:@"test" forSectionIndex:NSNotFound];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [updater updateSectionFooterModel:@"test" forSectionIndex:0];
        };
        expect(block).notTo.raiseAny();
    });
});

#pragma clang diagnostic pop

SpecEnd

