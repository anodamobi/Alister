//
//  ANTestHelper.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/28/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

static id const kANTestNil = nil;

@interface ANTestHelper : NSObject

+ (NSArray*)randomArray;
+ (NSArray*)randomArrayIncludingObject:(id)object atIndex:(NSInteger)index;
+ (NSArray*)randomArrayWithLength:(NSUInteger)count;

+ (NSString*)randomString;

+ (NSNumber*)randomNumber;

+ (NSDictionary*)randomDictionary;

+ (id)randomObject;

@end
