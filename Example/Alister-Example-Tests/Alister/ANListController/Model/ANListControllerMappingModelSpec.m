//
//  ANListControllerMappingModelSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/27/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANListControllerMappingModel.h>

SpecBegin(ANListControllerMappingModel)

__block ANListControllerMappingModel* model = nil;

beforeEach(^{
    model = [ANListControllerMappingModel new];
});

describe(@"at default state", ^{
    
    it(@"classIdentifier will be nil", ^{
        expect(model.reuseIdentifier).beNil();
    });
    
    it(@"mappingClass will be nil", ^{
        expect(model.mappingClass).beNil();
    });
    
    it(@"kind will be nil", ^{
        expect(model.kind).beNil();
    });
    
    it(@"isSystem will be false", ^{
        expect(model.isSystem).beFalsy();
    });
});


context(@"custom init", ^{
    
    describe(@"modelWithMappingClass: kind: isSystem: classIdentifier:", ^{
        
        it(@"no assert ", ^{
            failure(@"Pending");
        });
    });
    
    
    describe(@"initWithMappingClass: kind: isSystem: classIdentifier:", ^{
        failure(@"Pending");
    });

    
    
});

SpecEnd
