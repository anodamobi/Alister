//
//  NSOperationQueueFixture.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/16/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@interface NSOperationQueueFixture : NSObject

@property (nonatomic, strong) NSMutableArray* operations;

- (void)addOperation:(id)operation;

@end
