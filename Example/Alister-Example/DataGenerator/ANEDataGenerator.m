//
//  ANEDataGenerator.m
//  Alister-Example
//
//  Created by ANODA on 10/19/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEDataGenerator.h"

@implementation ANEDataGenerator

+ (NSArray*)generateStringsArray
{
    NSMutableArray* mutableStringsArray = [NSMutableArray new];
    NSUInteger randomValue = (arc4random() % 20) + 5;
    
    for (NSUInteger counter = 0; counter < randomValue; counter++)
    {
        NSString* item = [NSString stringWithFormat:@"Test %zd", counter];
        [mutableStringsArray addObject:item];
    }
    
    return mutableStringsArray;
}

+ (NSArray*)bottomStickedItems
{
    return @[@"Item 1", @"Item 2", @"Item 3"];
}

+ (NSString*)loremIpsumString
{
    return @"Lorem Ipsum is simply dummy text.";
}

@end
