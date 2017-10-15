//
//  ANStorageDelegate.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageUpdateOperation;

@protocol ANStorageUpdateEventsDelegate <NSObject>

- (void)storageDidPerformUpdate:(ANStorageUpdateOperation*  _Nonnull)updateOperation
                 withIdentifier:(NSString*  _Nonnull)identifier
                     animatable:(BOOL)shouldAnimate;

- (void)storageNeedsReloadWithIdentifier:(NSString*  _Nonnull)identifier animated:(BOOL)shouldAnimate;

@end
