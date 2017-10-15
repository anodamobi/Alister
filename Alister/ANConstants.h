//
//  Alister.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/4/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@protocol ANListControllerReusableInterface;

typedef NSPredicate* _Nonnull (^ANListControllerSearchPredicateBlock)(NSString* _Nonnull searchString, NSInteger scope);
typedef void(^ANListControllerItemSelectionBlock)(id _Nonnull model, NSIndexPath* _Nonnull indexPath);
typedef void(^ANListControllerCellConfigurationBlock)(id<ANListControllerReusableInterface> _Nonnull configurator);
typedef void (^ANListControllerUpdatesFinishedTriggerBlock)(void);

static NSString* _Nonnull const ANListDefaultHeaderKind = @"ANStorageHeaderKind";
static NSString* _Nonnull const ANListDefaultFooterKind = @"ANStorageFooterKind";

static CGFloat const ANListDefaultActionTimeOut = 0.3f;
