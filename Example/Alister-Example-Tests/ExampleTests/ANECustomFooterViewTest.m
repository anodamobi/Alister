//
//  ANECustomFooterViewTest.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/8/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomFooterView.h"

@interface ANECustomFooterView ()

@property (nonatomic, strong) UILabel* attributedLabel;

@end

SpecBegin(ANECustomFooterView)

describe(@"ANECustomFooterView", ^{
    
    __block ANECustomFooterView* view = nil;
    
    beforeEach(^{
        view = [[ANECustomFooterView alloc] initWithReuseIdentifier:@"TestIndetifier"];
    });
    
    it(@"after updateWithModel should have updated label", ^{
       
        NSAttributedString* string = [[NSAttributedString alloc] initWithString:@"custom"];
        ANECustomFooterViewModel* viewModel = [ANECustomFooterViewModel viewModelWithAttrString:string];
        [view updateWithModel:viewModel];
        
        expect(view.attributedLabel.attributedText).equal(string);
    });
});

SpecEnd
