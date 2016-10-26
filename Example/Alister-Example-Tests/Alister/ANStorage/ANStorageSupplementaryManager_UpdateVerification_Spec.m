//
//  ANStorageSupplementaryManager_UpdateVerification_Spec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/15/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageSupplementaryManager.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageSectionModel.h>
#import <Alister/ANStorageUpdateModel.h>
#import "ANStorageFakeOperationDelegate.h"

SpecBegin(ANStorageSupplementaryManager_UpdateVerification)

__block ANStorageModel* storage = nil;
__block ANStorageSupplementaryManager* supplementaryManager = nil;
__block ANStorageFakeOperationDelegate* fakeDelegate = nil;

beforeEach(^{
    storage = [ANStorageModel new];
    fakeDelegate = [ANStorageFakeOperationDelegate new];
    supplementaryManager = [ANStorageSupplementaryManager supplementatyManagerWithStorageModel:storage updateDelegate:fakeDelegate];
});

describe(@"updateSectionHeaderModel: forSectionIndex: inStorage:", ^{
    
    beforeEach(^{
        storage.headerKind = @"testKind";
    });
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        [supplementaryManager updateSectionHeaderModel:item forSectionIndex:0];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"no update will be generated if model is nil", ^{
        [supplementaryManager updateSectionHeaderModel:nil forSectionIndex:0];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"successfully generated update if section is not exist", ^{
        [supplementaryManager updateSectionHeaderModel:@"test" forSectionIndex:1];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"no update will be generated if index is negative", ^{
        [supplementaryManager updateSectionHeaderModel:@"test" forSectionIndex:-1];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if index is NSNotFound", ^{
        [supplementaryManager updateSectionHeaderModel:@"test" forSectionIndex:NSNotFound];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if storage is nil", ^{
        supplementaryManager = [ANStorageSupplementaryManager supplementatyManagerWithStorageModel:nil
                                                                                    updateDelegate:fakeDelegate];
        [supplementaryManager updateSectionHeaderModel:@"test" forSectionIndex:0];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});


describe(@"updateSectionFooterModel: forSectionIndex: inStorage:", ^{
    
    beforeEach(^{
        storage.footerKind = @"testKind";
    });
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        [supplementaryManager updateSectionFooterModel:item forSectionIndex:0];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"successfully generated update if section is not exist", ^{
       
        [supplementaryManager updateSectionFooterModel:@"test" forSectionIndex:1];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        
        expect(fakeDelegate.lastUpdate).equal(expected);
    });
    
    it(@"no update will be generated if model is nil", ^{
        [supplementaryManager updateSectionFooterModel:nil forSectionIndex:0];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if index is negative", ^{
        [supplementaryManager updateSectionFooterModel:@"test" forSectionIndex:-1];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if index is NSNotFound", ^{
        [supplementaryManager updateSectionFooterModel:@"test" forSectionIndex:NSNotFound];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if storage is nil", ^{
        supplementaryManager = [ANStorageSupplementaryManager supplementatyManagerWithStorageModel:nil
                                                                                    updateDelegate:fakeDelegate];
        [supplementaryManager updateSectionFooterModel:@"test" forSectionIndex:0];
        expect(fakeDelegate.lastUpdate.isEmpty).beTruthy();
    });
});

SpecEnd

