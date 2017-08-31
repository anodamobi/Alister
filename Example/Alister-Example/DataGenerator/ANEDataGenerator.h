//
//  ANEDataGenerator.h
//  Alister-Example
//
//  Created by ANODA on 10/19/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@interface ANEDataGenerator : NSObject

+ (NSArray*)generateStringsArray;
+ (NSArray*)generateStringsArrayWithCapacity:(NSUInteger)capacity;
+ (NSString*)loremIpsumString;
+ (NSArray*)bottomStickedItems;
+ (NSArray*)generateUsernames;

@end
