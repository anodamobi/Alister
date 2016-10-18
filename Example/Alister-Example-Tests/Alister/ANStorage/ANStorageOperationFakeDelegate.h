//
//  ANStorageOperationFakeDelegate.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANListControllerUpdateOperationInterface.h>
#import <Alister/ANStorageUpdateControllerInterface.h>

@interface ANStorageOperationFakeDelegate : NSObject
<
    ANListControllerUpdateOperationInterface,
    ANStorageUpdateControllerInterface
>

@end
