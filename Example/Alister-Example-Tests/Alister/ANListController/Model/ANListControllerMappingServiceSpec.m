//
//  ANListControllerMappingServiceSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/27/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANListControllerMappingService.h>
#import "ANTestingFixtureObjects.h"

SpecBegin(ANListControllerMappingService)

__block ANListControllerMappingService* mapping = nil;
__block id nilValue = nil;

beforeEach(^{
    mapping = [ANListControllerMappingService new];
    nilValue = nil;
});

describe(@"registerViewModelClass:", ^{
    
});

describe(@"registerViewModelClass: kind:", ^{
    
});




describe(@"identifierForViewModelClass:", ^{
    
    it(@"will provide identifier for registered for class", ^{
       
        [mapping registerViewModelClass:[NSString class]];
        NSString* result1 = [mapping identifierForViewModelClass:[NSString class]];
        
        expect(result1).notTo.beNil();
    });
    
    it(@"will return nil if class is not registered", ^{
       
        NSString* result1 = [mapping identifierForViewModelClass:[NSString class]];
        expect(result1).beNil();
    });
    
    it(@"no assert if class is nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModelClass:nilValue];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"identifier will be nil if class is nil", ^{
        NSString* identifier = [mapping identifierForViewModelClass:nilValue];
        expect(identifier).beNil();
    });
    
    it(@"if model is not registered will try to find parent registered class", ^{
        
        [mapping registerViewModelClass:[NSString class]];
        
        NSString* parentID = [mapping identifierForViewModelClass:[NSString class]];
        NSString* childID = [mapping identifierForViewModelClass:[@"test" class]];
        
        expect(parentID).equal(childID);
        expect(childID).notTo.beNil();
    });
    
    it(@"if child and parent models registered will return different identifiers", ^{
       
        Class modelClass = [ANTestingFixtureObject class];
        Class inheritedModelClass = [ANTestingFixtureObjectInherited class];
        
        [mapping registerViewModelClass:modelClass];
        [mapping registerViewModelClass:inheritedModelClass];
        
        NSString* parentID = [mapping identifierForViewModelClass:modelClass];
        NSString* childID = [mapping identifierForViewModelClass:inheritedModelClass];
        
        expect(parentID).notTo.equal(childID);
        expect(childID).notTo.beNil();
    });
});


describe(@"identifierForViewModelClass: kind:", ^{
    
    __block NSString* kind = @"kind";
    
    it(@"returns the same identifier for class when it was registered with same kind", ^{
       
        Class modelClass = [NSNumber class];
        NSString* identifier = [mapping registerViewModelClass:modelClass kind:kind];
        
        expect([mapping identifierForViewModelClass:modelClass kind:kind]).equal(identifier);
    });
    
    it(@"returns nil for class when it was registered with different kind", ^{
        
        Class modelClass = [NSNumber class];
        [mapping registerViewModelClass:modelClass kind:kind];
        
        expect([mapping identifierForViewModelClass:modelClass kind:@"someKind"]).beNil();
    });
    
    it(@"returns different identifier for class when it was registered with different kind", ^{
        
        Class modelClass = [NSNumber class];
        [mapping registerViewModelClass:modelClass kind:kind];
        NSString* identifierSomeKind = [mapping registerViewModelClass:modelClass kind:@"someKind"];
        
        expect([mapping identifierForViewModelClass:modelClass kind:kind]).notTo.equal(identifierSomeKind);
    });
    
    it(@"returns nil if class was not registered with specified kind", ^{
        
        Class modelClass = [NSNumber class];
        expect([mapping identifierForViewModelClass:modelClass kind:kind]).beNil();
    });
    
    it(@"returns nil if class is nil", ^{
        expect([mapping identifierForViewModelClass:nilValue kind:kind]).beNil();
    });
    
    it(@"returns nil if kind is nil", ^{
        expect([mapping identifierForViewModelClass:[NSString class] kind:nilValue]).beNil();
    });
    
    it(@"returns nil if kind and class are nil", ^{
        expect([mapping identifierForViewModelClass:nilValue kind:nilValue]).beNil();
    });
    
    it(@"no assert if class is nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModelClass:nilValue kind:kind];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModelClass:[NSString class] kind:nilValue];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if kind and class are nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModelClass:nilValue kind:nilValue];
        };
        expect(block).notTo.raiseAny();
    });
});



SpecEnd

