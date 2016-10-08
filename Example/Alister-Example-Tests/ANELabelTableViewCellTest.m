//
//  ANELabelTableViewCellTest.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/8/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANELabelTableViewCell.h"

SpecBegin(ANELabelTableViewCell)

describe(@"ANELabelTableViewCell", ^{
    
    __block ANELabelTableViewCell* cell = nil;
    
    beforeEach(^{
        cell = [[ANELabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:@"TestIdentifier"];
    });
    
    it(@"should update title label if model is string", ^{
        [cell updateWithModel:@"Test"];
        expect(cell.textLabel.text).equal(@"Test");
    });
    
    it(@"should ignore update if model not a string", ^{
        [cell updateWithModel:nil];
        expect(cell.textLabel.text).equal(nil);
    });
});

SpecEnd
