//
//  ANECustomFooterViewModelTest.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/8/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANECustomFooterViewModel.h"

SpecBegin(ANECustomFooterViewModel)

describe(@"ANECustomFooterViewModel", ^{
    
    __block ANECustomFooterViewModel* viewModel = nil;
    
    it(@"should have non nil attributedTitle after viewModelWithAttrString:", ^{
        NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:@"some string"];
        viewModel = [ANECustomFooterViewModel viewModelWithAttrString:attrString];
        expect([viewModel attributedString]).notTo.beNil();
    });
    
    it(@"should be not nil after custom inilializer", ^{
        viewModel = [ANECustomFooterViewModel viewModelWithAttrString:[NSAttributedString new]];
        expect(viewModel).notTo.beNil();
    });
    
    it(@"attributedString should not return nil", ^{
        viewModel = [ANECustomFooterViewModel viewModelWithAttrString:nil];
        expect([viewModel attributedString]).notTo.beNil();
    });
});

SpecEnd
