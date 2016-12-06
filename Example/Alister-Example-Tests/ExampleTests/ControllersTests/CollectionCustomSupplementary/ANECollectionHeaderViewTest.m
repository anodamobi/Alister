//
//  ANECollectionHeaderViewTest.m
//  Alister-Example
//
//  Created by ANODA on 11/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionHeaderView.h"
#import "ANTestHelper.h"

SpecBegin(ANECollectionHeaderView)

__block ANECollectionHeaderView* view = nil;

beforeEach(^{
    view = [ANECollectionHeaderView new];
});

describe(@"ANECollectionHeaderView", ^{
    
    it(@"at default state titleLabel should not be nil", ^{
        expect(view.titleLabel).notTo.beNil();
    });
    
    it(@"should update titleLabel", ^{
        NSString* model = [ANTestHelper randomString];
        [view updateWithModel:model];
        
        expect(view.titleLabel.text).to.equal(model);
    });
});

SpecEnd
