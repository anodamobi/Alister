//
//  ANEDataGenerator.m
//  Alister-Example
//
//  Created by ANODA on 10/19/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEDataGenerator.h"

@implementation ANEDataGenerator

static NSString* kNamesArray[] = {
    @"Corrie", @"Jennette", @"Shavonne",
    @"Delila", @"Lula", @"Normand",
    @"Marshall", @"Arcelia", @"Ara",
    @"John", @"Vella", @"Dennise",
    @"Shawnee", @"Jenise", @"Izola",
    @"Gwenda", @"Beckie", @"Laurel",
    @"Lorriane", @"Joan", @"Woodrow",
    @"Sigrid", @"Melinda", @"Claribel",
    @"Mellie", @"Leonard", @"Joie"
};

+ (NSArray*)generateStringsArray
{
    NSUInteger randomValue = (arc4random() % 20) + 5;
    
    return [self generateStringsArrayWithCapacity:randomValue];
}

+ (NSArray*)generateStringsArrayWithCapacity:(NSUInteger)capacity
{
    NSMutableArray* mutableStringsArray = [NSMutableArray new];
    
    for (NSUInteger counter = 0; counter < capacity; counter++)
    {
        NSString* item = [NSString stringWithFormat:@"Model #%zd", counter];
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

+ (NSArray*)generateUsernames
{
    NSMutableArray* items = [NSMutableArray new];
    NSUInteger countNames = sizeof(kNamesArray) / sizeof(kNamesArray[0]);
    
    for (NSUInteger counter = 0; counter < countNames; counter++)
    {
        [items addObject:kNamesArray[counter]];
    }
    
    return items;
}

@end
