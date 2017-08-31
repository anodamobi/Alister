//
//  ANButtonFooterViewSpec.m
//  Alister-Example
//
//  Created by ANODA on 10/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEButtonFooterView.h"

SpecBegin(ANEButtonFooterView)

describe(@"ANEButtonFooterView", ^{
    
    __block ANEButtonFooterView* footerView = nil;
    
    beforeEach(^{
        footerView = [ANEButtonFooterView new];
    });
    
    it(@"should have non nil actionButton", ^{
        
        expect(footerView.actionButton).notTo.beNil();
    });
    
    afterEach(^{
        footerView = nil;
    });
});

SpecEnd

