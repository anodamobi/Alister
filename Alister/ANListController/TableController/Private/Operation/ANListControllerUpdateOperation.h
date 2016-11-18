//
//  ANTableControllerUpdateOperation.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANStorageListUpdateOperationInterface.h"
#import "ANListControllerUpdateServiceInterface.h"

@interface ANListControllerUpdateOperation : NSOperation <ANStorageListUpdateOperationInterface>

@property (nonatomic, weak) id<ANListControllerUpdateServiceInterface> delegate;
@property (nonatomic, assign) BOOL shouldAnimate;

@end
