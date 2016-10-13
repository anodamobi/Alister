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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

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
    
    it(@"update will not create section if it exists", ^{
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]]];
        
        [ANStorageUpdater addItem:@"test" toStorage:storage];
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toStorage:storage];
        
        expect(update).equal(expected);
    });
    
    it(@"update will be empty if item is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:nil toStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toStorage:nil];
        expect(update.isEmpty).beTruthy();
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
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"no update generated if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[@"test"] toStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"no update generated if add empty array", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[] toStorage:storage];
        expect(update.isEmpty).beTruthy();
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
    
    it(@"update will be empty if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if section index is NSNotFound", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" toSection:NSNotFound toStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"no update generated if item is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:nil toSection:2 toStorage:storage];
        expect(update.isEmpty).beTruthy();
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
    
    it(@"update will be empty if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[] toSection:0 toStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if section index is negative", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[] toSection:-1 toStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if section index NSNotFound", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItems:@[] toSection:NSNotFound toStorage:storage];
        expect(update.isEmpty).beTruthy();
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
    
    it(@"update will be empty  if item is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:nil
                                                     atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                       toStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if indexPath is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test" atIndexPath:nil toStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if row out of bounds", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test"
                                                     atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]
                                                       toStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater addItem:@"test"
                                                     atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
                                                       toStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
});


describe(@"reloadItem:", ^{
    
    it(@"item reloaded if exists", ^{
        
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toStorage:storage];
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:item inStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addUpdatedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        
        expect(update).equal(expected);
    });
    
    it(@"update will be empty if item not exists in storageModel", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:@"test" inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if item is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:nil inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:@"test" inStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
});


describe(@"reloadItems: inStorage:", ^{
    
    it(@"item reloaded if exists", ^{
        
        NSString* item = @"test";
        [ANStorageUpdater addItem:item toStorage:storage];
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:item inStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addUpdatedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        
        expect(update).equal(expected);
    });
    
    it(@"update will be empty if items not exists in storageModel", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItems:@[@"test"] inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if item is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItems:nil inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater reloadItems:@[@"test"] inStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
});


describe(@"replaceItem: withItem:", ^{
    
    __block NSString* item = @"test";
    
    beforeEach(^{
        [ANStorageUpdater addItem:item toStorage:storage];
    });
    
    it(@"update will be empty if new item is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater replaceItem:item withItem:nil inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if both items are nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater replaceItem:nil withItem:nil inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater replaceItem:nil withItem:@"test"  inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if old item is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater replaceItem:@"test" withItem:@"test"  inStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"successfully replaces item", ^{
        NSString* testModel = @"test0";
        ANStorageUpdateModel* update = [ANStorageUpdater replaceItem:item withItem:testModel inStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addUpdatedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        
        expect(update).equal(expected);
    });
});


describe(@"moveItemFromIndexPath: toIndexPath:", ^{
    
    __block NSIndexPath* fromIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    __block NSIndexPath* toIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    __block NSString* item = @"test";
    
    beforeEach(^{
        [ANStorageUpdater addItem:item toStorage:storage];
    });
    
    it(@"update will be empty if from indexPath is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater moveItemFromIndexPath:nil
                                                                   toIndexPath:toIndexPath
                                                                     inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if to indexPath is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater moveItemFromIndexPath:fromIndexPath
                                                                   toIndexPath:nil
                                                                     inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if both indexPaths are nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater moveItemFromIndexPath:nil
                                                                   toIndexPath:nil
                                                                     inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater moveItemFromIndexPath:fromIndexPath
                                                                   toIndexPath:toIndexPath
                                                                     inStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"item successfully moved", ^{
        ANStorageUpdateModel* update = [ANStorageUpdater moveItemFromIndexPath:fromIndexPath
                                                                   toIndexPath:toIndexPath
                                                                     inStorage:storage];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        ANStorageMovedIndexPathModel* indexPath = [ANStorageMovedIndexPathModel modelWithFromIndexPath:fromIndexPath
                                                                                            toIndexPath:toIndexPath];
        [expected addMovedIndexPaths:@[indexPath]];
        
        expect(update).equal(expected);
    });
});


describe(@"createSectionIfNotExist:inStorage: ", ^{
    
    it(@"successfully created section at specified index", ^{
        NSIndexSet* update = [ANStorageUpdater createSectionIfNotExist:0 inStorage:storage];
        expect(update).equal([NSIndexSet indexSetWithIndex:0]);
    });
    
    it(@"changed indexes are empty if section already exists", ^{
        [ANStorageUpdater addItem:@"test" toStorage:storage];
        NSIndexSet* update =  [ANStorageUpdater createSectionIfNotExist:0 inStorage:storage];
        expect(update).haveCount(0);
    });
    
    it(@"update will be empty if index is negative", ^{
        NSIndexSet* update = [ANStorageUpdater createSectionIfNotExist:-1 inStorage:storage];
        expect(update).haveCount(0);
    });
    
    it(@"update will be empty if index is NSNotFound", ^{
        NSIndexSet* update = [ANStorageUpdater createSectionIfNotExist:NSNotFound inStorage:storage];
        expect(update).haveCount(0);
    });
    
    it(@"update will be empty if storage is nil", ^{
        NSIndexSet* update = [ANStorageUpdater createSectionIfNotExist:0 inStorage:nil];
        expect(update).haveCount(0);
    });
});

SpecEnd

#pragma clang diagnostic pop
