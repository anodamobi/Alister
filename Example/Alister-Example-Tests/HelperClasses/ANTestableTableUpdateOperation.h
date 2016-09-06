//
//  ANTestableTableUpdateOperation.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANTableControllerUpdateOperation.h"

@interface ANTestableTableUpdateOperation : ANTableControllerUpdateOperation

+ (instancetype)operationWithCancelValue:(BOOL)isCancel;
- (BOOL)isCancelled;

@end
