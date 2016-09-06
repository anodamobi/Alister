//
//  ANTestableCollectionUpdateOperation.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableCollectionUpdateOperation.h"

@interface ANTestableCollectionUpdateOperation ()

@property (nonatomic, assign) BOOL operationCanceled;

@end

@implementation ANTestableCollectionUpdateOperation

+ (instancetype)operationWithCanceledValue:(BOOL)isCanceled
{
    ANTestableCollectionUpdateOperation* operation = [self new];
    operation.operationCanceled = isCanceled;
    
    return operation;
}

- (BOOL)isCancelled
{
    return self.operationCanceled;
}

@end
