//
//  ANStorageUpdateControllerInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdateOperationInterface.h"
#import "ANStorageListUpdateOperationInterface.h"
#import "ANStorageUpdateControllerInterface.h"

@class ANStorageUpdateOperation;

typedef void(^ANStorageUpdateOperationConfigurationBlock)(ANStorageUpdateOperation* operation);

@interface ANStorageUpdateOperation : NSOperation <ANStorageUpdateOperationInterface>

+ (instancetype)operationWithExecutionBlock:(ANStorageUpdateOperationConfigurationBlock)executionBlock;

@property (nonatomic, weak) id<ANStorageUpdateControllerInterface> updaterDelegate;
@property (nonatomic, weak) id<ANStorageListUpdateOperationInterface> controllerOperationDelegate;

@end
 