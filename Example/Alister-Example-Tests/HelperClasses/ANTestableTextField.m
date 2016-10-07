//
//  ANTestableTextField.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/23/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableTextField.h"

@interface ANTestableRange : UITextRange

@property (nonatomic, strong) UITextPosition* rangePosition;

- (void)updateWithRange:(UITextPosition*)range;

@end

@implementation ANTestableRange

- (void)updateWithRange:(UITextPosition*)range
{
    self.rangePosition = range;
}

- (UITextPosition*)start
{
    return self.rangePosition;
}

@end



@interface ANTestableTextField ()

@property (nonatomic, assign) BOOL responderValue;

@end

@implementation ANTestableTextField

+ (instancetype)viewWithResponderValue:(BOOL)responderValue
{
    ANTestableTextField* view = [self new];
    view.responderValue = responderValue;
    
    return view;
}

- (BOOL)isFirstResponder
{
    return self.responderValue;
}

- (UITextRange*)selectedTextRange
{
    ANTestableRange* range = [ANTestableRange new];
    [range updateWithRange:[UITextPosition new]];
    
    return range;
}

@end
