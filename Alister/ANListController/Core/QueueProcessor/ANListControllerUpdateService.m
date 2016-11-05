//
//  ANListControllerQueueProcessor.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerUpdateService.h"
#import "ANListControllerUpdateServiceInterface.h"

//operations
#import "ANStorageUpdateOperation.h"
#import "ANListControllerReloadOperation.h"
#import "ANListControllerUpdateOperation.h"

@interface ANListControllerUpdateService () <ANListControllerUpdateServiceInterface>

@property (nonatomic, strong) NSOperationQueue* queue;
@property (nonatomic, strong, readonly) id<ANListViewInterface> listView;

@end

@implementation ANListControllerUpdateService

- (instancetype)initWithListView:(id<ANListViewInterface>)listView
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
        
        _listView = listView;
    }
    return self;
}

- (void)dealloc
{
    [self.queue removeObserver:self forKeyPath:NSStringFromSelector(@selector(operations))];
}


#pragma mark - ANStorageUpdatingInterface

- (void)storageDidPerformUpdate:(ANStorageUpdateOperation*)updateOperation
                 withIdentifier:(NSString*)identifier
                     animatable:(BOOL)shouldAnimate
{
    ANListControllerUpdateOperation* controllerOperation = [ANListControllerUpdateOperation new];
    controllerOperation.delegate = self;
    controllerOperation.name = identifier;
    controllerOperation.shouldAnimate = shouldAnimate;
    
    updateOperation.controllerOperationDelegate = controllerOperation;
    
    [self _addUpdateOperation:updateOperation withIdentifier:identifier];
    [self.queue addOperation:controllerOperation];
}

- (void)storageNeedsReloadWithIdentifier:(NSString*)identifier animated:(BOOL)shouldAnimate
{
    [self _reloadStorageWithAnimation:shouldAnimate identifier:identifier];
}


#pragma mark - ANListControllerUpdateOperationDelegate

- (void)storageNeedsReloadWithIdentifier:(NSString*)identifier
{
    [self _reloadStorageWithAnimation:NO identifier:identifier];
}


#pragma mark - ANStorageUpdateControllerInterface

- (void)updateStorageOperationRequiresForceReload:(ANStorageUpdateOperation*)operation
{
    [self _reloadStorageWithAnimation:NO identifier:operation.name];
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
        if ([operation isMemberOfClass:[ANListControllerUpdateOperation class]] ||
            [operation isMemberOfClass:[ANListControllerReloadOperation class]])
        {
            if ([operation.name isEqualToString:storageIdentifier])
            {
                [operation cancel];
            }
        }
    }
    
    ANListControllerReloadOperation* controllerOperation = [ANListControllerReloadOperation new];
    controllerOperation.delegate = self;
    controllerOperation.name = storageIdentifier;
    controllerOperation.shouldAnimate = isAnimated;
    [self.queue addOperation:controllerOperation];
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
            [self.delegate allUpdatesFinished];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end