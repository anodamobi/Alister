//
//  ANStorageDebugDataGenerator.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@class ANStorage;
@class ANStorageSectionModel;
@class ANStorageModel;

@interface ANStorageDebugDataGenerator : NSObject

+ (NSString*)storageDebugDescription:(ANStorage*)storage;
+ (NSString*)sectionDebugDescription:(ANStorageSectionModel*)section;
+ (NSString*)storageModelDebugDescription:(ANStorageModel*)storageModel;

@end
