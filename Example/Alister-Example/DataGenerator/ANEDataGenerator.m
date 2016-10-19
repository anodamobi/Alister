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
    NSUInteger randomValue = (arc4random() % 10) + 5;
    
    for (NSUInteger counter = 0; counter < randomValue; counter++)
    {
        NSString* item = [NSString stringWithFormat:@"Test %zd", counter];
        [mutableStringsArray addObject:item];
    }
    
    return mutableStringsArray;
}

@end
