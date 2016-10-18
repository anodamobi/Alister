//
//  ANStorageUpdateOperationSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageUpdateOperation.h>
#import <Alister/ANStorageUpdateModel.h>
#import "ANStorageOperationFakeDelegate.h"

@interface ANStorageUpdateOperation ()

@property (nonatomic, strong) NSMutableArray* updates;
@property (nonatomic, copy) ANStorageUpdateOperationConfigurationBlock configurationBlock;

- (ANStorageUpdateModel*)_mergeUpdates;

@end

SpecBegin(ANStorageUpdateOperation)

__block ANStorageUpdateOperation* op = nil;

describe(@"default values", ^{
    
    it(@"configuration block is not nil when created with it", ^{
        op = [ANStorageUpdateOperation operationWithConfigurationBlock:^(ANStorageUpdateOperation* __unused operation) {
            
        }];
        expect(op.configurationBlock).notTo.beNil();
    });
    
    it(@"conforms to protocol", ^{
        op = [ANStorageUpdateOperation operationWithConfigurationBlock:nil];
        expect(op).conformTo(@protocol(ANStorageUpdateOperationInterface));
    });
    
    it(@"updates array not nil when created", ^{
        op = [ANStorageUpdateOperation operationWithConfigurationBlock:nil];
        expect(op.updates).notTo.beNil();
    });
    
    it(@"no assert if block is nil", ^{
        void(^block)() = ^() {
            [ANStorageUpdateOperation operationWithConfigurationBlock:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"not nil when created", ^{
        op = [ANStorageUpdateOperation operationWithConfigurationBlock:nil];
        expect(op).notTo.beNil();
    });
});



describe(@"collectUpdate:", ^{
    
    __block ANStorageUpdateModel* update = nil;
    
    beforeEach(^{
        op = [ANStorageUpdateOperation operationWithConfigurationBlock:nil];
    });
    
    it(@"updates array updated if update not empty", ^{
        update = [ANStorageUpdateModel new];
        [update addDeletedSectionIndex:1];
        [op collectUpdate:update];
        
        expect(op.updates).haveCount(1);
        expect(op.updates).contain(update);
    });
    
    it(@"no assert if update is nil", ^{
        void(^block)() = ^() {
            [op collectUpdate:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"update not collected if its nil", ^{
        [op collectUpdate:nil];
        expect(op.updates).haveCount(0);
    });
    
    it(@"update not collected if its empty", ^{
        update = [ANStorageUpdateModel new];
        [op collectUpdate:update];
        
        expect(op.updates).haveCount(0);
    });
});


describe(@"set updaterDelegate", ^{
    
    beforeEach(^{
        op = [ANStorageUpdateOperation operationWithConfigurationBlock:nil];
    });
    
    it(@"no assert if set nil", ^{
        void(^block)() = ^() {
            op.updaterDelegate = nil;
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"assert if delegate doesn't conform to protocol", ^{
        void(^block)() = ^() {
            op.updaterDelegate = (id)[NSObject new];
        };
        expect(block).to.raiseAny();
    });
    
    it(@"delegate set successfully", ^{
        id fakeDelegate = [ANStorageOperationFakeDelegate new];
        op.updaterDelegate = fakeDelegate;
        
        expect(op.updaterDelegate).equal(fakeDelegate);
    });
});


describe(@"controllerOperationDelegate", ^{
    
    beforeEach(^{
        op = [ANStorageUpdateOperation operationWithConfigurationBlock:nil];
    });
    
    it(@"no assert if set nil", ^{
        void(^block)() = ^() {
            op.controllerOperationDelegate = nil;
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"assert if delegate doesn't confirm to protocol", ^{
        void(^block)() = ^() {
            op.controllerOperationDelegate = (id)[NSObject new];
        };
        expect(block).to.raiseAny();
    });
    
    it(@"delegate set successfully", ^{
        id fakeDelegate = [ANStorageOperationFakeDelegate new];
        op.controllerOperationDelegate = fakeDelegate;
        
        expect(op.controllerOperationDelegate).equal(fakeDelegate);
    });
});


describe(@"main", ^{
    
    __block ANStorageUpdateOperationConfigurationBlock block = nil;
    
    beforeEach(^{
        block = ^(ANStorageUpdateOperation* __unused operation) {
            
        };
        op = [ANStorageUpdateOperation operationWithConfigurationBlock:block];
    });
    
    it(@"if configuration block is not nil it will execute", ^{
        
        waitUntil(^(void (^done)(void)) {
            
            block = ^(ANStorageUpdateOperation* __unused operation) {
                done();
            };
            op = [ANStorageUpdateOperation operationWithConfigurationBlock:block];
            [op main];
        });
    });
    
    it(@"if any of models requires update will call updateStorageOperationRequiresForceReload", ^{
        
        ANStorageUpdateModel* update1 = [ANStorageUpdateModel new];
        ANStorageUpdateModel* update2 = [ANStorageUpdateModel new];
        update2.isRequireReload = YES;
    
        [op collectUpdate:update1];
        [op collectUpdate:update2];
        
        OCMVerify([op.updaterDelegate updateStorageOperationRequiresForceReload:[OCMArg any]]);
    });
    
    it(@"if no model requires update will call storageUpdateModelGenerated", ^{
        ANStorageUpdateModel* update1 = [ANStorageUpdateModel new];
        [update1 addDeletedSectionIndex:1];
        
        ANStorageUpdateModel* update2 = [ANStorageUpdateModel new];
        [update2 addInsertedIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        update2.isRequireReload = YES;
        
        [op collectUpdate:update1];
        [op collectUpdate:update2];
        
        OCMVerify([op.controllerOperationDelegate storageUpdateModelGenerated:[OCMArg any]]);
    });
});

SpecEnd
