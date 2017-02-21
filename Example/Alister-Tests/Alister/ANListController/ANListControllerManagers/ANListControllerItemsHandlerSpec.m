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
#import "ANListCellFixture.h"
#import "Alister.h"

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
       
        it(@"will register mapping for model class", ^{
            [handler registerCellClass:viewClass forModelClass:modelClass];
            OCMVerify([mappingService registerViewModelClass:modelClass]);
        });
        
        it(@"will call register on listView", ^{
            
            [OCMStub([mappingService registerViewModelClass:[OCMArg any]]) andReturn:mappingIdentifier];
            [handler registerCellClass:viewClass forModelClass:modelClass];
            
            expect(listView.lastIdentifier).equal(mappingIdentifier);
            expect(listView.lastCellClass).equal(viewClass);
            expect(listView.wasRegisterCalled).beTruthy();
        });
        
        it(@"will not register if identifier is nil", ^{ //TODO: check does we need this nil check, or better to move it as assert inside anlistview?
            
            [OCMStub([mappingService registerViewModelClass:[OCMArg any]]) andReturn:nil];
            [handler registerCellClass:viewClass forModelClass:modelClass];
            
            expect(listView.wasRegisterCalled).beFalsy();
        });
    });
});


describe(@"retirive views", ^{

    __block id model = nil;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    beforeEach(^{
        model = [ANTestHelper randomObject];
    });
    
    describe(@"cellForModel: atIndexPath:", ^{
        
        it(@"will retrieve registered identifier", ^{
            [OCMStub([mappingService identifierForViewModelClass:[OCMArg any]]) andReturn:[ANTestHelper randomString]];
            
            [handler cellForModel:model atIndexPath:indexPath];
            OCMVerify([mappingService identifierForViewModelClass:[model class]]);
        });
        
        it(@"will retrieve cell from listView", ^{
            NSString* identifier = [ANTestHelper randomString];
            [OCMStub([mappingService identifierForViewModelClass:[OCMArg any]]) andReturn:identifier];
            [handler cellForModel:model atIndexPath:indexPath];
            
            expect(listView.lastIndexPath).equal(indexPath);
            expect(listView.lastIdentifier).equal(identifier);
            expect(listView.wasRetriveCalled).beTruthy();
        });
        
        it(@"will update retrived cell with model", ^{
            
            [OCMStub([mappingService identifierForViewModelClass:[OCMArg any]]) andReturn:[ANTestHelper randomString]];
            ANListCellFixture* cell = [ANListCellFixture new];
            listView.cell = cell;
            [handler cellForModel:model atIndexPath:indexPath];
            
            expect(cell.wasUpdateCalled).beTruthy();
        });
        
        it(@"cell will not be nil nothing was returned from list view", ^{
            id cell = [handler cellForModel:model atIndexPath:indexPath];
            expect(cell).notTo.beNil();
        });
    });
    
    
    describe(@"supplementaryViewForModel: kind: forIndexPath:", ^{
        
        __block NSString* kind = nil;
        
        beforeEach(^{
            kind = [ANTestHelper randomString];
        });
        
        it(@"will retrieve registered identifier", ^{ //TODO: remove after disable asserts
            [OCMStub([mappingService identifierForViewModelClass:[model class] kind:kind]) andReturn:[ANTestHelper randomString]];
            
            [handler supplementaryViewForModel:model kind:kind forIndexPath:indexPath];
            OCMVerify([mappingService identifierForViewModelClass:[model class] kind:kind]);
        });
        
        it(@"will retrieve supplementary from listView", ^{
            
            NSString* identifier = [ANTestHelper randomString];
            [OCMStub([mappingService identifierForViewModelClass:[model class] kind:kind]) andReturn:identifier];
            [handler supplementaryViewForModel:model kind:kind forIndexPath:indexPath];
            
            expect(listView.lastIndexPath).equal(indexPath);
            expect(listView.lastIdentifier).equal(identifier);
            expect(listView.lastKind).equal(kind);
            expect(listView.wasRetriveCalled).beTruthy();
        });
        
        it(@"will update retrived supplementary with model", ^{
            ANListCellFixture* supplementary = [ANListCellFixture new];
            listView.supplementary = supplementary;
            NSString* identifier = [ANTestHelper randomString];
            [OCMStub([mappingService identifierForViewModelClass:[model class] kind:kind]) andReturn:identifier];
            [handler supplementaryViewForModel:model kind:kind forIndexPath:indexPath];
            
            expect(supplementary.wasUpdateCalled).beTruthy();
        });
        
        it(@"supplementary will not be nil nothing was returned from list view", ^{
            id cell = [handler supplementaryViewForModel:model kind:kind forIndexPath:indexPath];
            expect(cell).notTo.beNil();
        });
    });
});

SpecEnd
