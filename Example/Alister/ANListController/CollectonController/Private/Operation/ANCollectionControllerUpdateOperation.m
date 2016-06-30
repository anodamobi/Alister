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
    if (!update.isEmpty)
    {
        UICollectionView* collectionView = [self.delegate collectionView];
        
        NSMutableIndexSet * sectionsToInsert = [NSMutableIndexSet indexSet];
        [update.insertedSectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            if ([collectionView numberOfSections] <= idx)
            {
                [sectionsToInsert addIndex:idx];
            }
        }];
        
        NSInteger sectionChanges = [update.deletedSectionIndexes count] + [update.insertedSectionIndexes count] + [update.updatedSectionIndexes count];
        NSInteger itemChanges = [update.deletedRowIndexPaths count] + [update.insertedRowIndexPaths count] + [update.updatedRowIndexPaths count];
        
        if (sectionChanges)
        {
            [collectionView performBatchUpdates:^{
                [collectionView deleteSections:update.deletedSectionIndexes];
                [collectionView insertSections:sectionsToInsert];
                [collectionView reloadSections:update.updatedSectionIndexes];
            } completion:nil];
        }
        
        if ([self _shouldReloadCollectionViewToPreventInsertFirstItemIssueForUpdate:update])
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
}


#pragma mark - workarounds

// This is to prevent a bug in UICollectionView from occurring.
// The bug presents itself when inserting the first object or deleting the last object in a collection view.
// http://stackoverflow.com/questions/12611292/uicollectionview-assertion-failure
// http://stackoverflow.com/questions/13904049/assertion-failure-in-uicollectionviewdata-indexpathforitematglobalindex
// This code should be removed once the bug has been fixed, it is tracked in OpenRadar
// http://openradar.appspot.com/12954582
- (BOOL)_shouldReloadCollectionViewToPreventInsertFirstItemIssueForUpdate:(ANStorageUpdateModel*)update
{
    BOOL shouldReload = NO;
    UICollectionView* collectionView = [self.delegate collectionView];
    
    for (NSIndexPath * indexPath in update.insertedRowIndexPaths)
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

@end