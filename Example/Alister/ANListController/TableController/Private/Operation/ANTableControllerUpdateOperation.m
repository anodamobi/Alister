//
//  ANTableControllerUpdateOperation.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANTableControllerUpdateOperation.h"
#import "ANStorageUpdateModel.h"
#import "ANListControllerConfigurationModelInterface.h"

@interface ANTableControllerUpdateOperation ()

@property (nonatomic, strong) ANStorageUpdateModel* updateModel;
@property (nonatomic, assign, getter=isFinished) BOOL finished;
@property (nonatomic, assign, getter=isExecuting) BOOL executing;

@end

@implementation ANTableControllerUpdateOperation

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
        if (!self.updateModel.isEmpty)
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
    UITableView* tableView = [self.delegate tableView];
    if (!update.isRequireReload)
    {
        id<ANListControllerConfigurationModelInterface> configurationModel = [self.delegate configurationModel];

        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            self.finished = YES;
            self.executing = NO;
        }];
        
        [tableView beginUpdates];
        
        [tableView insertSections:update.insertedSectionIndexes
                 withRowAnimation:configurationModel.insertSectionAnimation];
        
        [tableView deleteSections:update.deletedSectionIndexes
                 withRowAnimation:configurationModel.deleteSectionAnimation];
        
        [tableView reloadSections:update.updatedSectionIndexes
                 withRowAnimation:configurationModel.reloadSectionAnimation];
        
        [update.movedRowsIndexPaths enumerateObjectsUsingBlock:^(ANStorageMovedIndexPathModel* obj, NSUInteger idx, BOOL *stop) {
            
            if (![update.deletedSectionIndexes containsIndex:obj.fromIndexPath.section])
            {
                [tableView moveRowAtIndexPath:obj.fromIndexPath toIndexPath:obj.toIndexPath];
            }
        }];
        
        [tableView insertRowsAtIndexPaths:update.insertedRowIndexPaths
                         withRowAnimation:configurationModel.insertRowAnimation];
        
        [tableView deleteRowsAtIndexPaths:update.deletedRowIndexPaths
                         withRowAnimation:configurationModel.deleteRowAnimation];
        
        [tableView reloadRowsAtIndexPaths:update.updatedRowIndexPaths
                         withRowAnimation:configurationModel.reloadRowAnimation];
        
        [tableView endUpdates];
        [CATransaction commit];
    }
    else
    {
        self.finished = YES;
        self.executing = NO;
        [self.delegate storageNeedsReloadWithIdentifier:self.name];
    }
}


#pragma mark - Getters / Setters

- (void)setFinished:(BOOL)finished
{
    if (_finished != finished)
    {
        [self willChangeValueForKey:@"isFinished"];
        _finished = finished;
        [self didChangeValueForKey:@"isFinished"];
    }
}

- (void)setExecuting:(BOOL)executing
{
    if (!_executing != executing)
    {
        [self willChangeValueForKey:@"isExecuting"];
        _executing = executing;
        [self didChangeValueForKey:@"isExecuting"];
    }
}

@end
