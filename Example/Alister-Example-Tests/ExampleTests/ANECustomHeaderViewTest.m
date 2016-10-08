//
//  ANECustomHeaderViewTest.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/8/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomHeaderView.h"
#import <Specta/Specta.h>

@interface ANECustomHeaderView ()

@property (nonatomic, strong) UISegmentedControl* segmentControl;

@end

SpecBegin(ANECustomHeaderView)

describe(@"ANECustomHeaderView", ^{
    
    __block ANECustomHeaderView* headerView = nil;
    
    beforeEach(^{
        headerView = [[ANECustomHeaderView alloc] initWithReuseIdentifier:@"TestIdentifer"];
    });
    
    it(@"should have non nil segment control", ^{
        expect(headerView.segmentControl).notTo.beNil();
    });

    it(@"should implement updateWithModel: method", ^{
        expect(headerView).respondTo(@selector(updateWithModel:));
    });
    
    it(@"should have same number of segments as in viewModel after updateWithModel:", ^{
        ANECustomHeaderViewModel* viewModel = [ANECustomHeaderViewModel viewModelWithSegmentTitles:@[@"title", @"title"]];
        [headerView updateWithModel:viewModel];
        expect(headerView.segmentControl.numberOfSegments).equal(viewModel.segmentTitles.count);
    });
});

SpecEnd


