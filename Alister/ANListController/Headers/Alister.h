//
//  Alister.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/4/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerReusableInterface.h"

typedef NSPredicate*(^ANListControllerSearchPredicateBlock)(NSString* searchString, NSInteger scope);
typedef void(^ANListControllerItemSelectionBlock)(id model, NSIndexPath* indexPath);
typedef void(^ANListControllerCellConfigurationBlock)(id<ANListControllerReusableInterface> configurator);
typedef void (^ANListControllerUpdatesFinishedTriggerBlock)();

static NSString* const ANListDefaultHeaderKind = @"ANStorageHeaderKind";
static NSString* const ANListDefaultFooterKind = @"ANStorageFooterKind";
