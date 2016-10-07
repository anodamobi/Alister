//
//  ANECustomHeaderViewTest.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/8/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomHeaderView.h"
#import <Specta/Specta.h>

SpecBegin(ANECustomHeaderView)

describe(@"ANECustomHeaderView", ^{
    
    __block ANECustomHeaderView* headerView = nil;
    
    beforeEach(^{
        headerView = [[ANECustomHeaderView alloc] initWithReuseIdentifier:@"TestIdentifer"];
    });
    
    it(@"should have non nil segment control", ^{
        failure(@"Pending");
    });

    it(@"should implement updateWithModel: method", ^{
        failure(@"Pending");
    });

    afterEach(^{
        
    });
    
    afterAll(^{

    });
});

SpecEnd


