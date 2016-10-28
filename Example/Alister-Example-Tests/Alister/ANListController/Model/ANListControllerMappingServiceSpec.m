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
__block NSString* kind = nil;


beforeEach(^{
    mapping = [ANListControllerMappingService new];
    kind = @"kind";
});


describe(@"registerViewModelClass:", ^{
    
    it(@"returns identifier if class not nil", ^{
        NSString* result = [mapping registerViewModelClass:[NSString class]];
        expect(result).notTo.beNil();
    });
    
    it(@"returns nill if class is nil", ^{
        NSString* result = [mapping registerViewModelClass:kANTestNil];
        expect(result).beNil();
    });
    
    it(@"no assert if class is nil", ^{
        void(^block)() = ^() {
            [mapping registerViewModelClass:kANTestNil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"registerViewModelClass: kind:", ^{
    
    it(@"returns identifier if class and kind is not nil", ^{
        NSString* result = [mapping registerViewModelClass:[NSString class] kind:kind];
        expect(result).notTo.beNil();
    });
    
    it(@"returns nil if class is nil", ^{
        NSString* result = [mapping registerViewModelClass:kANTestNil kind:kind];
        expect(result).beNil();
    });
    
    it(@"returns nil if kind is nil", ^{
        NSString* result = [mapping registerViewModelClass:[NSString class] kind:kANTestNil];
        expect(result).beNil();
    });
    
    it(@"no assert if class is nil", ^{
        void(^block)() = ^() {
            [mapping registerViewModelClass:kANTestNil kind:kind];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [mapping registerViewModelClass:[NSString class] kind:kANTestNil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if kind and class are nil", ^{
        void(^block)() = ^() {
            [mapping registerViewModelClass:kANTestNil kind:kANTestNil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"identifierForViewModelClass:", ^{
    
    it(@"will provide identifier for registered for class", ^{
       
        [mapping registerViewModelClass:[NSString class]];
        NSString* result = [mapping identifierForViewModelClass:[NSString class]];
        
        expect(result).notTo.beNil();
    });
    
    it(@"will return nil if class is not registered", ^{
       
        NSString* result = [mapping identifierForViewModelClass:[NSString class]];
        expect(result).beNil();
    });
    
    it(@"no assert if class is nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModelClass:kANTestNil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"identifier will be nil if class is nil", ^{
        NSString* identifier = [mapping identifierForViewModelClass:kANTestNil];
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
    
    it(@"returns the same identifier for class when it was registered with same kind", ^{
       
        Class modelClass = [NSNumber class];
        NSString* registered = [mapping registerViewModelClass:modelClass kind:kind];
        NSString* result = [mapping identifierForViewModelClass:modelClass kind:kind];
        expect(result).equal(registered);
    });
    
    it(@"returns nil for class when it was registered with different kind", ^{
        
        Class modelClass = [NSNumber class];
        [mapping registerViewModelClass:modelClass kind:kind];
        NSString* result = [mapping identifierForViewModelClass:modelClass kind:@"someKind"];
        
        expect(result).beNil();
    });
    
    it(@"returns different identifier for class when it was registered with different kind", ^{
        
        Class modelClass = [NSNumber class];
        [mapping registerViewModelClass:modelClass kind:kind];
        NSString* identifierSomeKind = [mapping registerViewModelClass:modelClass kind:@"someKind"];
        
        NSString* result = [mapping identifierForViewModelClass:modelClass kind:kind];
        
        expect(result).notTo.equal(identifierSomeKind);
    });
    
    it(@"returns nil if class was not registered with specified kind", ^{
        
        NSString* result = [mapping identifierForViewModelClass:[NSString class] kind:kind];
        expect(result).beNil();
    });
    
    it(@"returns nil if class is nil", ^{
        NSString* result = [mapping identifierForViewModelClass:kANTestNil kind:kind];
        expect(result).beNil();
    });
    
    it(@"returns nil if kind is nil", ^{
        NSString* result = [mapping identifierForViewModelClass:[NSString class] kind:kANTestNil];
        expect(result).beNil();
    });
    
    it(@"returns nil if kind and class are nil", ^{
        NSString* result = [mapping identifierForViewModelClass:kANTestNil kind:kANTestNil];
        expect(result).beNil();
    });
    
    it(@"no assert if class is nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModelClass:kANTestNil kind:kind];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModelClass:[NSString class] kind:kANTestNil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if kind and class are nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModelClass:kANTestNil kind:kANTestNil];
        };
        expect(block).notTo.raiseAny();
    });
});

SpecEnd
