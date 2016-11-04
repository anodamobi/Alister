//
//  ANTableControllerUpdateOperation.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANStorageListUpdateOperationInterface.h"
#import "ANListControllerQueueProcessorInterface.h"
#import "ANListControllerUpdateOperationInterface.h"

@interface ANTableControllerUpdateOperation : NSOperation
<
    ANStorageListUpdateOperationInterface,
    ANListControllerUpdateOperationInterface
>

@property (nonatomic, weak) id<ANListControllerQueueProcessorInterface> delegate;
@property (nonatomic, assign) BOOL shouldAnimate;

@end
