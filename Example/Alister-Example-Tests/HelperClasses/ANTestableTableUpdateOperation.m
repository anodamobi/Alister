//
//  ANTestableTableUpdateOperation.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableTableUpdateOperation.h"

@interface ANTestableTableUpdateOperation ()

@property (nonatomic, assign) BOOL cancel;

@end

@implementation ANTestableTableUpdateOperation

+ (instancetype)operationWithCancelValue:(BOOL)isCancel
{
    ANTestableTableUpdateOperation* operation = [self new];
    operation.cancel = isCancel;
    
    return operation;
}

- (BOOL)isCancelled
{
    return self.cancel;
}

@end
