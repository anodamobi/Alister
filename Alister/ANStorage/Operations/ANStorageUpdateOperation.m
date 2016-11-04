//
//  ANStorageUpdateController.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdateOperation.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageLog.h"

@interface ANStorageUpdateOperation ()

@property (nonatomic, strong) NSMutableArray* updates;
@property (nonatomic, copy) ANStorageUpdateOperationConfigurationBlock configurationBlock;

- (ANStorageUpdateModel*)_mergeUpdates;

@end

@implementation ANStorageUpdateOperation

+ (instancetype)operationWithConfigurationBlock:(ANStorageUpdateOperationConfigurationBlock)configBlock
{
    ANStorageUpdateOperation* operation = [self new];
    operation.configurationBlock = [configBlock copy];
    return operation;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.updates = [NSMutableArray new];
    }
    return self;
}

- (void)main
{
    if (!self.isCancelled)
    {
        if (self.configurationBlock)
        {
            __weak typeof(self) welf = self;
            self.configurationBlock(welf);
        }
        ANStorageUpdateModel* updateModel = [self _mergeUpdates];
        
        if (updateModel.isRequireReload)
        {
            [self.updaterDelegate storageNeedsReloadWithIdentifier:self.name animated:NO];
        }
        else
        {
            [self.controllerOperationDelegate storageUpdateModelGenerated:updateModel];
        }
    }
}

- (void)collectUpdate:(ANStorageUpdateModel*)model
{
    if (model && ![model isEmpty])
    {
        [self.updates addObject:model];
    }
    else
    {
        ANStorageLog(@"update is empty or nil, skipped");
    }
}


#pragma mark - Private

- (ANStorageUpdateModel*)_mergeUpdates
{
    __block ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    [self.updates enumerateObjectsUsingBlock:^(ANStorageUpdateModel*  _Nonnull obj,
                                               __unused NSUInteger idx,
                                               __unused BOOL*  _Nonnull stop) {
        [update mergeWith:obj];
    }];
    
    return update;
}

- (void)setUpdaterDelegate:(id<ANListControllerQueueProcessorInterface>)updaterDelegate
{
    if ([updaterDelegate conformsToProtocol:@protocol(ANListControllerQueueProcessorInterface)] || !updaterDelegate)
    {
        _updaterDelegate = updaterDelegate;
    }
    else
    {
        NSAssert(NO, @"Delegate must conform to protocol");
    }
}

- (void)setControllerOperationDelegate:(id<ANStorageListUpdateOperationInterface>)controllerOperationDelegate
{
    if ([controllerOperationDelegate conformsToProtocol:@protocol(ANStorageListUpdateOperationInterface)] ||
        !controllerOperationDelegate)
    {
        _controllerOperationDelegate = controllerOperationDelegate;
    }
    else
    {
        NSAssert(NO, @"Delegate must conform to protocol");
    }
}

@end
