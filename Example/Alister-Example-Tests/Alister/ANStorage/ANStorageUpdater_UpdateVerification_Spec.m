//
//  ANStorageUpdater_UpdateVerificationSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageUpdater.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageUpdateModel.h>

SpecBegin(ANStorageUpdater_UpdateVerification)

__block ANStorageModel* storage = nil;

beforeEach(^{
    storage = [ANStorageModel new];
});


describe(@"update addItem:", ^{
    
    it(@"update handles added first item in section ", ^{
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        [expected addInsertedSectionIndex:0];
        
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toStorage:storage];
        
        expect(update).equal(expected);
    });
    
    it(@"update do not create section if it exists", ^{
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]]];
        
        [ANStorageUpdater addItem:@"test" toStorage:storage];
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toStorage:storage];
        
        expect(update).equal(expected);
    });
    
    it(@"if item is nil no update will be generated", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:nil toStorage:storage];
        expect(update).beNil();
    });
    
    it(@"if storage is nil no update will be generated", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toStorage:nil];
        expect(update).beNil();
    });
});


describe(@"update addItems:", ^{
    
    it(@"objects from array added in a correct order", ^{
        NSArray* testModel = @[@"test0", @"test1", @"test2"];
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:testModel toStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],
                                          [NSIndexPath indexPathForRow:1 inSection:0],
                                          [NSIndexPath indexPathForRow:2 inSection:0]]];
        expect(update).equal(expected);
    });
    
    it(@"no update generated if add nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:nil toStorage:storage];
        expect(update).beNil();
    });
    
    it(@"no update generated if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[@"test"] toStorage:nil];
        expect(update).beNil();
    });
    
    it(@"no update generated if add empty array", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[] toStorage:storage];
        expect(update).beNil();
    });
});


describe(@"update adding objects in new section autocreates them", ^{
    
    it(@"addItems", ^{
        NSArray* testModel = @[@"one", @"two", @"three"];
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:testModel toStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],
                                          [NSIndexPath indexPathForRow:1 inSection:0],
                                          [NSIndexPath indexPathForRow:2 inSection:0]]];
        
        expect(update).equal(expected);
    });
    
    it(@"addItem", ^{
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        [expected addInsertedSectionIndex:0];
        
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toStorage:storage];
        
        expect(update).equal(expected);
    });
    
    it(@"addItem: toSection:", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"Test" toSection:2 toStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]]];
        [expected addInsertedSectionIndex:1];
        
        expect(update).equal(expected);
    });
});


describe(@"update addItem: toSection:", ^{
    
    it(@"if section is not exists it will be generated", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"Test" toSection:2 toStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]]];
        [expected addInsertedSectionIndex:1];
        
        expect(update).equal(expected);
    });
    
    it(@"no update will be generated if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toStorage:nil];
        expect(update).beNil();
    });
    
    it(@"no update will be generated if section index is NSNotFound", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toSection:NSNotFound toStorage:storage];
        expect(update).beNil();
    });
    
    it(@"no update generated if item is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:nil toSection:2 toStorage:storage];
        expect(update).beNil();
    });
});


describe(@"verify update for addItems: toSection:", ^{
    
    it(@"items added in a correct order", ^{
        NSArray* testModel = @[@"test0", @"test1", @"test2"];
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:testModel toSection:3 toStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3],
                                          [NSIndexPath indexPathForRow:1 inSection:3],
                                          [NSIndexPath indexPathForRow:2 inSection:3]]];
        expect(update).equal(expected);
    });
    
    it(@"no update will be generated if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[] toSection:0 toStorage:nil];
        expect(update).beNil();
    });
    
    it(@"no update will be generated if section index is negative", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[] toSection:-1 toStorage:storage];
        expect(update).beNil();
    });
    
    it(@"no update will be generated if section index NSNotFound", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[] toSection:NSNotFound toStorage:storage];
        expect(update).beNil();
    });
});


describe(@"verify update for addItem: atIndexPath:", ^{
    
    it(@"added item equal to retrived from storage", ^{
        NSString* item = @"test";
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:item atIndexPath:indexPath toStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]]];
        
        expect(update).equal(expected);
    });
    
    it(@"no update will be generated  if item is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:nil
                                                     atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                       toStorage:storage];
        expect(update).beNil();
    });
    
    it(@"no update will be generated if indexPath is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" atIndexPath:nil toStorage:storage];
        expect(update).beNil();
    });
    
    it(@"no update will be generated if row out of bounds", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test"
                                                     atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]
                                                       toStorage:storage];
        expect(update).beNil();
    });
    
    it(@"no update will be generated if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test"
                                                     atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
                                                       toStorage:nil];
        expect(update).beNil();
    });
});


//Reload items

describe(@"reloadItem:", ^{
    
    it(@"item reloaded if exists", ^{
        
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toStorage:storage];
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:item inStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addUpdatedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        
        expect(update).equal(expected);
    });
    
    it(@"no update will be generated if item not exists in storageModel", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:@"test" inStorage:storage];
        expect(update).beNil();
    });
    
    it(@"no update will be generated if item is nil", ^{
        
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:nil inStorage:storage];
        expect(update).beNil();
    });
    
    it(@"no update will be generated if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:@"test" inStorage:nil];
        expect(update).beNil();
    });
});

SpecEnd

