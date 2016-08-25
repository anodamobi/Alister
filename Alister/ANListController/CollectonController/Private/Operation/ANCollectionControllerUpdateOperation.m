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
        UICollectionView* collectionView = (UICollectionView*)[self.delegate listView];
        
        if ([collectionView isKindOfClass:[UICollectionView class]])
        {
            NSMutableIndexSet * sectionsToInsert = [NSMutableIndexSet indexSet];
            [update.insertedSectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, __unused BOOL *stop) {
                if ((NSUInteger)[collectionView numberOfSections] <= idx)
                {
                    [sectionsToInsert addIndex:idx];
                }
            }];
            
            NSUInteger sectionChanges = [update.deletedSectionIndexes count] +
            [update.insertedSectionIndexes count] +
            [update.updatedSectionIndexes count];
            
            NSUInteger itemChanges = [update.deletedRowIndexPaths count] +
            [update.insertedRowIndexPaths count] +
            [update.updatedRowIndexPaths count];
            
            if (sectionChanges)
            {
                [collectionView performBatchUpdates:^{
                    [collectionView deleteSections:update.deletedSectionIndexes];
                    [collectionView insertSections:sectionsToInsert];
                    [collectionView reloadSections:update.updatedSectionIndexes];
                } completion:nil];
            }
            
            if ([self _shouldReloadCollectionView:collectionView
           toPreventInsertFirstItemIssueForUpdate:update])
            {
                [collectionView reloadData];
                return;
            }
            
            if ((itemChanges && (sectionChanges == 0)))
            {
                [collectionView performBatchUpdates:^{
                    [collectionView deleteItemsAtIndexPaths:update.deletedRowIndexPaths];
                    [collectionView insertItemsAtIndexPaths:update.insertedRowIndexPaths];
                    [collectionView reloadItemsAtIndexPaths:update.updatedRowIndexPaths];
                } completion:nil];
            }
            
        }
        else
        {
            NSAssert(NO, @"You assigned not a UICollectionView");
        }
    }
}

#pragma mark - workarounds

// This is to prevent a bug in UICollectionView from occurring.
// The bug presents itself when inserting the first object or deleting the last object in a collection view.
// http://stackoverflow.com/questions/12611292/uicollectionview-assertion-failure
// http://stackoverflow.com/questions/13904049/assertion-failure-in-uicollectionviewdata-indexpathforitematglobalindex
// This code should be removed once the bug has been fixed, it is tracked in OpenRadar
// http://openradar.appspot.com/12954582
- (BOOL)_shouldReloadCollectionView:(UICollectionView*)collectionView
toPreventInsertFirstItemIssueForUpdate:(ANStorageUpdateModel*)update
{
    BOOL shouldReload = NO;
    
    for (NSIndexPath* indexPath in update.insertedRowIndexPaths)
    {
        if ([collectionView numberOfItemsInSection:indexPath.section] == 0)
        {
            shouldReload = YES;
        }
    }
    
    for (NSIndexPath* indexPath in update.deletedRowIndexPaths)
    {
        if ([collectionView numberOfItemsInSection:indexPath.section] == 1)
        {
            shouldReload = YES;
        }
    }
    
    if (collectionView.window == nil)
    {
        shouldReload = YES;
    }
    return shouldReload;
}

//#pragma mark - Getters / Setters
//
//- (void)setFinished:(BOOL)finished
//{
//    if (_finished != finished)
//    {
//        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
//        _finished = finished;
//        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
//    }
//}
//
//- (void)setExecuting:(BOOL)executing
//{
//    if (!_executing != executing)
//    {
//        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
//        _executing = executing;
//        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
//    }
//}

@end
