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

@end

@implementation ANStorageUpdateOperation

+ (instancetype)operationWithExecutionBlock:(ANStorageUpdateOperationConfigurationBlock)executionBlock
{
    ANStorageUpdateOperation* operation = [self new];
    operation.configurationBlock = [executionBlock copy];
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
        ANStorageUpdateModel* updateModel = [self mergeUpdates];
        if (updateModel.isRequireReload)
        {
            [self.updaterDelegate updateStorageOperationRequiresForceReload:self];
        }
        else
        {
            [self.controllerOperationDelegate storageUpdateModelGenerated:[self mergeUpdates]];
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

- (ANStorageUpdateModel*)mergeUpdates
{
    __block ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    [self.updates enumerateObjectsUsingBlock:^(ANStorageUpdateModel*  _Nonnull obj, __unused NSUInteger idx, __unused BOOL * _Nonnull stop) {
        [update mergeWith:obj];
    }];
    
    return update;
}

@end
