//
//  ANStorageOperationFakeDelegate.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerUpdateOperationInterface.h"
#import "ANListControllerUpdateServiceInterface.h"

@interface ANStorageOperationFakeDelegate : NSObject
<
    ANListControllerUpdateOperationDelegate,
    ANListControllerUpdateServiceInterface
>

@end
