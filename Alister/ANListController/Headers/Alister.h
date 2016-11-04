//
//  Alister.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/4/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerReusableInterface.h"
#import "ANListControllerConfigurationModel.h"


typedef NSPredicate*(^ANListControllerSearchPredicateBlock)(NSString* searchString, NSInteger scope);
typedef void(^ANListControllerItemSelectionBlock)(id model, NSIndexPath* indexPath);
typedef void(^ANListControllerCellConfigurationBlock)(id<ANListControllerReusableInterface> configurator);
typedef void(^ANListConfigurationModelUpdateBlock)(ANListControllerConfigurationModel* configurationModel);
typedef void (^ANListControllerUpdatesFinishedTriggerBlock)();
