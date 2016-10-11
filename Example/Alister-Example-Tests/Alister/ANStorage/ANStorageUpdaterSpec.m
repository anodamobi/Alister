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

SpecBegin()

__block ANStorageModel* storage = nil;

beforeEach(^{
   storage = [ANStorageModel new];
});

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


describe(@"update addItem:", ^{
    
    it(@"if added first item in section ", ^{
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        [expected addInsertedSectionIndex:0];
        
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toStorage:storage];
        
        expect(update).equal(expected);
    });
});



//
//describe(@"addItems:", ^{
//    
//    it(@"objects from array added in a correct order", ^{
//        
//        NSString* testModel0 = @"test0";
//        NSString* testModel1 = @"test1";
//        NSString* testModel2 = @"test2";
//        NSArray* testModel = @[testModel0, testModel1, testModel2];
//        [ANStorageUpdater addItems:testModel];
//        
//        expect([ANStorageUpdater itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(testModel[0]);
//        expect([ANStorageUpdater itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).equal(testModel[1]);
//        expect([ANStorageUpdater itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).equal(testModel[2]);
//    });
//    
//    it(@"no assert if add nil", ^{
//        void(^block)() = ^() {
//            [ANStorageUpdater addItems:nil];
//        };
//        expect(block).notTo.raiseAny();
//    });
//    
//    it(@"items count in array equals items count in section", ^{
//        NSArray* testModel = @[@"one", @"two", @"three"];
//        [ANStorageUpdater addItems:testModel];
//        
//        expect([ANStorageUpdater itemsInSection:0]).haveCount(testModel.count);
//    });
//});
//
//
//describe(@"adding objects in non-existing section creating required sections with method", ^{
//    
//    it(@"addItems", ^{
//        NSArray* testModel = @[@"one", @"two", @"three"];
//        [ANStorageUpdater addItems:testModel];
//        
//        expect(ANStorageUpdater.sections).haveCount(1);
//    });
//    
//    it(@"addItem", ^{
//        [ANStorageUpdater addItem:@"test"];
//        expect(ANStorageUpdater.sections).haveCount(1);
//    });
//    
//    it(@"addItem: toSection:", ^{
//        [ANStorageUpdater addItem:@"Test" toSection:2];
//        
//        expect([ANStorageUpdater itemsInSection:0]).haveCount(0);
//        expect([ANStorageUpdater itemsInSection:1]).haveCount(0);
//        expect([ANStorageUpdater itemsInSection:2]).haveCount(1);
//        expect([ANStorageUpdater sections]).haveCount(3);
//    });
//});
//
//
//describe(@"addItem: toSection:", ^{
//    
//    it(@"no assert if item is nil", ^{
//        void(^block)() = ^() {
//            [ANStorageUpdater addItem:nil toSection:2];
//        };
//        expect(block).notTo.raiseAny();
//    });
//    
//    it(@"no assert if section not exists", ^{
//        void(^block)() = ^() {
//            [ANStorageUpdater addItem:@"test" toSection:2];
//        };
//        expect(block).notTo.raiseAny();
//    });
//    
//    it(@"added item equal to retrived", ^{
//        NSString* item = @"test";
//        [ANStorageUpdater addItem:item toSection:0];
//        
//        expect([ANStorageUpdater itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).equal(item);
//    });
//    
//    it(@"no assert if section index is NSNotFound", ^{
//        void(^block)() = ^() {
//            [ANStorageUpdater addItem:@"test" toSection:NSNotFound];
//        };
//        expect(block).notTo.raiseAny();
//    });
//});
//
//
//describe(@"addItems: toSection:", ^{
//    
//    it(@"items added in a correct order", ^{
//        NSArray* testModel = @[@"test0", @"test1", @"test2"];
//        [ANStorageUpdater addItems:testModel toSection:3];
//        
//        expect([ANStorageUpdater itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]]).equal(testModel[0]);
//        expect([ANStorageUpdater itemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]]).equal(testModel[1]);
//        expect([ANStorageUpdater itemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:3]]).equal(testModel[2]);
//    });
//    
//    it(@"no assert if add nil", ^{
//        void(^block)() = ^() {
//            [ANStorageUpdater addItems:nil toSection:0];
//        };
//        expect(block).notTo.raiseAny();
//    });
//    
//    it(@"no assert if section index is negative", ^{
//        void(^block)() = ^() {
//            [ANStorageUpdater addItems:@[] toSection:-1];
//        };
//        expect(block).notTo.raiseAny();
//    });
//    
//    //regression
//    it(@"no assert if section index NSNotFound", ^{
//        void(^block)() = ^() {
//            [ANStorageUpdater addItems:@[] toSection:NSNotFound];
//        };
//        expect(block).notTo.raiseAny();
//    });
//});
//
//
//describe(@"addItem: atIndexPath:", ^{
//    
//    it(@"no assert if item is nil", ^{
//        [ANStorageUpdater addItem:nil atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    });
//    
//    it(@"no assert if indexPath is nil", ^{
//        [ANStorageUpdater addItem:@"test" atIndexPath:nil];
//    });
//    
//    it(@"no assert if item and indexPath are nil", ^{
//        
//    });
//    
//    it(@"added item equal to retrived", ^{
//        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [ANStorageUpdater addItem:@"test" atIndexPath:indexPath];
//        
//        expect([ANStorageUpdater itemAtIndexPath:indexPath]).equal(@"test");
//    });
//    
//    it(@"no assert if row out of bounds", ^{
//        void(^block)() = ^() {
//            [ANStorageUpdater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//        };
//        expect(block).notTo.raiseAny();
//    });
//    
//    it(@"no assert if section is out of bounds", ^{
//        void(^block)() = ^() {
//            [ANStorageUpdater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
//        };
//        expect(block).notTo.raiseAny();
//    });
//});


SpecEnd
