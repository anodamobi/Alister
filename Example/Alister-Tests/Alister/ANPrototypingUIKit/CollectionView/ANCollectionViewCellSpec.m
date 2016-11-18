//
//  ANCollectionViewCellTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANCollectionViewCell.h"

SpecBegin(ANCollectionViewCell)

__block ANCollectionViewCell* cell = nil;

beforeEach(^{
    cell = [[ANCollectionViewCell alloc] initWithFrame:CGRectZero];
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
