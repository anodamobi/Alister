//
//  ANCollectionReusableViewTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANCollectionReusableView.h>

SpecBegin(ANCollectionReusableView)

__block ANCollectionReusableView* view = nil;

beforeEach(^{
    view = [[ANCollectionReusableView alloc] initWithFrame:CGRectZero];
});

describe(@"updateWithModel:", ^{
    
    it(@"no assert if model is nil", ^{
        void(^block)() = ^() {
            [view updateWithModel:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"responds to selector", ^{
        expect(view).respondTo(@selector(updateWithModel:));
    });
});

SpecEnd
