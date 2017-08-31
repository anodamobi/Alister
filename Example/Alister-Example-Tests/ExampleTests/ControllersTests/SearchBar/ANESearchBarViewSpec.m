//
//  ANESearchBarViewSpec.m
//  Alister-Example
//
//  Created by ANODA on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANESearchBarView.h"

SpecBegin(ANESearchBarView)

describe(@"ANESearchBarView", ^{
    
    __block ANESearchBarView* contentView = nil;
    
    beforeEach(^{
        contentView = [ANESearchBarView new];
    });
    
    it(@"should have non nil tableView", ^{
        expect(contentView.tableView).notTo.beNil();
    });
    
    it(@"should have non nil searchBar", ^{
        expect(contentView.searchBar).notTo.beNil();
    });
    
    afterEach(^{
        contentView = nil;
    });
});

SpecEnd
