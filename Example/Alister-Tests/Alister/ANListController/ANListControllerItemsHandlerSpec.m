//
//  ANListControllerItemsHandlerSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerItemsHandler.h"
#import "ANListViewFixture.h"
#import "ANListControllerMappingServiceFixture.h"


SpecBegin(ANListControllerItemsHandler)

__block ANListControllerItemsHandler* handler = nil;
__block ANListViewFixture* listView = nil;
__block id<ANListControllerMappingServiceInterface> mappingService = nil;

beforeEach(^{
    listView = [ANListViewFixture new];
    mappingService = OCMProtocolMock(@protocol(ANListControllerMappingServiceInterface));
    handler = [[ANListControllerItemsHandler alloc] initWithListView:listView
                                                      mappingService:mappingService];
});

afterEach(^{
    [(id)mappingService stopMocking];
});


describe(@"initWithListView: mappingService:", ^{
    
    it(@"listView match", ^{
        expect(handler.listView).equal(listView);
    });
    
    it(@"mappingService match", ^{
        expect(handler.mappingService).equal(mappingService);
    });
});

describe(@"methods ANListControllerReusableInterface", ^{
    __block Class modelClass = nil;
    __block Class viewClass = nil;
    __block NSString* kind = nil;
    __block NSString* mappingIdentifier = nil;
    
    beforeEach(^{
        modelClass = [ANTestHelper randomClass];
        viewClass = [ANTestHelper randomClass];
        kind = [ANTestHelper randomString];
        mappingIdentifier = [ANTestHelper randomString];
    });

    
    describe(@"registerFooterClass: forModelClass:", ^{
        
        it(@"will register mapping for model class with specified kind", ^{
            [handler registerFooterClass:viewClass forModelClass:modelClass];
            OCMVerify([mappingService registerViewModelClass:modelClass kind:[listView footerDefaultKind]]);
        });
        
        it(@"will call register on listView", ^{
            
            [OCMStub([mappingService registerViewModelClass:[OCMArg any] kind:[OCMArg any]]) andReturn:mappingIdentifier];
            [handler registerFooterClass:viewClass forModelClass:modelClass];
            
            expect(listView.lastIdentifier).equal(mappingIdentifier);
            expect(listView.lastCellClass).equal(viewClass);
            expect(listView.wasRegisterCalled).beTruthy();
            
        });
        
        it(@"will not register if identifier is nil", ^{ //TODO: check does we need this nil check, or better to move it as assert inside anlistview?
            
            [OCMStub([mappingService registerViewModelClass:[OCMArg any] kind:[OCMArg any]]) andReturn:nil];
            [handler registerFooterClass:viewClass forModelClass:modelClass];
            
            expect(listView.wasRegisterCalled).beFalsy();
        });
    });
    
    
    describe(@"registerHeaderClass: forModelClass:", ^{
        
        it(@"will register mapping for model class with specified kind", ^{
            [handler registerHeaderClass:viewClass forModelClass:modelClass];
            OCMVerify([mappingService registerViewModelClass:modelClass kind:[listView headerDefaultKind]]);
        });
        
        it(@"will call register on listView", ^{
            
            [OCMStub([mappingService registerViewModelClass:[OCMArg any] kind:[OCMArg any]]) andReturn:mappingIdentifier];
            [handler registerHeaderClass:viewClass forModelClass:modelClass];
            
            expect(listView.lastIdentifier).equal(mappingIdentifier);
            expect(listView.lastCellClass).equal(viewClass);
            expect(listView.wasRegisterCalled).beTruthy();
            
        });
        
        it(@"will not register if identifier is nil", ^{ //TODO: check does we need this nil check, or better to move it as assert inside anlistview?
            
            [OCMStub([mappingService registerViewModelClass:[OCMArg any] kind:[OCMArg any]]) andReturn:nil];
            [handler registerHeaderClass:viewClass forModelClass:modelClass];
            
            expect(listView.wasRegisterCalled).beFalsy();
        });
    });
    
    
    describe(@"registerSupplementaryClass: forModelClass: kind:", ^{
        
        it(@"will register mapping for model class", ^{
            [handler registerSupplementaryClass:viewClass forModelClass:modelClass kind:kind];
            OCMVerify([mappingService registerViewModelClass:modelClass kind:kind]);
        });
        
        it(@"will call register on listView", ^{
            
            [OCMStub([mappingService registerViewModelClass:[OCMArg any] kind:[OCMArg any]]) andReturn:mappingIdentifier];
            [handler registerSupplementaryClass:viewClass forModelClass:modelClass kind:kind];
            
            expect(listView.lastIdentifier).equal(mappingIdentifier);
            expect(listView.lastCellClass).equal(viewClass);
            expect(listView.lastKind).equal(kind);
            expect(listView.wasRegisterCalled).beTruthy();
            
        });
        
        it(@"will not register if identifier is nil", ^{ //TODO: check does we need this nil check, or better to move it as assert inside anlistview?
            
            [OCMStub([mappingService registerViewModelClass:[OCMArg any] kind:[OCMArg any]]) andReturn:nil];
            [handler registerSupplementaryClass:viewClass forModelClass:modelClass kind:kind];
            
            expect(listView.wasRegisterCalled).beFalsy();
        });
    });
    
    describe(@"registerCellClass: forModelClass:", ^{
       pending(@"Pending");
    });
});





//- (nullable id<ANListControllerUpdateViewInterface>)cellForModel:(id)viewModel atIndexPath:(NSIndexPath*)indexPath;
//
//- (nullable id<ANListControllerUpdateViewInterface>)supplementaryViewForModel:(id)viewModel
//kind:(NSString*)kind
//forIndexPath:(nullable NSIndexPath*)indexPath;

SpecEnd
