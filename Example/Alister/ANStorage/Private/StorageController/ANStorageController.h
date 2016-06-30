//
//  ANStorageController.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdatableInterface.h"
#import "ANStorageUpdateOperationInterface.h"
#import "ANStorageRetrivingInterface.h"

@class ANStorageModel;
@class ANStorageUpdateModel;

@interface ANStorageController : NSObject <ANStorageUpdatableInterface, ANStorageRetrivingInterface>

@property (nonatomic, strong) ANStorageModel* storage;
@property (nonatomic, weak) id<ANStorageUpdateOperationInterface> updateDelegate;

@end
