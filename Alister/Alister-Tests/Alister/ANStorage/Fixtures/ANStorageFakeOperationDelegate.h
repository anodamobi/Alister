//
//  ANStorageFakeOperationDelegate.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/26/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerUpdateServiceInterface.h"
#import "ANStorageListUpdateOperationInterface.h"
#import "ANStorageUpdateOperationInterface.h"

@interface ANStorageFakeOperationDelegate : NSObject
<
ANListControllerUpdateServiceInterface,
ANStorageListUpdateOperationInterface,
ANStorageUpdateOperationInterface
>

@property (nonatomic, strong) ANStorageUpdateModel* lastUpdate;

@end
