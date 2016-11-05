//
//  ANStorageFakeOperationDelegate.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/26/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageUpdateOperationInterface.h"

@interface ANStorageFakeOperationDelegate : NSObject <ANStorageUpdateOperationInterface>

@property (nonatomic, strong) ANStorageUpdateModel* lastUpdate;

@end
