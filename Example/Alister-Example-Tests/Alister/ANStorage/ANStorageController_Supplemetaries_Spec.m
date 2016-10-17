//
//  ANStorageController_Supplemetaries.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageSectionModel.h>
#import <Alister/ANStorageController.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageUpdateModel.h>

SpecBegin(ANStorageController_SupplemetariesTest)

__block ANStorageController* controller = nil;
__block OCMockObject <ANStorageUpdateOperationInterface>* delegate = nil;

beforeEach(^{
    controller = [ANStorageController new];
    delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
    controller.updateDelegate = delegate;
});

describe(@"updateSupplementaryHeaderKind:", ^{
    
    it(@"should match stogeModel value after update", ^{
        NSString* item = @"test";
        [controller updateSupplementaryHeaderKind:item];
        
        expect(controller.storageModel.headerKind).equal(item);
    });
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [controller updateSupplementaryHeaderKind:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"updateSupplementaryFooterKind:", ^{
    
    it(@"should match stogeModel value after update", ^{
        NSString* item = @"test";
        [controller updateSupplementaryFooterKind:item];
        
        expect(controller.storageModel.footerKind).equal(item);
    });
    
    it(@"no assert if kind is nil", ^{
        void(^block)() = ^() {
            [controller updateSupplementaryFooterKind:nil];
        };
        expect(block).notTo.raiseAny();
    });
});


describe(@"updateSupplementaryFooterKind:", ^{
    
    it(@"should match storageModel value", ^{
        [controller updateSupplementaryFooterKind:@"test"];
        expect(controller.storageModel.headerKind).equal(controller.storageModel.headerKind);
    });
});


describe(@"footerModelForSectionIndex:", ^{
    
    it(@"should match storageModel value", ^{
        [controller updateSupplementaryFooterKind:@"test"];
        expect(controller.storageModel.footerKind).equal(controller.storageModel.footerKind);
    });
});


describe(@"updateSectionHeaderModel: forSectionIndex:", ^{

    [controller updateSectionHeaderModel:@"test" forSectionIndex:0];
    OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
});


describe(@"updateSectionFooterModel: forSectionIndex:", ^{
    
    [controller updateSectionFooterModel:@"test" forSectionIndex:0];
    OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
});


describe(@"supplementaryModelOfKind: forSectionIndex:", ^{
    
    it(@"responds to selector", ^{
        expect(controller).respondTo(@selector(supplementaryModelOfKind:forSectionIndex:));
    });
});

SpecEnd
