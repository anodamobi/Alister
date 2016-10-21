//
//  ANEDefaultSupplementaryVCSpec.m
//  Alister-Example
//
//  Created by ANODA on 10/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEDefaultSupplementaryVC.h"
#import "ANTableController.h"
#import "ANStorage.h"

@interface ANEDefaultSupplementaryVC ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ANTableController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

SpecBegin(ANEDefaultSupplementaryVC)

describe(@"ANEDefaultSupplementaryVC", ^{
    
    __block ANEDefaultSupplementaryVC* vc = nil;
    __weak typeof(vc) weakVC = vc;
    
    beforeEach(^{
        vc = [ANEDefaultSupplementaryVC new];
    });
    
    it(@"should have non nil tableView", ^{
        expect(vc.tableView).notTo.beNil();
    });
    
    it(@"table view style should be grouped", ^{
        expect(vc.tableView.style).equal(UITableViewStyleGrouped);
    });
    
    it(@"should have non nil controller", ^{
        expect(vc.controller).notTo.beNil();
    });
    
    it(@"should have non nil storage", ^{
        expect(vc.storage).notTo.beNil();
    });
    
    it(@"storage should have items in section 0 after controller finished update", ^{
        
        [vc.controller addUpdatesFinsihedTriggerBlock:^{
            NSArray* storageItems = [weakVC.storage itemsInSection:0];
            expect(storageItems).notTo.beNil();
        }];
    });
    
    it(@"storage should have items in section 1 after controller finished update", ^{
        
        [vc.controller addUpdatesFinsihedTriggerBlock:^{
            NSArray* storageItems = [weakVC.storage itemsInSection:1];
            expect(storageItems).notTo.beNil();
        }];
    });
    
    it(@"storage should have items in section 2 after controller finished update", ^{
        
        [vc.controller addUpdatesFinsihedTriggerBlock:^{
            NSArray* storageItems = [weakVC.storage itemsInSection:2];
            expect(storageItems).notTo.beNil();
        }];
    });

    afterEach(^{
        vc = nil;
    });
});

SpecEnd
