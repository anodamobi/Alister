//
//  ANCollectionControllerUpdateManager.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionControllerUpdater.h"
#import "ANStorageUpdateOperation.h"
#import "ANCollectionControllerUpdateOperation.h"
#import "ANCollectionControllerConfigurationModel.h"
#import "ANCollectionControllerReloadOperation.h"

@interface ANCollectionControllerUpdater ()
<
    ANStorageUpdateControllerInterface,
    ANCollectionControllerUpdateOperationDelegate,
    ANCollectionControllerReloadOperationDelegate
>

@property (nonatomic, strong) NSOperationQueue* queue;

@end

@implementation ANCollectionControllerUpdater

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.queue = [NSOperationQueue mainQueue];
        self.queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (UICollectionView*)collectionView
{
    return [self.delegate collectionView];
}

- (ANCollectionControllerConfigurationModel*)configurationModel
{
    return [self.delegate configurationModel];
}

- (void)storageDidPerformUpdate:(ANStorageUpdateOperation*)updateOperation
                 withIdentifier:(NSString*)identifier
                     animatable:(BOOL)shouldAnimate
{
    if (shouldAnimate)
    {
        ANCollectionControllerUpdateOperation* controllerOperation = [ANCollectionControllerUpdateOperation new];
        controllerOperation.delegate = self;
        controllerOperation.name = identifier;
        
        updateOperation.controllerOperationDelegate = controllerOperation;
        [self _addUpdateOperation:updateOperation withIdentifier:identifier];
        
        [self.queue addOperation:controllerOperation];
    }
    else
    {
        [self _addUpdateOperation:updateOperation withIdentifier:identifier];
        [self updateStorageOperationRequiresForceReload:updateOperation];
    }
}

- (void)updateStorageOperationRequiresForceReload:(ANStorageUpdateOperation*)operation
{
    [self _reloadStorageWithAnimation:NO identifier:operation.name];
}

- (void)storageNeedsReloadWithIdentifier:(NSString*)identifier
{
    [self _reloadStorageWithAnimation:NO identifier:identifier];
}

- (void)storageNeedsReloadAnimatedWithIdentifier:(NSString*)identifier
{
    [self _reloadStorageWithAnimation:YES identifier:identifier];
}


#pragma mark - Private

- (void)_addUpdateOperation:(ANStorageUpdateOperation*)updateOperation withIdentifier:(NSString*)identifier
{
    updateOperation.updaterDelegate = self;
    updateOperation.name = identifier;
    [self.queue addOperation:updateOperation];
}

- (void)_reloadStorageWithAnimation:(BOOL)isAnimated identifier:(NSString*)storageIdentifier
{
    for (NSOperation* operation in self.queue.operations)
    {
        if ([operation isMemberOfClass:[ANCollectionControllerUpdateOperation class]] ||
            [operation isMemberOfClass:[ANCollectionControllerReloadOperation class]])
        {
            if ([operation.name isEqualToString:storageIdentifier])
            {
                [operation cancel];
            }
        }
    }
    
    ANCollectionControllerReloadOperation* op = [ANCollectionControllerReloadOperation reloadOperationWithAnimation:isAnimated];
    op.delegate = self;
    op.name = storageIdentifier;
    [self.queue addOperation:op];
}


@end
