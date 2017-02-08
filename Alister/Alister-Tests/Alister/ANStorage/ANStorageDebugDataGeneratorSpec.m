//
//  ANStorageDebugDataGeneratorSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageDebugDataGenerator.h"
#import "ANStorage.h"
#import "ANStorageSectionModel.h"
#import "ANStorageModel.h"

SpecBegin(ANStorageDebugDataGenerator)

__block ANStorageModel* storageModel = nil;
__block ANStorage* storage = nil;
__block ANStorageSectionModel* sectionModel = nil;

beforeEach(^{
    
});

describe(@"storageDebugDescription:", ^{
    
    it(@"if storage is nil return nil", ^{
        id result = [ANStorageDebugDataGenerator storageDebugDescription:nil];
        expect(result).to.beNil();
    });
    
    it(@"successfully generates description for storage", ^{
        
    });
});

SpecEnd


//+ (NSString*)storageDebugDescription:(ANStorage*)storage;
//+ (NSString*)sectionDebugDescription:(ANStorageSectionModel*)section;
//+ (NSString*)storageModelDebugDescription:(ANStorageModel*)storageModel;
