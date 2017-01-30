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

typedef void(^ANDataStorageUpdateBlock)(id<ANStorageUpdatableInterface> storageController);

/**
 TODO:
 */

@interface ANStorage : NSObject <ANStorageRetrivingInterface>

/**
 This is a private property and should not call directly.
 Indicates ...
 */
@property (nonatomic, weak) id<ANStorageUpdateEventsDelegate> updatesHandler;


/**
 This is a private property and should not call directly.
 Unique storage identifier. It installs while creating storage.
 */
@property (nonatomic, strong, readonly) NSString* identifier;


/**
 Updates storage and list view with animation.
 
 @param block           Updates block. Contains storage controller, which conform <ANStorageUpdatableInterface>
 */
- (void)updateWithAnimationChangeBlock:(ANDataStorageUpdateBlock)block;


/**
 Updates storage and list view without animation.
 
 @param block           Updates block. Contains storage controller, which conform <ANStorageUpdatableInterface>
 */
- (void)updateWithoutAnimationChangeBlock:(ANDataStorageUpdateBlock)block;


/**
 Reloads storage and as result a list view.
 
 @param isAnimatable    Animation flag. YES, if you want to animate reloading.
 */
- (void)reloadStorageWithAnimation:(BOOL)isAnimatable;


//private ://todo
- (void)updateHeaderKind:(NSString*)headerKind footerKind:(NSString*)footerKind;

@end
