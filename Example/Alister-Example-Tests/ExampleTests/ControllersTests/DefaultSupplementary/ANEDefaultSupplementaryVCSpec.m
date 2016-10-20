//
//  ANEDefaultSupplementaryVCSpec.m
//  Alister-Example
//
//  Created by ANODA on 10/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEDefaultSupplementaryVC.h"

@interface ANEDefaultSupplementaryVC ()

@end

SpecBegin(ANEDefaultSupplementaryVC)

describe(@"Thing", ^{
    
    __block ANEDefaultSupplementaryVC* vc = nil;
    
    beforeEach(^{
        vc = [ANEDefaultSupplementaryVC new];
    });
    
    it(@"should do stuff", ^{

    });
    
    afterEach(^{
        vc = nil;
    });
});

SpecEnd
