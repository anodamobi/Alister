//
//  ANStorageUpdateModel.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/9/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageUpdateModel.h>

@interface ANStorageUpdateModel (Test)

+ (instancetype)filledModel;
- (BOOL)hasSpecifiedCountOfObjectsInEachProperty:(NSUInteger)expectedCount;

@end
