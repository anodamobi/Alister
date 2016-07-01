//
//  ANStorageUpdateTableOperationDelegate.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/5/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@class ANStorageUpdateModel;

@protocol ANStorageListUpdateOperationInterface <NSObject>

- (void)storageUpdateModelGenerated:(ANStorageUpdateModel*)updateModel;

@end
