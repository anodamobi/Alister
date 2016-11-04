//
//  ANTableControllerUpdateOperation.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerUpdateOperation.h"
#import "ANStorageUpdateModel.h"
#import "ANListControllerLog.h"
#import "ANListViewInterface.h"

@interface ANListControllerUpdateOperation ()

@property (nonatomic, strong) ANStorageUpdateModel* updateModel;
@property (nonatomic, assign, getter=isFinished) BOOL finished;
@property (nonatomic, assign, getter=isExecuting) BOOL executing;

@end

@implementation ANListControllerUpdateOperation

@synthesize finished = _finished;
@synthesize executing = _executing;


#pragma mark - ANStorageUpdateTableOperationDelegate

- (void)storageUpdateModelGenerated:(ANStorageUpdateModel*)updateModel
{
    self.updateModel = updateModel;
}

- (void)start
{
    if (self.isCancelled)
    {
        self.finished = YES;
    }
    else
    {
        self.executing = YES;
        [self main];
    }
}

- (void)main
{
    self.executing = YES;
    if (!self.isCancelled)
    {
        if (self.updateModel && !self.updateModel.isEmpty)
        {
            [self _performAnimatedUpdate:self.updateModel];
        }
        else
        {
            self.finished = YES;
            self.executing = NO;
        }
    }
}


#pragma mark - Private

- (void)_performAnimatedUpdate:(ANStorageUpdateModel*)update
{
    id<ANListControllerUpdateServiceInterface> delegate = self.delegate;
    
    if (!update.isRequireReload)
    {
        @try
        {
            [CATransaction begin];
            [CATransaction setCompletionBlock:^{
                self.finished = YES;
                self.executing = NO;
            }];
            
            [delegate.listView performUpdate:update animated:self.shouldAnimate];
            
            [CATransaction commit];
        }
        
        @catch (NSException *exception)
        {
            ANListControllerLog(@"❌Exception: %@\n❌%@", exception, update);
        }
    }
    else
    {
        self.finished = YES;
        self.executing = NO;
        [delegate storageNeedsReloadWithIdentifier:self.name animated:NO];
    }
}


#pragma mark - Getters / Setters

- (void)setFinished:(BOOL)finished
{
    if (_finished != finished)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        _finished = finished;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    }
}

- (void)setExecuting:(BOOL)executing
{
    if (_executing != executing)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _executing = executing;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    }
}

@end
