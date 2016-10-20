//
//  ANBaseTableViewHeaderFooterViewTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANBaseTableViewHeaderFooterView.h>

SpecBegin(ANBaseTableViewHeaderFooterView)

__block ANBaseTableViewHeaderFooterView* view = nil;

beforeEach(^{
    view = [[ANBaseTableViewHeaderFooterView alloc] initWithReuseIdentifier:@"test"];
});


describe(@"default state", ^{
    
    it(@"is not transparent", ^{
        expect(view.isTransparent).beFalsy();
    });
    
    it(@"title label is not nil", ^{
        expect(view.titleLabel).notTo.beNil();
    });
    
    it(@"responds to updateWithModel", ^{
        expect(view).respondTo(@selector(updateWithModel:));
    });
});


describe(@"updateWithModel:", ^{
    
    it(@"no assert if model is nil", ^{
        void(^block)() = ^() {
            [view updateWithModel:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"updates title if model is string", ^{
        NSString* item = @"test";
        [view updateWithModel:item];
        
        expect(view.titleLabel.text).equal(item);
    });
    
    it(@"doesn't update title if model is not a string", ^{
        [view updateWithModel:@14];
        expect(view.titleLabel.text).beNil();
    });
    
    it(@"no assert if model is null", ^{
        void(^block)() = ^() {
            [view updateWithModel:[NSNull null]];
        };
        expect(block).notTo.raiseAny();
    });
});

SpecEnd

