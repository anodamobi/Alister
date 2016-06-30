//
//  ANTableControllerUpdater.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANTableControllerUpdater.h"
#import "ANTableControllerUpdateOperation.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageUpdateOperation.h"
#import "ANStorageUpdateControllerInterface.h"
#import "ANListControllerConfigurationModelInterface.h"
#import "ANTableControllerReloadOperation.h"

@interface ANTableControllerUpdater ()
<
    ANTableControllerUpdateOperationDelegate,
    ANStorageUpdateControllerInterface,
    ANTableControllerReloadOperationDelegate
>

@property (nonatomic, strong) NSOperationQueue* queue;

@end

@implementation ANTableControllerUpdater

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

- (UITableView*)tableView
{
    return [self.delegate tableView];
}

- (id<ANListControllerConfigurationModelInterface>)configurationModel
{
    return [self.delegate configurationModel];
}

- (void)storageDidPerformUpdate:(ANStorageUpdateOperation*)updateOperation withIdentifier:(NSString*)identifier animatable:(BOOL)shouldAnimate
{
    if (shouldAnimate)
    {
        ANTableControllerUpdateOperation* controllerOperation = [ANTableControllerUpdateOperation new];
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
        if ([operation isMemberOfClass:[ANTableControllerUpdateOperation class]] ||
            [operation isMemberOfClass:[ANTableControllerReloadOperation class]])
        {
            if ([operation.name isEqualToString:storageIdentifier])
            {
                [operation cancel];
            }
        }
    }
    
    ANTableControllerReloadOperation* op = [ANTableControllerReloadOperation reloadOperationWithAnimation:isAnimated];
    op.delegate = self;
    op.name = storageIdentifier;
    [self.queue addOperation:op];
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
