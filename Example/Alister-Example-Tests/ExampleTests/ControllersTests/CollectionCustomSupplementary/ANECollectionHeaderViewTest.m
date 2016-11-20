//
//  ANECollectionHeaderViewTest.m
//  Alister-Example
//
//  Created by ANODA on 11/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionHeaderView.h"

@interface ANECollectionHeaderView ()

@property (nonatomic, strong) UILabel* titleLabel;

@end

SpecBegin(ANECollectionHeaderView)

__block ANECollectionHeaderView* view = nil;
__block NSString* model = nil;

beforeEach(^{
    view = [ANECollectionHeaderView new];
    model = @"model";
});

describe(@"ANECollectionHeaderView", ^{
    
    it(@"at default state titleLabel should not be nil", ^{
        expect(view.titleLabel).notTo.beNil();
    });
    
    it(@"should update titleLabel", ^{
        [view updateWithModel:model];
        
        expect(view.titleLabel.text).to.equal(model);
    });
});

SpecEnd
