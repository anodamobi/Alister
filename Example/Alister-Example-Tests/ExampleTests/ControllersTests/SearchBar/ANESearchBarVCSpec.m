//
//  ANESearchBarVCSpec.m
//  Alister-Example
//
//  Created by ANODA on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANESearchBarVC.h"
#import "ANESearchBarView.h"
#import "ANStorage.h"
#import "ANESearchBarController.h"

@interface ANESearchBarVC ()

@property (nonatomic, strong) ANESearchBarView* contentView;
@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANESearchBarController* controller;

@end

SpecBegin(ANESearchBarVC)

describe(@"ANESearchBarVC", ^{
    
    __block ANESearchBarVC* viewController = nil;
    __weak typeof(viewController)weakVC = viewController;

    beforeEach(^{
        viewController = [ANESearchBarVC new];
    });
    
    it(@"should have non nil contentView", ^{
        expect(viewController.contentView).notTo.beNil();
    });
    
    it(@"should have non nil storage", ^{
        expect(viewController.storage).notTo.beNil();
    });
    
    it(@"should have non nil controller", ^{
        expect(viewController.controller).notTo.beNil();
    });
    
    it(@"storage should have items in section 0 after controller finished update", ^{
        
        [viewController.controller addUpdatesFinishedTriggerBlock:^{
            NSArray* storageItems = [weakVC.storage itemsInSection:0];
            expect(storageItems).notTo.beNil();
        }];
    });
    
    afterEach(^{
        viewController = nil;
    });
});

SpecEnd
