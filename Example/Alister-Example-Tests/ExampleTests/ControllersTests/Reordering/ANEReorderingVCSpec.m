//
//  ANEReorderingVCSpec.m
//  Alister-Example
//
//  Created by ANODA on 10/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEReorderingVC.h"
#import "ANEReorderingController.h"

@interface ANEReorderingVC ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANEReorderingController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

SpecBegin(ANEReorderingVCSpec)

describe(@"Thing", ^{
    
    __block ANEReorderingVC* vc = nil;
    
    beforeEach(^{
        vc = [ANEReorderingVC new];
    });
    
    it(@"should have non nil tableView", ^{
        expect(vc.tableView).notTo.beNil();
    });
    
    it(@"should have non nil controller", ^{
        expect(vc.controller).notTo.beNil();
    });
    
    it(@"should have non nil storage", ^{
        expect(vc.storage).notTo.beNil();
    });
    
    it(@"controller should have non nil table view", ^{
        expect(vc.controller.tableView).notTo.beNil();
    });
    
    it(@"controller should have non nil current storage", ^{
        expect(vc.controller.currentStorage).notTo.beNil();
    });

    it(@"storage should have items after controller finished update", ^{
        
        __weak typeof(vc) weakVC = vc;
        [vc.controller addUpdatesFinsihedTriggerBlock:^{
            NSArray* storageItems = [weakVC.storage itemsInSection:0];
            expect(storageItems).notTo.beNil();
        }];
    });

    afterEach(^{
        vc = nil;
    });
});

SpecEnd



