//
//  ANTestHelper.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/28/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestHelper.h"

@implementation ANTestHelper

+ (id)randomObject
{
    NSInteger numberOfObjects = arc4random_uniform(10);
    switch (numberOfObjects % 5)
    {
        case 0:
        {
            return [NSObject new];
        } break;
            
        case 1:
        {
            return [self randomNumber];
        } break;
            
        case 2:
        {
            return [self randomString];
        } break;
            
        case 3:
        {
            return @{[self randomString] : [self randomNumber]};
        } break;
            
        default:
        {
            return [NSNull null];
        } break;
    }
}

+ (Class)randomClass
{
    NSInteger numberOfObjects = arc4random_uniform(10);
    switch (numberOfObjects)
    {
        case 0: return [NSString class];
        case 2: return [NSArray class];
        case 3: return [NSDictionary class];
        case 4: return [NSData class];
        case 5: return [NSObject class];
        case 6: return [NSDate class];
        case 7: return [NSError class];
        case 8: return [NSIndexPath class];
            
        default: return [NSSet class]; break;
    }
}

+ (NSArray*)randomArray
{
    return [self randomArrayWithLength:arc4random_uniform(10)];
}

+ (NSArray*)randomArrayWithLength:(NSUInteger)count
{
    NSMutableArray* array = [NSMutableArray array];
    for (NSUInteger counter = 0; counter < count; counter++)
    {
        [array addObject:[self randomObject]];
    }
    
    return [array copy];
}

+ (NSArray *)randomArrayIncludingObject:(id)object atIndex:(NSInteger)index
{
    NSMutableArray* array = [[self randomArrayWithLength:index*2] mutableCopy];
    [array insertObject:object atIndex:index];
    
    return [array copy];
}

+ (NSNumber*)randomNumber
{
    return [NSNumber numberWithInteger:arc4random_uniform(100)];
}

+ (NSString*)randomString
{
    return [[NSUUID UUID] UUIDString];
}

+ (NSDictionary*)randomDictionary
{
    NSInteger numberOfObjects = arc4random_uniform(10);
    NSMutableDictionary* dict = [NSMutableDictionary new];
    
    for (NSInteger counter = 0; counter < numberOfObjects; counter++)
    {
        [dict setObject:[self randomObject] forKey:[self randomString]];
    }
    
    return [dict copy];
}

+ (NSIndexPath*)zeroIndexPath
{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

@end
