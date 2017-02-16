//
//  NSOperationQueueFixture.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/16/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "NSOperationQueueFixture.h"

@implementation NSOperationQueueFixture

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)addOperation:(id)operation
{
    [self.operations addObject:operation];
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    
}

@end
