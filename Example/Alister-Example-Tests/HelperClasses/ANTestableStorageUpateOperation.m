//
//  ANTestableStorageUpateOperation.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/25/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableStorageUpateOperation.h"

@interface ANTestableStorageUpateOperation ()

@property (nonatomic, assign) BOOL cancelValue;

@end

@implementation ANTestableStorageUpateOperation

+ (instancetype)operationWithCancelValue:(BOOL)isCanceled
{
    ANTestableStorageUpateOperation* operation = [self new];
    operation.cancelValue = isCanceled;
    
    return operation;
}

- (BOOL)isCancelled
{
    return self.cancelValue;
}

@end
