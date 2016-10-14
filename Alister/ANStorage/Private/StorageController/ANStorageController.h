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

/**
 This class is like public proxy between public interface methods 
 and private classes ANStorageLoader, ANStorageUpdater and ANStorageRemover.
 */
@interface ANStorageController : NSObject <ANStorageUpdatableInterface, ANStorageRetrivingInterface>


/**
 Current storage model that contains all items
 */
@property (nonatomic, strong, nonnull) ANStorageModel* storageModel;


/**
 Delegate for receiving updates
 */
@property (nonatomic, weak, nullable) id<ANStorageUpdateOperationInterface> updateDelegate;

@end
