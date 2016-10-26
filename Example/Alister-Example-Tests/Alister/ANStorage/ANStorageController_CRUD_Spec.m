//
//  ANStorageControllerTest.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/2/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageSectionModel.h>
#import <Alister/ANStorageController.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageUpdateModel.h>

SpecBegin(ANStorageController_CRUD_Test)

__block ANStorageController* controller = nil;
__block OCMockObject <ANStorageUpdateOperationInterface>* delegate = nil;

beforeEach(^{
    controller = [ANStorageController new];
    delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
    controller.updateDelegate = delegate;
});

afterEach(^{
    [(OCMockObject*)delegate stopMocking];
});

describe(@"default state", ^{
    
    it(@"should have storageModel", ^{
        expect(controller.storageModel).notTo.beNil();
    });
    
    it(@"should have no sections", ^{
        expect(controller.sections).haveCount(0);
    });
});


describe(@"set delegate", ^{
    
    it(@"no assert if set nil", ^{
        void(^block)() = ^() {
            controller.updateDelegate = nil;
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"assert if delegate doesn't confirm to protocol", ^{
        void(^block)() = ^() {
            controller.updateDelegate = (id)[NSObject new];
        };
        expect(block).to.raiseAny();
    });
    
    it(@"delegate set successfully", ^{
        controller.updateDelegate = delegate;
        expect(controller.updateDelegate).equal(delegate);
    });
});


//describe(@"adding items to storage", ^{
//    
//    beforeEach(^{
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//    });
//    
//    
//    it(@"addItem: generated update was send to delegate", ^{
//        NSString* item = @"test";
//        [controller addItem:item];
//        
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//    
//    it(@"addItems: generated update was send to delegate", ^{
//        [controller addItems:@[@"test0", @"test1", @"test2"]];
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//    
//    it(@"addItem: toSection: generated update was send to delegate", ^{
//        NSString* item = @"test";
//        [controller addItem:item toSection:0];
//        
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//    
//    it(@"generated update was send to delegate addItems: toSection:", ^{
//        NSArray* testModel = @[@"test0", @"test1", @"test2"];
//        [controller addItems:testModel toSection:3];
//        
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//    
//    it(@"addItem: atIndexPath: generated update was send to delegate", ^{
//        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [controller addItem:@"test" atIndexPath:indexPath];
//        
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//});
//
//
//describe(@"reloadItem:", ^{
//    
//    beforeEach(^{
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//    });
//    
//    it(@"generated update was send to delegatel", ^{
//        [controller reloadItem:@"test"];
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//});
//
//
//describe(@"removeItem:", ^{
//    
//    it(@"generated update was send to delegate", ^{
//        NSString* item = @"test";
//        [controller addItem:item];
//        
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//        [controller removeItem:item];
//        
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//});
//
//
//describe(@"removeItemsAtIndexPaths:", ^{
//    
//    it(@"generated update was send to delegate", ^{
//        NSString* item = @"test";
//        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [controller addItem:item atIndexPath:indexPath];
//        
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//        
//        [controller removeItemsAtIndexPaths:@[indexPath]];
//        
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//});
//
//describe(@"removeItems:", ^{
//    
//    it(@"generated update was send to delegate", ^{
//        NSString* item = @"test";
//        [controller addItems:@[item, @"test2"]];
//        
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//        [controller removeItem:item];
//        
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//});
//
//
//describe(@"removeAllItemsAndSections", ^{
//    
//    it(@"generated update was send to delegate", ^{
//        [controller addItem:@"test"];
//        [controller addItem:@"test2" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
//        
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//        
//        [controller removeAllItemsAndSections];
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//});
//
//
//describe(@"removeSections:", ^{
//    
//    it(@"generated update was send to delegate", ^{
//        NSArray* items = @[@"test1", @"test2", @"test3"];
//        
//        [controller addItems:items toSection:0];
//        
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//        
//        [controller removeSections:[NSIndexSet indexSetWithIndex:0]];
//        
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//});
//
//
//describe(@"replaceItem:withItem:", ^{
//    
//    it(@"generated update was send to delegate", ^{
//        NSString* testModel = @"test0";
//        NSString* testModel1 = @"test1";
//        
//        [controller addItem:testModel toSection:0];
//        
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//        
//        [controller replaceItem:testModel withItem:testModel1];
//        
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//});
//
//
//describe(@"moveItemWithoutUpdateFromIndexPath: toIndexPath:", ^{
//    
//    it(@"generated update was NOT send to delegate", ^{
//        
//        [controller addItem:@"test"];
//        NSIndexPath* fromIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        NSIndexPath* toIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//        
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//        
//        [controller moveItemWithoutUpdateFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
//        OCMVerify([delegate collectUpdate:[OCMArg isNil]]);
//    });
//});
//
//
//describe(@"moveItemFromIndexPath: toIndexPath:", ^{
//    
//    it(@"generated update was send to delegate", ^{
//        
//        [controller addItem:@"test"];
//        NSIndexPath* fromIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        NSIndexPath* toIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//        
//        delegate = OCMProtocolMock(@protocol(ANStorageUpdateOperationInterface));
//        controller.updateDelegate = delegate;
//        
//        [controller moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
//        OCMVerify([delegate collectUpdate:[OCMArg isKindOfClass:[ANStorageUpdateModel class]]]);
//    });
//});


describe(@"sections", ^{
    
    it(@"should have correct number of sections", ^{
        expect(controller).respondTo(@selector(sections));
    });
});


describe(@"sectionAtIndex:", ^{

    it(@"responds to selector", ^{
        expect(controller).respondTo(@selector(sectionAtIndex:));
    });
});


describe(@"itemsInSection:", ^{

    it(@"responds to selector", ^{
        expect(controller).respondTo(@selector(itemsInSection:));
    });
});


describe(@"indexPathForItem:", ^{

    it(@"responds to selector", ^{
        expect(controller).respondTo(@selector(indexPathForItem:));
    });
});


describe(@"isEmpty", ^{

    it(@"responds to selector", ^{
        expect(controller).respondTo(@selector(isEmpty));
    });
});

SpecEnd
