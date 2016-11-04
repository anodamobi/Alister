//
//  ANListControllerQueueProcessor.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerQueueProcessor.h"
#import "ANStorageUpdateOperation.h"
#import "ANListControllerUpdateOperationInterface.h"
#import "ANListControllerReloadOperation.h"
#import "ANListControllerConfigurationModel.h"
#import "ANListControllerQueueProcessorInterface.h"

@interface ANListControllerQueueProcessor ()
<
    ANListControllerQueueProcessorInterface,
    ANListControllerReloadOperationDelegate
>

@property (nonatomic, strong) NSOperationQueue* queue;
@property (nonatomic, strong, readonly) Class updateOperationClass;
@property (nonatomic, strong, readonly) id<ANListViewInterface> listView;

@end

@implementation ANListControllerQueueProcessor

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

- (void)registerUpdateOperationClass:(Class)operationClass
{
    _updateOperationClass = operationClass;
}


#pragma mark - ANStorageUpdatingInterface

- (void)storageDidPerformUpdate:(ANStorageUpdateOperation*)updateOperation
                 withIdentifier:(NSString*)identifier
                     animatable:(BOOL)shouldAnimate
{
    NSOperation<ANListControllerUpdateOperationInterface>* controllerOperation = [self.updateOperationClass new];
    if ([controllerOperation conformsToProtocol:@protocol(ANListControllerUpdateOperationInterface)])
    {
        [controllerOperation setDelegate:self];
        [controllerOperation setName:identifier];
        [controllerOperation setShouldAnimate:shouldAnimate];
        updateOperation.controllerOperationDelegate = controllerOperation;
        
        [self _addUpdateOperation:updateOperation withIdentifier:identifier];
        [self.queue addOperation:controllerOperation];
    }
    else
    {
        NSAssert(NO, @"You didn't setup properly @property updateOperationClass");
    }

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
        if ([operation isMemberOfClass:self.updateOperationClass] ||
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

- (id<ANListControllerConfigurationModelInterface>)configurationModel
{
    if (!_configModel)
    {
        _configModel = [ANListControllerConfigurationModel defaultModel];
    }
    return _configModel;
}

@end
