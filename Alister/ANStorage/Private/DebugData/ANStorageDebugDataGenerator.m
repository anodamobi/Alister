//
//  ANStorageDebugDataGenerator.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageDebugDataGenerator.h"
#import "ANStorage.h"

@implementation ANStorageDebugDataGenerator

+ (NSString*)storageDebugDescription:(ANStorage*)storage
{
    NSMutableString* string = [NSMutableString string];
    if (storage.isEmpty)
    {
    
    }
    else
    {
        [string appendFormat:@"{\n sections count:%ld \n total objects count           }", (unsigned long)storage.sections.count];
    }
    return nil;
}

+ (NSString*)sectionDebugDescription:(ANStorageSectionModel*)section
{
    return nil;
}

+ (NSString*)storageModelDebugDescription:(ANStorageModel*)storageModel
{
    return nil;
}

@end
