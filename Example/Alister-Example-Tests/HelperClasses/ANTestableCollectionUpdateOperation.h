//
//  ANTestableCollectionUpdateOperation.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANCollectionControllerUpdateOperation.h"

@interface ANTestableCollectionUpdateOperation : ANCollectionControllerUpdateOperation

+ (instancetype)operationWithCanceledValue:(BOOL)isCanceled;

@end
