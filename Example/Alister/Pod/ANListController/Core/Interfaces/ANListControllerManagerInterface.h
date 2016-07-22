//
//  ANListControllerManagerInterface.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerReusableInterface.h"
#import "ANStorageUpdatingInterface.h"
#import "ANListControllerConfigurationModelInterface.h"

@protocol ANListControllerManagerInterface <NSObject>

- (id<ANListControllerReusableInterface>)reusableViewsHandler;
- (id<ANStorageUpdatingInterface>)updateHandler;
- (id<ANListControllerConfigurationModelInterface>)configurationModel;

@end
