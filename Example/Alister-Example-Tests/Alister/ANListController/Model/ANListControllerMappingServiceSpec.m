//
//  ANListControllerMappingServiceSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/27/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANListControllerMappingService.h>
#import "ANMappingFixture.h"

SpecBegin(ANListControllerMappingService)

__block ANListControllerMappingService* mapping = nil;

beforeEach(^{
    mapping = [ANListControllerMappingService new];
});

describe(@"registerIdentifierForViewModel:", ^{
    
    it(@"will provide identifier for class", ^{
        NSString* viewModel = @"testViewModel";
        NSString* result1 = [mapping identifierForViewModel:[viewModel class]];
        
        expect(result1).notTo.beNil();
    });
    
    it(@"no assert if class is nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModel:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"identifier will be nil if class is nil", ^{
        NSString* identifier = [mapping identifierForViewModel:nil];
        expect(identifier).beNil();
    });
});

describe(@"identifierForViewModel: kind:", ^{
    
});

describe(@"identifierForViewModel:", ^{
    
    it(@"if model is not registered will try to find parent registered class", ^{
        
        id viewModel1 = @"test";
        Class viewModelAnotherClass = [NSString class];
        
        NSString* result1 = [mapping identifierForViewModel:viewModelAnotherClass];
        NSString* result2 = [mapping identifierForViewModel:[viewModel1 class]];
        
        expect(result1).equal(result2);
        expect(result2).notTo.beNil();
    });
    
    it(@"no assert if viewModel is nil", ^{
        void(^block)() = ^() {
            [mapping identifierForViewModel:nil];
        };
        expect(block).notTo.raiseAny();
    });
});



//describe(@"mappingForViewModelClass: kind: isSystem:", ^{
//    
//    it(@"successfully created mapping for system class", ^{
//        
//        Class viewModelClass = [NSString class];
//        NSString* kind = @"testKind";
//        BOOL isSystem = YES;
//        
//        ANListControllerMappingModel* model = [mapping mappingForViewModelClass:viewModelClass kind:kind isSystem:isSystem];
//        
//        expect(model.isSystem).equal(isSystem);
//        expect(model.kind).equal(kind);
//        expect(model.mappingClass).equal(viewModelClass);
//        expect(model.reuseIdentifier).notTo.beNil();
//    });
//    
//    it(@"successfully created mapping for custom class", ^{
//        
//        Class viewModelClass = [ANMappingFixture class];
//        NSString* kind = @"testKind";
//        BOOL isSystem = NO;
//        
//        ANListControllerMappingModel* model = [mapping mappingForViewModelClass:viewModelClass
//                                                                           kind:kind
//                                                                       isSystem:isSystem];
//        
//        expect(model.isSystem).equal(isSystem);
//        expect(model.kind).equal(kind);
//        expect(model.mappingClass).equal(viewModelClass);
//        expect(model.reuseIdentifier).notTo.beNil();
//    });
//    
//    it(@"if mapping exist for this ViewModelClass it will be retrived", ^{
//        //TODO:
//    });
//    
//    it(@"if viewModelClass is nil mapping will be nil", ^{
//        ANListControllerMappingModel* model = [mapping mappingForViewModelClass:nil kind:@"any" isSystem:YES];
//        expect(model).beNil();
//    });
//    
//    it(@"if kind is nil mapping will be nil", ^{
//        ANListControllerMappingModel* model = [mapping mappingForViewModelClass:[NSString class] kind:nil isSystem:YES];
//        expect(model).beNil();
//    });
//    
//    it(@"no assert if kind is nil", ^{
//        void(^block)() = ^() {
//            [mapping mappingForViewModelClass:[NSString class] kind:nil isSystem:YES];
//        };
//        expect(block).notTo.raiseAny();
//    });
//    
//    it(@"no assert if viewModel class is nil", ^{
//        void(^block)() = ^() {
//            [mapping mappingForViewModelClass:nil kind:@"test" isSystem:NO];
//        };
//        expect(block).notTo.raiseAny();
//    });
//});
//
//
//describe(@"cellMappingForViewModelClass: isSystem:", ^{
//    
//    
//});
//
//
//describe(@"addMapping:", ^{
//    
//    it(@"successfully adds mapping", ^{
//        
//        ANListControllerMappingModel* model = [ANListControllerMappingModel new];
////        model
//        failure(@"Pending");
//    });
//    
//    it(@"no assert if maping is nil", ^{
//        void(^block)() = ^() {
//            [mapping addMapping:nil];
//        };
//        expect(block).notTo.raiseAny();
//    });
//});
//
//
//describe(@"findCellMappingForViewModel:", ^{
//    
//    
//});
//
//
//describe(@"findSupplementaryMappingForViewModel: kind:", ^{
//    
//    
//});

SpecEnd

//- (ANListControllerMappingModel*)mappingForViewModelClass:(Class)viewModelClass
//kind:(NSString*)kind
//isSystem:(BOOL)isSystem;
//
//- (ANListControllerMappingModel*)cellMappingForViewModelClass:(Class)viewModelClass isSystem:(BOOL)isSystem;
//
//- (void)addMapping:(ANListControllerMappingModel*)model;
//
//- (ANListControllerMappingModel*)findCellMappingForViewModel:(id)viewModel;
//- (ANListControllerMappingModel*)findSupplementaryMappingForViewModel:(id)viewModel kind:(NSString*)kind;
//

