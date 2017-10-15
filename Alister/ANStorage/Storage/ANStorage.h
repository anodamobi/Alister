//
//  ANStorage.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdatableInterface.h"
#import "ANStorageUpdateEventsDelegate.h"
#import "ANStorageRetrivingInterface.h"
#import "ANStorageSectionModel.h"

typedef void(^ANDataStorageUpdateBlock)(id<ANStorageUpdatableInterface>  _Nonnull storageController);

/**
 TODO:
 */

@interface ANStorage : NSObject <ANStorageRetrivingInterface>

/**
 This is a private property and should not call directly.
 */
@property (nonatomic, weak, nullable) id <ANStorageUpdateEventsDelegate> updatesHandler;


/**
 This is a private property and should not call directly.
 Unique storage identifier. It installs while creating storage.
 */
@property (nonatomic, strong, readonly, nonnull) NSString* identifier;


/**
 Updates storage and list view with animation.
 
 @param block           Updates block. Contains storage controller, which conform <ANStorageUpdatableInterface>
 */
- (void)updateWithAnimationChangeBlock:(ANDataStorageUpdateBlock _Nonnull)block;


/**
 Updates storage and list view without animation.
 
 @param block           Updates block. Contains storage controller, which conform <ANStorageUpdatableInterface>
 */
- (void)updateWithoutAnimationChangeBlock:(ANDataStorageUpdateBlock _Nonnull)block;


/**
 Reloads storage and as result a list view.
 
 @param isAnimatable    Animation flag. YES, if you want to animate reloading.
 */
- (void)reloadStorageWithAnimation:(BOOL)isAnimatable;


//private ://todo
- (void)updateHeaderKind:(NSString* _Nonnull)headerKind footerKind:(NSString* _Nonnull)footerKind;

@end
