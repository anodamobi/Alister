//
//  ANListControllerQueueProcessor.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerQueueProcessor.h"
#import "ANStorageUpdateOperation.h"
#import "ANStorageUpdateControllerInterface.h"
#import "ANListControllerUpdateOperationInterface.h"

@interface ANListControllerQueueProcessor () <ANStorageUpdateControllerInterface>

@property (nonatomic, strong) NSOperationQueue* queue;

@end

@implementation ANListControllerQueueProcessor

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.queue = [NSOperationQueue mainQueue];
        self.queue.maxConcurrentOperationCount = 1;
        [self.queue addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(operations))
                        options:NSKeyValueObservingOptionNew
                        context:NULL];
    }
    return self;
}

- (id<ANListControllerConfigurationModelInterface>)configurationModel
{
    return [self.delegate configurationModel];
}

- (void)storageDidPerformUpdate:(ANStorageUpdateOperation*)updateOperation
                 withIdentifier:(NSString*)identifier
                     animatable:(BOOL)shouldAnimate
{
    if (shouldAnimate)
    {
        NSOperation<ANListControllerUpdateOperationInterface>* controllerOperation = [self.updateOperationClass new];
        if ([controllerOperation conformsToProtocol:@protocol(ANListControllerUpdateOperationInterface)])
        {
            [controllerOperation setDelegate:self];
            [controllerOperation setName:identifier];
            updateOperation.controllerOperationDelegate = controllerOperation;
            
            [self _addUpdateOperation:updateOperation withIdentifier:identifier];
            [self.queue addOperation:controllerOperation];
        }
        else
        {
            NSAssert(NO, @"You didn't setup properly @property updateOperationClass");
        }
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
        if ([operation isMemberOfClass:self.updateOperationClass] ||
            [operation isMemberOfClass:self.reloadOperationClass])
        {
            if ([operation.name isEqualToString:storageIdentifier])
            {
                [operation cancel];
            }
        }
    }
    
    NSOperation<ANListControllerUpdateOperationInterface>* controllerOperation = [self.reloadOperationClass new];
    if ([controllerOperation conformsToProtocol:@protocol(ANListControllerUpdateOperationInterface)])
    {
        [controllerOperation setDelegate:self];
        [controllerOperation setName:storageIdentifier];
        [controllerOperation setShouldAnimate:isAnimated];
        [self.queue addOperation:controllerOperation];
    }
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context
{
    NSString* observedKeypath = NSStringFromSelector(@selector(operations));
    if (object == self.queue && keyPath && [keyPath isEqualToString:observedKeypath])
    {
        if ([self.queue.operations count] == 0)
        {
            [self.delegate reloadFinished];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
