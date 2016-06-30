//
//  ANStorageUpdateControllerInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageUpdateModel;

@protocol ANStorageUpdateOperationInterface <NSObject>

- (void)collectUpdate:(ANStorageUpdateModel*)updateModel;

@end