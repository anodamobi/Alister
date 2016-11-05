//
//  ANTestableStorageUpateOperation.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/25/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageUpdateOperation.h"

@interface ANTestableStorageUpateOperation : ANStorageUpdateOperation

+ (instancetype)operationWithCancelValue:(BOOL)isCanceled;

@end
