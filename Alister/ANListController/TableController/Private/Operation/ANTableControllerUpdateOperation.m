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
    id<ANListControllerUpdateOperationDelegate> delegate = self.delegate;
    UITableView* tableView = (UITableView*)[delegate listView];
    if ([tableView isKindOfClass:[UITableView class]])
    {   
        if (!update.isRequireReload)
        {
            id<ANListControllerConfigurationModelInterface> configurationModel = [delegate configurationModel];
            
            [CATransaction begin];
            [CATransaction setCompletionBlock:^{
                self.finished = YES;
                self.executing = NO;
            }];
            
            UITableViewRowAnimation insertSectionAnimation = UITableViewRowAnimationNone;
            UITableViewRowAnimation deleteSectionAnimation = UITableViewRowAnimationNone;
            UITableViewRowAnimation reloadSectionAnimation = UITableViewRowAnimationNone;
            UITableViewRowAnimation insertRowAnimation = UITableViewRowAnimationNone;
            UITableViewRowAnimation deleteRowAnimation = UITableViewRowAnimationNone;
            UITableViewRowAnimation reloadRowAnimation = UITableViewRowAnimationNone;
            
            if (self.shouldAnimate)
            {
                insertSectionAnimation = configurationModel.insertSectionAnimation;
                deleteSectionAnimation = configurationModel.deleteSectionAnimation;
                reloadSectionAnimation = configurationModel.reloadSectionAnimation;
                insertRowAnimation = configurationModel.insertRowAnimation;
                deleteRowAnimation = configurationModel.deleteRowAnimation;
                reloadRowAnimation = configurationModel.reloadRowAnimation;
            }
            
            [tableView beginUpdates];
            
            [tableView insertSections:update.insertedSectionIndexes withRowAnimation:insertSectionAnimation];
            [tableView deleteSections:update.deletedSectionIndexes withRowAnimation:deleteSectionAnimation];
            [tableView reloadSections:update.updatedSectionIndexes withRowAnimation:reloadSectionAnimation];
            
            [update.movedRowsIndexPaths enumerateObjectsUsingBlock:^(ANStorageMovedIndexPathModel* obj, __unused NSUInteger idx, __unused BOOL *stop) {
                
                if (![update.deletedSectionIndexes containsIndex:(NSUInteger)obj.fromIndexPath.section])
                {
                    [tableView moveRowAtIndexPath:obj.fromIndexPath toIndexPath:obj.toIndexPath];
                }
            }];
            
            [tableView insertRowsAtIndexPaths:update.insertedRowIndexPaths withRowAnimation:insertRowAnimation];
            [tableView deleteRowsAtIndexPaths:update.deletedRowIndexPaths withRowAnimation:deleteRowAnimation];
            [tableView reloadRowsAtIndexPaths:update.updatedRowIndexPaths withRowAnimation:reloadRowAnimation];
            
            [tableView endUpdates];
            [CATransaction commit];
        }
        else
        {
            self.finished = YES;
            self.executing = NO;
            [delegate storageNeedsReloadWithIdentifier:self.name];
        }
    }
    else
    {
        NSAssert(NO, @"You assigned not a UITableView, this item can't be updated");
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
    if (!_executing != executing)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _executing = executing;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    }
}

@end
