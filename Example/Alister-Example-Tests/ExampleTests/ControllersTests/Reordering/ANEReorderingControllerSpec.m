//
//  ANEReorderingControllerSpec.m
//  Alister-Example
//
//  Created by ANODA on 10/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEReorderingController.h"

SpecBegin(ANEReorderingControllerSpec)

describe(@"ANEReorderingController", ^{
    
    __block ANEReorderingController* reorderingVC = nil;
    __block UITableView* tableView = nil;
    
    beforeEach(^{
        tableView = [UITableView new];
        reorderingVC = [[ANEReorderingController alloc] initWithTableView:tableView];
    });
    
    it(@"controller should have non nil table view", ^{
        expect(reorderingVC.tableView).notTo.beNil();
    });
    
    it(@"should implement updateWithModel: method", ^{
        expect(reorderingVC).respondTo(@selector(updateWithStorage:));
    });
    
    it(@"should set storage correctly after updateWithStorage: called", ^{
        ANStorage* testStorage = [ANStorage new];
        [reorderingVC updateWithStorage:testStorage];
        expect(reorderingVC.currentStorage).notTo.beNil();
    });
    
    afterEach(^{
        reorderingVC = nil;
    });
});

SpecEnd


