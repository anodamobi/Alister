//
//  ANCollectionControllerUpdateOperation.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionControllerUpdateOperation.h"
#import "ANStorageUpdateModel.h"

@interface ANCollectionControllerUpdateOperation ()

@property (nonatomic, strong) ANStorageUpdateModel* updateModel;

@end

@implementation ANCollectionControllerUpdateOperation

+ (instancetype)operationWithUpdateModel:(ANStorageUpdateModel*)model
{
    ANCollectionControllerUpdateOperation* op = [self new];
    op.updateModel = model;
    
    return op;
}


#pragma mark - ANStorageUpdateTableOperationDelegate

- (void)storageUpdateModelGenerated:(ANStorageUpdateModel*)updateModel
{
    self.updateModel = updateModel;
}

- (void)main
{
    if (!self.isCancelled)
    {
        [self _performAnimatedUpdate:self.updateModel];
    }
}


#pragma mark - Private

- (void)_performAnimatedUpdate:(ANStorageUpdateModel*)update
{
    if (update && !update.isEmpty)
    {
        [self.delegate.listView performUpdate:update animated:NO]; //TODO:
    }
}

@end
