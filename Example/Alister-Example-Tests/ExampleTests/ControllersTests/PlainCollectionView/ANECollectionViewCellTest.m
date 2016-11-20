//
//  ANECollectionViewCellTest.m
//  Alister-Example
//
//  Created by ANODA on 11/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionViewCell.h"

@interface ANECollectionViewCell ()

@property (nonatomic, strong) UILabel* titleLabel;

@end

SpecBegin(ANECollectionViewCell)

__block ANECollectionViewCell* cell = nil;
__block NSString* model = nil;

beforeEach(^{
    cell = [[ANECollectionViewCell alloc] initWithFrame:CGRectZero];
    model = @"model";
});

describe(@"ANECollectionViewCell", ^{
    
    it(@"at default state title label should not be nil", ^{
        expect(cell.titleLabel).notTo.beNil();
    });
    
    it(@"should update title label", ^{
        [cell updateWithModel:model];
        
        expect(cell.titleLabel.text).to.equal(model);
    });
});

SpecEnd
