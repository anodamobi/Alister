//
//  ANStorageUpdateControllerDelegate.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/5/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@class ANStorageUpdateOperation;

@protocol ANStorageUpdateControllerInterface <NSObject>

- (void)updateStorageOperationRequiresForceReload:(ANStorageUpdateOperation*)operation;

@end
