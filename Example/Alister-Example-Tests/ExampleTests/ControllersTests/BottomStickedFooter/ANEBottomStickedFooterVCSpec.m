//
//  ANBottomStickedFooterVCSpec.m
//  Alister-Example
//
//  Created by ANODA on 10/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEBottomStickedFooterVC.h"
#import "ANTableController.h"
#import "ANTableView.h"
#import "ANEButtonFooterView.h"

@interface ANEBottomStickedFooterVC ()

@property (nonatomic, strong) ANTableView* tableView;
@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANTableController* controller;
@property (nonatomic, strong) ANEButtonFooterView* footerView;

@end

SpecBegin(ANEBottomStickedFooterVC)

describe(@"ANEBottomStickedFooterVC", ^{
    
    __block ANEBottomStickedFooterVC* footerVC = nil;
    
    beforeEach(^{
        footerVC = [ANEBottomStickedFooterVC new];
    });
    
    it(@"should have non nil tableView", ^{
        expect(footerVC.tableView).notTo.beNil();
    });
    
    it(@"table view style should be grouped", ^{
        expect(footerVC.tableView.style).equal(UITableViewStyleGrouped);
    });
    
    it(@"should have non nil controller", ^{
        expect(footerVC.controller).notTo.beNil();
    });
    
    it(@"should have non nil storage", ^{
        expect(footerVC.storage).notTo.beNil();
    });
    
    it(@"should have non nil footerView", ^{
        expect(footerVC.footerView).notTo.beNil();
    });
    
    it(@"controller should have non nil table view", ^{
        expect(footerVC.controller.tableView).notTo.beNil();
    });
    
    it(@"controller should have non nil current storage", ^{
        expect(footerVC.controller.currentStorage).notTo.beNil();
    });
    
    it(@"storage should have items in section 0 after controller finished update", ^{
        
        __weak typeof(footerVC) weakVC = footerVC;
        [footerVC.controller addUpdatesFinsihedTriggerBlock:^{
            NSArray* storageItems = [weakVC.storage itemsInSection:0];
            expect(storageItems).notTo.beNil();
        }];
    });
    
    it(@"storage should have items in section 1 after controller finished update", ^{
        
        __weak typeof(footerVC) weakVC = footerVC;
        [footerVC.controller addUpdatesFinsihedTriggerBlock:^{
            NSArray* storageItems = [weakVC.storage itemsInSection:1];
            expect(storageItems).notTo.beNil();
        }];
    });
    
    it(@"storage should have items in section 2 after controller finished update", ^{
        
        __weak typeof(footerVC) weakVC = footerVC;
        [footerVC.controller addUpdatesFinsihedTriggerBlock:^{
            NSArray* storageItems = [weakVC.storage itemsInSection:2];
            expect(storageItems).notTo.beNil();
        }];
    });
    
    afterEach(^{
        footerVC = nil;
    });
});

SpecEnd
