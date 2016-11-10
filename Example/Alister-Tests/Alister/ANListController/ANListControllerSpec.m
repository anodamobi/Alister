//
//  ANListControllerSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/5/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerFixture.h"
#import "ANListController+Interitance.h"

SpecBegin()

__block ANListControllerFixture* controller = nil;

beforeEach(^{
    controller = [ANListControllerFixture new];
});

describe(@"at default state", ^{
    
    it(@"storage will be nil", ^{
        expect(controller.currentStorage).beNil();
    });
});


describe(@"initWithListView:", ^{
    
    it(@"no assert if view is nil", ^{
        
    });
});

describe(@"attachStorage:", ^{
    
    __block ANStorage* storage = nil;
    
    beforeEach(^{
        storage = [ANStorage new];
    });
    
    it(@"no assert if storage is nil", ^{
        void(^block)() = ^() {
            [controller attachStorage:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"prevoius storage will reset if new is nil", ^{
        [controller attachStorage:storage];
        [controller attachStorage:nil];
    
        expect(controller.currentStorage).beNil();
    });
    
    it(@"attached storage will become current storage", ^{
        [controller attachStorage:storage];
        expect(controller.currentStorage).equal(storage);
    });
    
    it(@"storage will have update delegates after assign", ^{
        [controller attachStorage:storage];
        expect(controller.currentStorage.updatesHandler).notTo.beNil();
    });
    
    it(@"after attach storage must be reloaded", ^{
        ANStorage* storageMock = OCMClassMock([ANStorage class]);
        OCMExpect([storageMock reloadStorageWithAnimation:(BOOL)[OCMArg any]]);
        [controller attachStorage:storageMock];
        
        OCMVerify(storageMock);
    });
});


describe(@"attachSearchBar:", ^{
    
});

SpecEnd
