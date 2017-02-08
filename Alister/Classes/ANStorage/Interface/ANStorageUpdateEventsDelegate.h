//
//  ANStorageDelegate.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageUpdateOperation;

@protocol ANStorageUpdateEventsDelegate <NSObject>

- (void)storageDidPerformUpdate:(ANStorageUpdateOperation*)updateOperation
                 withIdentifier:(NSString*)identifier
                     animatable:(BOOL)shouldAnimate;

- (void)storageNeedsReloadWithIdentifier:(NSString*)identifier animated:(BOOL)shouldAnimate;

@end
