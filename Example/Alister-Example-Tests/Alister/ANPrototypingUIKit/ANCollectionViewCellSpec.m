//
//  ANCollectionViewCellTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANCollectionViewCell.h>

SpecBegin(ANCollectionViewCell)

__block ANCollectionViewCell* cell = nil;

beforeEach(^{
    UICollectionView* cw = [[UICollectionView alloc] initWithFrame:CGRectZero];
    NSString* identifier = @"testIndetifier";
    [cw registerClass:[ANCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    cell = [cw dequeueReusableCellWithReuseIdentifier:identifier
                                         forIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
});

describe(@"updateWithModel:", ^{
    
    it(@"responds to selector", ^{
        expect(cell).respondTo(@selector(updateWithModel:));
    });
    
    it(@"no assert if model is nil", ^{
        void(^block)() = ^() {
            [cell updateWithModel:nil];
        };
        expect(block).notTo.raiseAny();
    });
});

SpecEnd
