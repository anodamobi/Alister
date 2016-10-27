//
//  ANListControllerMappingServiceSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/27/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANListControllerMappingService.h>

SpecBegin(ANListControllerMappingService)

__block ANListControllerMappingService* mapping = nil;

beforeEach(^{
    mapping = [ANListControllerMappingService new];
});

describe(@"identifierForViewModelClass:", ^{
    
    it(@"will provide identifier for class", ^{
        NSString* result1 = [mapping identifierForViewModelClass:[NSString class]];
        
        expect(result1).notTo.beNil();
    });
    
    it(@"no assert if class is nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModelClass:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"identifier will be nil if class is nil", ^{
        NSString* identifier = [mapping identifierForViewModelClass:nil];
        expect(identifier).beNil();
    });
    
    it(@"if model is not registered will try to find parent registered class", ^{
        
        id viewModel1 = @"test";
        Class viewModelAnotherClass = [NSString class];
        
        NSString* result1 = [mapping identifierForViewModelClass:viewModelAnotherClass];
        NSString* result2 = [mapping identifierForViewModelClass:[viewModel1 class]];
        
        expect(result1).equal(result2);
        expect(result2).notTo.beNil();
    });
});


SpecEnd

