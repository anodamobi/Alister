//
//  ANStorageUpdater_UpdateVerificationSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageUpdater.h"
#import "ANStorageModel.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageFakeOperationDelegate.h"

SpecBegin(ANStorageUpdater_UpdateVerification)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

__block ANStorageUpdater* updater = nil;
__block ANStorageFakeOperationDelegate* fakeDelegate = nil;
__block ANStorageModel* storage = nil;

beforeEach(^{
    storage = [ANStorageModel new];
    fakeDelegate = [ANStorageFakeOperationDelegate new];
    updater = [ANStorageUpdater updaterWithStorageModel:storage];
    updater.updateDelegate = fakeDelegate;
});


describe(@"update addItem:", ^{
    
    it(@"update handles added first item in section ", ^{
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        [expected addInsertedSectionIndex:0];
        
        [updater addItem:@"test"];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will not create section if it exists", ^{
        
        [updater addItem:@"test"];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]]];
        
        [updater addItem:@"test"];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty if item is nil", ^{
        [updater addItem:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater addItem:@"test"];
        
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"update addItems:", ^{
    
    it(@"objects from array added in a correct order", ^{
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],
                                          [NSIndexPath indexPathForRow:1 inSection:0],
                                          [NSIndexPath indexPathForRow:2 inSection:0]]];
        
        [updater addItems:@[@"test0", @"test1", @"test2"]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"no update generated if add nil", ^{
        [updater addItems:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update generated if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:storage];
        updater.updateDelegate = fakeDelegate; //TODO: move this test cases in one context
        [updater addItems:@[@"test"]];
        
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update generated if add empty array", ^{
        [updater addItems:@[]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"update adding objects in new section autocreates them", ^{
    
    it(@"addItems", ^{
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],
                                          [NSIndexPath indexPathForRow:1 inSection:0],
                                          [NSIndexPath indexPathForRow:2 inSection:0]]];
        
        [updater addItems:@[@"one", @"two", @"three"]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"addItem", ^{
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        [expected addInsertedSectionIndex:0];
        
        [updater addItem:@"test"];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"addItem: toSection:", ^{
        [updater addItem:@"Test" toSection:2];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]]];
        [expected addInsertedSectionIndex:1];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
});


describe(@"update addItem: toSection:", ^{
    
    it(@"if section is not exists it will be generated", ^{
        [updater addItem:@"Test" toSection:2];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]]];
        [expected addInsertedSectionIndex:1];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater addItem:@"test"];
       
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if section index is NSNotFound", ^{
        [updater addItem:@"test" toSection:NSNotFound];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update generated if item is nil", ^{
        [updater addItem:nil toSection:2];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"verify update for addItems: toSection:", ^{
    
    it(@"items added in a correct order", ^{
        NSArray* testModel = @[@"test0", @"test1", @"test2"];
        [updater addItems:testModel toSection:3];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3],
                                          [NSIndexPath indexPathForRow:1 inSection:3],
                                          [NSIndexPath indexPathForRow:2 inSection:3]]];
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater addItems:@[] toSection:0];
        
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if section index is negative", ^{
        [updater addItems:@[] toSection:-1];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if section index NSNotFound", ^{
        [updater addItems:@[] toSection:NSNotFound];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"verify update for addItem: atIndexPath:", ^{
    
    it(@"added item equal to retrived from storage", ^{
        NSString* item = @"test";
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [updater addItem:item atIndexPath:indexPath];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        [expected addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty  if item is nil", ^{
        [updater addItem:nil atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if indexPath is nil", ^{
        [updater addItem:@"test" atIndexPath:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if row out of bounds", ^{
        [updater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater addItem:@"test" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"reloadItem:", ^{
    
    it(@"item reloaded if exists", ^{
        
        NSString* item = @"test";
        [updater addItem:item];
        [updater reloadItem:item];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addUpdatedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty if item not exists in storageModel", ^{
        [updater reloadItem:@"test"];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if item is nil", ^{
        [updater reloadItem:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater reloadItem:@"test"];
        
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"reloadItems: inStorage:", ^{
    
    it(@"item reloaded if exists", ^{
        
        NSString* item = @"test";
        [updater addItem:item];
        [updater reloadItem:item];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addUpdatedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"update will be empty if items not exists in storageModel", ^{
        [updater reloadItems:@[@"test"]];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if item is nil", ^{
        [updater reloadItems:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater reloadItems:@[@"test"]];
        
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"replaceItem: withItem:", ^{
    
    __block NSString* item = @"test";
    
    beforeEach(^{
        [updater addItem:item];
    });
    
    it(@"update will be empty if new item is nil", ^{
        [updater replaceItem:item withItem:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if both items are nil", ^{
        [updater replaceItem:nil withItem:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater replaceItem:@"test" withItem:@"test"];
        
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if old item is nil", ^{
        [updater replaceItem:nil withItem:@"test"];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"successfully replaces item", ^{
        NSString* testModel = @"test0";
        [updater replaceItem:item withItem:testModel];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addUpdatedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
});


describe(@"moveItemFromIndexPath: toIndexPath:", ^{
    
    __block NSIndexPath* fromIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    __block NSIndexPath* toIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    __block NSString* item = @"test";
    
    beforeEach(^{
        [updater addItem:item];
    });
    
    it(@"update will be empty if from indexPath is nil", ^{
        [updater moveItemFromIndexPath:nil toIndexPath:toIndexPath];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if to indexPath is nil", ^{
        [updater moveItemFromIndexPath:fromIndexPath toIndexPath:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if both indexPaths are nil", ^{
        [updater moveItemFromIndexPath:nil toIndexPath:nil];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"update will be empty if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
        
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"item successfully moved", ^{
        [updater moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        ANStorageMovedIndexPathModel* indexPath = [ANStorageMovedIndexPathModel modelWithFromIndexPath:fromIndexPath
                                                                                            toIndexPath:toIndexPath];
        [expected addMovedIndexPaths:@[indexPath]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
});


describe(@"createSectionIfNotExist:inStorage: ", ^{
    
    it(@"successfully created section at specified index", ^{
        NSIndexSet* update = [updater createSectionIfNotExist:0];
        expect(update).equal([NSIndexSet indexSetWithIndex:0]);
    });
    
    it(@"changed indexes are empty if section already exists", ^{
        [updater addItem:@"test"];
        NSIndexSet* update =  [updater createSectionIfNotExist:0];
        expect(update).haveCount(0);
    });
    
    it(@"update will be empty if index is negative", ^{
        NSIndexSet* update = [updater createSectionIfNotExist:-1];
        expect(update).haveCount(0);
    });
    
    it(@"update will be empty if index is NSNotFound", ^{
        NSIndexSet* update = [updater createSectionIfNotExist:NSNotFound];
        expect(update).haveCount(0);
    });
    
    it(@"update will be empty if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        NSIndexSet* update = [updater createSectionIfNotExist:0];
        
        expect(update).haveCount(0);
    });
});

describe(@"updateSectionHeaderModel: forSectionIndex: inStorage:", ^{
    
    beforeEach(^{
        storage.headerKind = @"testKind";
    });
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        [updater updateSectionHeaderModel:item forSectionIndex:0];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"no update will be generated if model is nil", ^{
        [updater updateSectionHeaderModel:nil forSectionIndex:0];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"successfully generated update if section is not exist", ^{
        [updater updateSectionHeaderModel:@"test" forSectionIndex:1];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"no update will be generated if index is negative", ^{
        [updater updateSectionHeaderModel:@"test" forSectionIndex:-1];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if index is NSNotFound", ^{
        [updater updateSectionHeaderModel:@"test" forSectionIndex:NSNotFound];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater updateSectionHeaderModel:@"test" forSectionIndex:0];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"updateSectionFooterModel: forSectionIndex: inStorage:", ^{
    
    beforeEach(^{
        storage.footerKind = @"testKind";
    });
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        [updater updateSectionFooterModel:item forSectionIndex:0];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"successfully generated update if section is not exist", ^{
        
        [updater updateSectionFooterModel:@"test" forSectionIndex:1];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"no update will be generated if model is nil", ^{
        [updater updateSectionFooterModel:nil forSectionIndex:0];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if index is negative", ^{
        [updater updateSectionFooterModel:@"test" forSectionIndex:-1];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if index is NSNotFound", ^{
        [updater updateSectionFooterModel:@"test" forSectionIndex:NSNotFound];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if storage is nil", ^{
        updater = [ANStorageUpdater updaterWithStorageModel:nil];
        updater.updateDelegate = fakeDelegate;
        [updater updateSectionFooterModel:@"test" forSectionIndex:0];
        
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});

#pragma clang diagnostic pop

SpecEnd
