//
//  ANTestableRange.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableRange.h"

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


