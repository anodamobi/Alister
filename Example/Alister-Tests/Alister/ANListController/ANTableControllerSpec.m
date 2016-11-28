//
//  ANTableControllerSpec.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTableControllerFixture.h"
#import "ANTableUpdateConfigurationModel.h"
#import "ANListTableView.h"
#import "ANListController+Interitance.h"

SpecBegin(ANTableControllerFixture)

describe(@"", ^{
    
    __block ANTableControllerFixture* controller = nil;
    __block UITableView* tableView = nil;
    __block NSIndexPath* zeroIndexPath = nil;

    beforeEach(^{
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)
                                                 style:UITableViewStyleGrouped];;
        controller = [[ANTableControllerFixture alloc] initWithTableView:tableView];
        zeroIndexPath = [ANTestHelper zeroIndexPath];
    });
    
    describe(@"controllerWithTableView", ^{
        
        it(@"should not be nil", ^{
            ANTableController* tableController = [ANTableController controllerWithTableView:tableView];
            expect(tableController).notTo.beNil();
        });
        
        it(@"shoud has correct collection view", ^{
            ANTableController* tableController = [ANTableController controllerWithTableView:tableView];
            expect(tableController.tableView).equal(tableView);
        });
    });
    
    describe(@"initWithTableView:", ^{
        
        it(@"should not be nil", ^{
            expect(controller).notTo.beNil();
        });
        
        it(@"shoud has correct collection view", ^{
            expect(controller.tableView).equal(tableView);
        });
    });
    
    describe(@"shouldDisplayHeaderOnEmptySection", ^{
        
        it(@"should display header on empty section by default after controllerWithTableView:", ^{
            ANTableController* tableController = [ANTableController controllerWithTableView:tableView];
            expect(tableController.shouldDisplayHeaderOnEmptySection).to.beTruthy();
        });
        
        it(@"should display header on empty section by default after initWithTableView:", ^{
            expect(controller.shouldDisplayHeaderOnEmptySection).to.beTruthy();
        });
    });
    
    describe(@"shouldDisplayFooterOnEmptySection", ^{
        
        it(@"should display footer on empty section by default after controllerWithTableView:", ^{
            ANTableController* tableController = [ANTableController controllerWithTableView:tableView];
            expect(tableController.shouldDisplayFooterOnEmptySection).to.beTruthy();
        });
        
        it(@"should display footer on empty section by default after initWithTableView:", ^{
            expect(controller.shouldDisplayFooterOnEmptySection).to.beTruthy();
        });
    });
    
    describe(@"updateDefaultUpdateAnimationModel:", ^{
        
        it(@"should set update animation model correctrly", ^{
            ANTableUpdateConfigurationModel* updateModel = [ANTableUpdateConfigurationModel defaultModel];
            [controller updateDefaultUpdateAnimationModel:updateModel];
            ANListTableView* listView = (ANListTableView*)controller.listView;
            expect(listView.configModel).equal(updateModel);
        });
    });
    
    describe(@"tableView:titleForHeaderInSection:", ^{
        
        it(@"should return correct header title", ^{
            NSString* title = [ANTestHelper randomString];
            NSString* kind = [ANTestHelper randomString];
            
            id storage = OCMClassMock([ANStorage class]);
            [OCMStub([storage headerSupplementaryKind]) andReturn:kind];
            [controller attachStorage:storage];
            
            id itemsHandler = OCMClassMock([ANListControllerItemsHandler class]);
            [controller setItemsHandler:itemsHandler];
            
            OCMStub([storage headerModelForSectionIndex:[ANTestHelper zeroIndexPath].section]).andReturn(title);
            OCMStub([controller.itemsHandler supplementaryViewForModel:[OCMArg any]
                                                                  kind:kind
                                                          forIndexPath:nil]).andReturn(nil);
            
            id result = [controller tableView:tableView
                      titleForHeaderInSection:0];
            
            expect(result).equal(title);
        });
    });
    
    describe(@"tableView:titleForFooterInSection:", ^{
        
        it(@"should return correct footer title", ^{
            NSString* footerTitle = [ANTestHelper randomString];
            NSString* kind = [ANTestHelper randomString];
            
            id storage = OCMClassMock([ANStorage class]);
            [OCMStub([storage footerSupplementaryKind]) andReturn:kind];
            [controller attachStorage:storage];
            
            id itemsHandler = OCMClassMock([ANListControllerItemsHandler class]);
            [controller setItemsHandler:itemsHandler];
            
            OCMStub([storage footerModelForSectionIndex:[ANTestHelper zeroIndexPath].section]).andReturn(footerTitle);
            OCMStub([controller.itemsHandler supplementaryViewForModel:[OCMArg any]
                                                                  kind:kind
                                                          forIndexPath:nil]).andReturn(nil);
            
            id result = [controller tableView:tableView
                      titleForFooterInSection:0];
            
            expect(result).equal(footerTitle);
        });
    });
    
    describe(@"tableView:viewForHeaderInSection:", ^{
        
        it(@"will return correct supplementary header view", ^{
            NSInteger sectionIndex = 0;
            UITableViewHeaderFooterView* headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:[ANTestHelper randomString]];
            
            id storage = OCMClassMock([ANStorage class]);
            [controller attachStorage:storage];
            
            id itemsHandler = OCMClassMock([ANListControllerItemsHandler class]);
            [controller setItemsHandler:itemsHandler];
            
            OCMStub([storage headerModelForSectionIndex:[ANTestHelper zeroIndexPath].section]);
            OCMStub([controller.itemsHandler supplementaryViewForModel:[OCMArg any]
                                                                  kind:[OCMArg any]
                                                          forIndexPath:nil]).andReturn(headerView);
            
            id result = [controller tableView:tableView
                       viewForHeaderInSection:sectionIndex];
            
            expect(result).equal(headerView);
        });
    });
    
    describe(@"tableView:viewForFooterInSection:", ^{
        
        NSInteger sectionIndex = 0;
        UITableViewHeaderFooterView* footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:[ANTestHelper randomString]];
        
        id storage = OCMClassMock([ANStorage class]);
        [controller attachStorage:storage];
        
        id itemsHandler = OCMClassMock([ANListControllerItemsHandler class]);
        [controller setItemsHandler:itemsHandler];
        
        OCMStub([storage footerModelForSectionIndex:[ANTestHelper zeroIndexPath].section]);
        OCMStub([controller.itemsHandler supplementaryViewForModel:[OCMArg any]
                                                              kind:[OCMArg any]
                                                      forIndexPath:nil]).andReturn(footerView);
        
        id result = [controller tableView:tableView
                   viewForFooterInSection:sectionIndex];
        
        expect(result).equal(footerView);
    });

    describe(@"tableView:heightForHeaderInSection:", ^{
        
        it(@"should return correct header height", ^{
            CGFloat headerHeight = 100;
            controller.tableView.sectionHeaderHeight = headerHeight;
            
            UIView* headerModel = [UIView new];
            NSString* kind = [ANTestHelper randomString];
            
            id storage = OCMClassMock([ANStorage class]);
            [OCMStub([storage headerSupplementaryKind]) andReturn:kind];
            [controller attachStorage:storage];
            
            id itemsHandler = OCMClassMock([ANListControllerItemsHandler class]);
            [controller setItemsHandler:itemsHandler];
            
            OCMStub([storage headerModelForSectionIndex:[ANTestHelper zeroIndexPath].section]).andReturn(headerModel);
            OCMStub([controller.itemsHandler supplementaryViewForModel:[OCMArg any]
                                                                  kind:kind
                                                          forIndexPath:nil]).andReturn(nil);
            
            CGFloat result = [controller tableView:tableView
                      heightForHeaderInSection:0];
            
            expect(result).equal(headerHeight);
        });
    });

    describe(@"tableView:heightForFooterInSection:", ^{
        
        it(@"should return correct footer height", ^{
            CGFloat footerHeight = 50;
            controller.tableView.sectionFooterHeight = footerHeight;
            
            UIView* footerModel = [UIView new];
            NSString* kind = [ANTestHelper randomString];
            
            id storage = OCMClassMock([ANStorage class]);
            [OCMStub([storage footerSupplementaryKind]) andReturn:kind];
            [controller attachStorage:storage];
            
            id itemsHandler = OCMClassMock([ANListControllerItemsHandler class]);
            [controller setItemsHandler:itemsHandler];
            
            OCMStub([storage footerModelForSectionIndex:[ANTestHelper zeroIndexPath].section]).andReturn(footerModel);
            OCMStub([controller.itemsHandler supplementaryViewForModel:[OCMArg any]
                                                                  kind:kind
                                                          forIndexPath:nil]).andReturn(nil);
            
            CGFloat result = [controller tableView:tableView
                          heightForFooterInSection:0];
            
            expect(result).equal(footerHeight);
        });
    });

    
//    describe(@"numberOfSectionsInTableView:", ^{
//        failure(@"Pending");
//    });
//    
//    describe(@"tableView:numberOfRowsInSection:", ^{
//        failure(@"Pending");
//    });
//    
//    describe(@"tableView:cellForRowAtIndexPath:", ^{
//        failure(@"Pending");
//    });
//
//    describe(@"tableView:didSelectRowAtIndexPath:", ^{
//        failure(@"Pending");
//    });
//    
//    describe(@"tableView:moveRowAtIndexPath:toIndexPath:", ^{
//        failure(@"Pending");
//    });
});

SpecEnd






