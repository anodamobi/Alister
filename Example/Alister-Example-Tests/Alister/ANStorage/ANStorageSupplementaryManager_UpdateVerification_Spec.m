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

SpecBegin(ANStorageSupplementaryManager_UpdateVerification)

__block ANStorageModel* storage = nil;

beforeEach(^{
    storage = [ANStorageModel new];
});

describe(@"updateSectionHeaderModel: forSectionIndex: inStorage:", ^{
    
    beforeEach(^{
        storage.headerKind = @"testKind";
    });
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionHeaderModel:item
                                                                               forSectionIndex:0
                                                                                     inStorage:storage];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        
        expect(update).equal(expected);
    });
    
    it(@"no update will be generated if model is nil", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionHeaderModel:nil
                                                                               forSectionIndex:0
                                                                                     inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"successfully generated update if section is not exist", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionHeaderModel:@"test"
                                                                               forSectionIndex:1
                                                                                     inStorage:storage];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        
        expect(update).equal(expected);
    });
    
    it(@"no update will be generated if index is negative", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionHeaderModel:@"test"
                                                                               forSectionIndex:-1
                                                                                     inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if index is NSNotFound", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionHeaderModel:@"test"
                                                                               forSectionIndex:NSNotFound
                                                                                     inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionHeaderModel:@"test"
                                                                               forSectionIndex:0
                                                                                     inStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
});


describe(@"updateSectionFooterModel: forSectionIndex: inStorage:", ^{
    
    beforeEach(^{
        storage.footerKind = @"testKind";
    });
    
    it(@"updates model successfully", ^{
        
        NSString* item = @"test";
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionFooterModel:item
                                                forSectionIndex:0
                                                      inStorage:storage];
        
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndex:0];
        
        expect(update).equal(expected);
    });
    
    it(@"successfully generated update if section is not exist", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionFooterModel:@"test"
                                                                               forSectionIndex:1
                                                                                     inStorage:storage];
        ANStorageUpdateModel* expected = [ANStorageUpdateModel new];
        [expected addInsertedSectionIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        
        expect(update).equal(expected);
    });
    
    it(@"no update will be generated if model is nil", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionFooterModel:nil
                                                                               forSectionIndex:0
                                                                                     inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if index is negative", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionFooterModel:@"test"
                                                                               forSectionIndex:-1
                                                                                     inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if index is NSNotFound", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionFooterModel:@"test"
                                                                               forSectionIndex:NSNotFound
                                                                                     inStorage:storage];
        expect(update.isEmpty).beTruthy();
    });
    
    it(@"no update will be generated if storage is nil", ^{
        ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionFooterModel:@"test"
                                                                               forSectionIndex:0
                                                                                     inStorage:nil];
        expect(update.isEmpty).beTruthy();
    });
});

SpecEnd

