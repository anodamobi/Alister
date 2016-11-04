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

@interface ANStorage : NSObject <ANStorageRetrivingInterface>

@property (nonatomic, weak) id<ANStorageUpdateEventsDelegate> updatesHandler;
@property (nonatomic, strong, readonly) NSString* identifier;


- (void)updateWithAnimationChangeBlock:(ANDataStorageUpdateBlock)block;
- (void)updateWithoutAnimationChangeBlock:(ANDataStorageUpdateBlock)block;
- (void)reloadStorageWithAnimation:(BOOL)isAnimatable;

//private ://todo
- (void)updateHeaderKind:(NSString*)headerKind footerKind:(NSString*)footerKind;

@end
