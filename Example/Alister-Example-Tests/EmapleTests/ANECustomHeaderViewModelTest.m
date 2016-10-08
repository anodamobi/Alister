//
//  ANECustomHeaderViewModel.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/8/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANECustomHeaderViewModel.h"

SpecBegin(ANECustomHeaderViewModel)

describe(@"ANECustomHeaderViewModel", ^{
    
    __block ANECustomHeaderViewModel* viewModel = nil;
    
    beforeEach(^{
        viewModel = [ANECustomHeaderViewModel new];
    });
    
    it(@"should call delegate when indexSelected:", ^{
        
        id delegateMock = OCMProtocolMock(@protocol(ANECustomHeaderViewModelDelegate));
        viewModel.delegate = delegateMock;
        
        OCMExpect([viewModel.delegate headerViewModelIndexUpdatedTo:1 onModel:viewModel]);
        
        [viewModel itemSelectedWithIndex:1];
    });
    
    it(@"should assert when set delegate not conformed to protocol", ^{
       
        void(^testBlock)() = ^() {
            viewModel.delegate = (id)[NSObject new];
        };
        
        expect(testBlock).to.raiseAny();
    });
    
    it(@"should no assert when set correct delegate", ^{
        void(^testBlock)() = ^() {
            id delegateMock = OCMProtocolMock(@protocol(ANECustomHeaderViewModelDelegate));
            viewModel.delegate = delegateMock;
        };
        
        expect(testBlock).notTo.raiseAny();
    });
    
    it(@"no assert when set nil delegate", ^{
        void(^testBlock)() = ^() {
            viewModel.delegate = nil;
        };
        
        expect(testBlock).notTo.raiseAny();
    });
    
    it(@"viewModel created with not empty titles", ^{
        NSArray* titles = @[@"titles", @"titles", @"titles"];
        viewModel = [ANECustomHeaderViewModel viewModelWithSegmentTitles:titles];
        expect(viewModel.segmentTitles).equal(titles);
    });
});

SpecEnd


