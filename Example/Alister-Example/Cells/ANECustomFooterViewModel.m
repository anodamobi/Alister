//
//  ANECustomFooterViewModel.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomFooterViewModel.h"

@interface ANECustomFooterViewModel ()

@property (nonatomic, strong) NSAttributedString* attrString;

@end

@implementation ANECustomFooterViewModel

+ (instancetype)viewModelWithAttrString:(NSAttributedString*)attrString
{
    ANECustomFooterViewModel* viewModel = [self new];
    viewModel.attrString = attrString;
    
    return viewModel;
}

- (NSAttributedString*)attributedString
{
    NSAttributedString* attrString = nil;
    if (self.attrString)
    {
        attrString = self.attrString;
    }
    else
    {
        attrString = [[NSAttributedString alloc] initWithString:@""];
    }
    
    return attrString;
}

@end
