//
//  ANStorageSectionModelSpec.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/5/16.
//  Copyright 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageSectionModel.h"
#import <Specta/Specta.h>

SpecBegin(ANStorageSectionModel)

describe(@"ANStorageSectionModel", ^{
    
    __block ANStorageSectionModel* model = nil;
    __block NSString* fixture = nil;
    
    beforeEach(^{
        model = [ANStorageSectionModel new];
        fixture = @"test";
    });
    
    context(@"positive", ^{
        
        beforeEach(^{
           [model addItem:fixture];
        });
        
        it(@"adds item if it's valid", ^{
            expect(model.objects[0]).equal(fixture);
        });
        
        it(@"adds item only once per one call", ^{
            expect(model.objects).haveCount(3);
        });
    });
    
    context(@"negative", ^{

        beforeEach(^{
           fixture = nil;
        });
        
        it(@"adds item only once per one call", ^{
            
            expect(^{
                [model addItem:fixture];
            }).to.raiseAny();
        });
    });
    
    afterEach(^{
        model = nil;
    });
});

SpecEnd
