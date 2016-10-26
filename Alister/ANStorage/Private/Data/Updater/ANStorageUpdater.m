//
//  ANStorageUpdater.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdater.h"
#import "ANStorageUpdateModel.h"
#import <Alister/ANStorageSectionModel.h>
#import "ANStorageLoader.h"
#import "ANStorageMovedIndexPathModel.h"
#import <Alister/ANStorageModel.h>
#import "ANStorageLog.h"
#import "ANStorageValidator.h"

@interface ANStorageUpdater ()

@property (nonatomic, strong) ANStorageModel* storageModel;
@property (nonatomic, weak) id delegate;

@end

@implementation ANStorageUpdater

+ (instancetype)updaterWithStorageModel:(ANStorageModel*)model delegate:(id)delegate
{
    ANStorageUpdater* updater = [self new];
    updater.storageModel = model;
    updater.delegate = delegate;
    
    return updater;
}

- (ANStorageUpdateModel*)addItem:(id)item
{
    return [self addItem:item toSection:0];
}

- (ANStorageUpdateModel*)addItems:(NSArray*)items
{
    return [self addItems:items toSection:0];
}

- (ANStorageUpdateModel*)addItem:(id)item toSection:(NSUInteger)sectionIndex
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (item)
    {
        update = [self addItems:@[item] toSection:sectionIndex];
    }
    else
    {
        ANStorageLog(@"You trying to add nil item in storage");
    }
    
    return update;
}

- (ANStorageUpdateModel*)addItems:(NSArray*)items toSection:(NSInteger)sectionIndex
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (ANIsIndexValid(sectionIndex) && !ANItemIsEmpty(items) && self.storageModel)
    {
        NSIndexSet* insertedSections = [self createSectionIfNotExist:sectionIndex];
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:self.storageModel];
        
        NSInteger numberOfItems = [section numberOfObjects];
        NSMutableArray* insertedIndexPaths = [NSMutableArray array];
        for (id item in items)
        {
            [section addItem:item];
            [insertedIndexPaths addObject:[NSIndexPath indexPathForRow:numberOfItems
                                                             inSection:sectionIndex]];
            numberOfItems++;
        }
        
        [update addInsertedSectionIndexes:insertedSections];
        [update addInsertedIndexPaths:insertedIndexPaths];
    }
    
    return update;
}

- (ANStorageUpdateModel*)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (indexPath && item && self.storageModel)
    {
        NSIndexSet* insertedSections = [self createSectionIfNotExist:(NSUInteger)indexPath.section];
        
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)indexPath.section inStorage:self.storageModel];
        
        if ([section.objects count] < (NSUInteger)indexPath.row)
        {
            ANStorageLog(@"Failed to insert item for section: %ld, row: %ld, only %lu items in section",
                         (long)indexPath.section,
                         (long)indexPath.row,
                         (unsigned long)[section.objects count]);
        }
        else
        {
            [section insertItem:item atIndex:(NSUInteger)indexPath.row];
            [update addInsertedSectionIndexes:insertedSections];
            [update addInsertedIndexPaths:@[indexPath]];
        }
    }
    
    return update;
}

- (ANStorageUpdateModel*)replaceItem:(id)itemToReplace withItem:(id)replacingItem
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSIndexPath* originalIndexPath = [ANStorageLoader indexPathForItem:itemToReplace inStorage:self.storageModel];
    
    if (originalIndexPath && replacingItem)
    {
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)originalIndexPath.section inStorage:self.storageModel];
        [section replaceItemAtIndex:(NSUInteger)originalIndexPath.row withItem:replacingItem];
        [update addUpdatedIndexPaths:@[originalIndexPath]];
    }
    else
    {
        ANStorageLog(@"ANStorage: failed to replace item %@ at indexPath: %@", replacingItem, originalIndexPath);
    }
    
    return update;
}

- (ANStorageUpdateModel*)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath
                                   toIndexPath:(NSIndexPath*)toIndexPath
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (fromIndexPath && toIndexPath)
    {
        ANStorageSectionModel* fromSection = [ANStorageLoader sectionAtIndex:fromIndexPath.section inStorage:self.storageModel];
        if (fromSection)
        {
            NSIndexSet* insertedSections = [self createSectionIfNotExist:toIndexPath.section];
            
            ANStorageSectionModel* toSection = [ANStorageLoader sectionAtIndex:toIndexPath.section inStorage:self.storageModel];
            id tableItem = [ANStorageLoader itemAtIndexPath:fromIndexPath inStorage:self.storageModel];
            
            [fromSection removeItemAtIndex:(NSUInteger)fromIndexPath.row];
            [toSection insertItem:tableItem atIndex:(NSUInteger)toIndexPath.row]; // TODO: check is successfull operation
            
            ANStorageMovedIndexPathModel* path = [ANStorageMovedIndexPathModel new];
            path.fromIndexPath = fromIndexPath;
            path.toIndexPath = toIndexPath;
            
            [update addInsertedSectionIndexes:insertedSections];
            [update addMovedIndexPaths:@[path]];
        }
    }
    
    return update;
}


#pragma mark - Reload Items

- (ANStorageUpdateModel*)reloadItem:(id)item inStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (item)
    {
        update = [self reloadItems:@[item]];
    }
    
    return update;
}

- (ANStorageUpdateModel*)reloadItems:(NSArray*)items
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSArray* indexPathesArrayToReload = [ANStorageLoader indexPathArrayForItems:items inStorage:self.storageModel];
    if (indexPathesArrayToReload)
    {
        [update addUpdatedIndexPaths:indexPathesArrayToReload];
    }
    
    return update;
}

- (NSIndexSet*)createSectionIfNotExist:(NSInteger)sectionIndex
{
    NSMutableIndexSet* insertedSectionIndexes = [NSMutableIndexSet indexSet];
    if (ANIsIndexValid(sectionIndex) && self.storageModel)
    {
        for (NSUInteger sectionIterator = self.storageModel.sections.count; sectionIterator <= sectionIndex; sectionIterator++)
        {
            [self.storageModel addSection:[ANStorageSectionModel new]];
            [insertedSectionIndexes addIndex:sectionIterator];
        }
    }
    else
    {
        ANStorageLog(@"index for new section is invalid");
    }
    
    return insertedSectionIndexes;
}

@end
