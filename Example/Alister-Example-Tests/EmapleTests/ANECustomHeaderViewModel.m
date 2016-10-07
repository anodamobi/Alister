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
        failure(@"Pending");
    });
    
    it(@"should assert when set delegate not conformed to protocol", ^{
        failure(@"Pending");
    });
    
    it(@"should no assert when set correct delegate", ^{
        failure(@"Pending");
    });
    
    it(@"no assert when set nil delegate", ^{
        failure(@"Pending");
    });
    
    
    it(@"viewModel created with not empty titles", ^{
       failure(@"Pending");
    });
});

SpecEnd


