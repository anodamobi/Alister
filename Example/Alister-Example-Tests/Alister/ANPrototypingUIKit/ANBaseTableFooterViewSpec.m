//
//  ANBaseTableFooterViewTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANBaseTableFooterView.h>

SpecBegin(ANBaseTableFooterView)

__block ANBaseTableFooterView* footer = nil;

beforeEach(^{
    footer = [[ANBaseTableFooterView alloc] initWithReuseIdentifier:@"test"];
});

describe(@"at default state", ^{
    
    it(@"is not transparent", ^{
        expect(footer.isTransparent).beFalsy();
    });
    
    it(@"has title label", ^{
        expect(footer.titleLabel).notTo.beNil();
    });
});

SpecEnd

