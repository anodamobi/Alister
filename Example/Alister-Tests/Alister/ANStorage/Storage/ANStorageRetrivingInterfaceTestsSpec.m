//
//  ANStorageRetrivingInterfaceTestsSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/31/16.
//  Copyright 2016 Oksana Kovalchuk. All rights reserved.
//

#import "Specta.h"
#import "ANStorage.h"
#import "ANStorageModel.h"

SpecBegin(ANStorageRetrivingInterfaceTests)

__block ANStorage *storage = nil;

beforeEach(^{
    storage = [ANStorage new];
});

describe(@"storage ANStorageRetrivingInterface", ^{
    
    it(@"storage conform to protocol ANStorageRetrivingInterface", ^{
        expect(storage).conformTo(@protocol(ANStorageRetrivingInterface));
    });
    
    it(@"isEmpty should return YES",^{
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController removeAllItemsAndSections];
        }];
        expect([storage isEmpty]).to.beTruthy();
    });
    
    it(@"isEmpty should return  NO after add items", ^{
        [storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItem:@"some object"];
        }];
        expect([storage isEmpty]).to.beFalsy();
    });
    
});

describe(@"storage return sections", ^{
    
    it(@"return empty section count", ^{
        expect(storage.sections.count).equal(0);
    });
    
    it(@"return expected sections count", ^{
        
        NSArray* testObjects = @[@1,@2,@3,@4];
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:testObjects];
        }];
        
        expect(storage.sections.count).notTo.beNil();
    });
    
});

describe(@"storage return object at index path", ^{
   
    it(@"return nil at empty index path", ^{
        
        NSIndexPath* notExistObjectIndexPath = [NSIndexPath indexPathWithIndex:12];
        
        id object = [storage objectAtIndexPath:notExistObjectIndexPath];
        
        expect(object).to.beNil();
    });
    
    it(@"return exepcted object at expsting index path", ^{
        
        NSArray* testObjects = @[@1,@2,@3,@4];
        
        NSIndexPath* expectedObjectIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:testObjects];
        }];
        
        id object = [storage objectAtIndexPath:expectedObjectIndexPath];
        
        expect(object).notTo.beNil();
    });
    
});

describe(@"section model at index path", ^{
   
    it(@"return not nil storage model at not existing section index", ^{
        
        NSUInteger notExistingSectionIndex = 12;
        
        id model = [storage sectionAtIndex:notExistingSectionIndex];
        
        expect(model).to.beNil();
        
    });
    
    it(@"return expected storage model", ^{
        
        NSArray* testObjects = @[@1,@2,@3,@4];
        
        NSUInteger firstSectionIndex = 0;
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:testObjects];
        }];
        
        id model = [storage sectionAtIndex:firstSectionIndex];
        
        expect(model).notTo.beNil();
        
    });
    
    it(@"returned model is ANStorageSectionModel", ^{
        
        NSArray* testObjects = @[@1,@2,@3,@4];
        
         NSUInteger firstSectionIndex = 0;
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:testObjects];
        }];
        
        id model = [storage sectionAtIndex:firstSectionIndex];
        
        expect(model).to.beAKindOf([ANStorageSectionModel class]);
        
    });
    
});


describe(@"items in section tests", ^{
   
    it(@"return zero objects for empty section", ^{
    
        NSUInteger notExistingSectionIndex = 12;
        
        NSArray* items = [storage itemsInSection:notExistingSectionIndex];
       
        expect(items).to.beNil();
        
    });
    
    
    it(@"return expected objects count", ^{
        
        NSArray* testObjects = @[@1,@2,@3,@4];
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:testObjects];
        }];
        
        NSArray* items = [storage itemsInSection:0];
        
        expect(items.count).equal(testObjects.count);
        
    });
    
});

describe(@"header for model in section", ^{
    
    it(@"return nil for not exist header model", ^{
        
        id headerModel = [storage headerModelForSectionIndex:0];
        
        expect(headerModel).to.beNil();
    });
    
    it(@"if try to setup nil model in controller not throw to exception", ^{
       
        NSString* nullableHeaderModel = nil;
        
        void (^testBlock)() = ^{
            [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
                [storageController updateSectionHeaderModel:nullableHeaderModel forSectionIndex:0];
            }];
        };
        
        expect(testBlock).notTo.raiseAny();
        
    });
    
    
    it(@"return expected header model", ^{
        
        NSString* headerModel = @"test header string model";
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController updateSectionHeaderModel:headerModel forSectionIndex:0];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            id model = [storage headerModelForSectionIndex:0];
            expect(model).notTo.beNil();
        });

    });
});

describe(@"footer model for section with index", ^{
    
    it(@"return nil for not exist footer model", ^{
       
        id footerModel = [storage footerModelForSectionIndex:0];
        
        expect(footerModel).to.beNil();
    });

    it(@"return not empty footer model", ^{
        
        NSString* footerModel = @"test footer model";
        NSUInteger testedSectionIndex = 0;
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController updateSectionFooterModel:footerModel forSectionIndex:testedSectionIndex];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            id expectedFooterModel = [storage footerModelForSectionIndex:testedSectionIndex];
            expect(expectedFooterModel).notTo.beNil();
        });
    });
    
});

SpecEnd
