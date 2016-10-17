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
#import "ANHelperFunctions.h"

@implementation ANStorageUpdater

+ (ANStorageUpdateModel*)addItem:(id)item toStorage:(ANStorageModel*)model
{
    return [self addItem:item toSection:0 toStorage:model];
}

+ (ANStorageUpdateModel*)addItems:(NSArray*)items toStorage:(ANStorageModel*)model
{
    return [self addItems:items toSection:0 toStorage:model];
}

+ (ANStorageUpdateModel*)addItem:(id)item toSection:(NSUInteger)sectionIndex toStorage:(ANStorageModel*)model
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (item)
    {
        update = [self addItems:@[item] toSection:sectionIndex toStorage:model];
    }
    else
    {
        ANStorageLog(@"You trying to add nil item in storage");
    }
    
    return update;
}

+ (ANStorageUpdateModel*)addItems:(NSArray*)items toSection:(NSInteger)sectionIndex toStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (ANIsIndexValid(sectionIndex) && !ANIsEmpty(items) && storage)
    {
        NSIndexSet* insertedSections = [self createSectionIfNotExist:sectionIndex inStorage:storage];
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
        
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

+ (ANStorageUpdateModel*)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath toStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (indexPath && item && storage)
    {
        NSIndexSet* insertedSections = [self createSectionIfNotExist:(NSUInteger)indexPath.section
                                                           inStorage:storage];
        
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)indexPath.section
                                                               inStorage:storage];
        
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

+ (ANStorageUpdateModel*)replaceItem:(id)itemToReplace withItem:(id)replacingItem inStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSIndexPath* originalIndexPath = [ANStorageLoader indexPathForItem:itemToReplace inStorage:storage];
    
    if (originalIndexPath && replacingItem)
    {
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)originalIndexPath.section inStorage:storage];
        [section replaceItemAtIndex:(NSUInteger)originalIndexPath.row withItem:replacingItem];
        [update addUpdatedIndexPaths:@[originalIndexPath]];
    }
    else
    {
        ANStorageLog(@"ANStorage: failed to replace item %@ at indexPath: %@", replacingItem, originalIndexPath);
    }
    
    return update;
}

+ (ANStorageUpdateModel*)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath
                                   toIndexPath:(NSIndexPath*)toIndexPath
                                     inStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (fromIndexPath && toIndexPath)
    {
        ANStorageSectionModel* fromSection = [ANStorageLoader sectionAtIndex:fromIndexPath.section
                                                                   inStorage:storage];
        if (fromSection)
        {
            NSIndexSet* insertedSections = [self createSectionIfNotExist:toIndexPath.section
                                                               inStorage:storage];
            
            ANStorageSectionModel* toSection = [ANStorageLoader sectionAtIndex:toIndexPath.section
                                                                     inStorage:storage];
            id tableItem = [ANStorageLoader itemAtIndexPath:fromIndexPath inStorage:storage];
            
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

+ (ANStorageUpdateModel*)reloadItem:(id)item inStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (item)
    {
        update = [self reloadItems:@[item] inStorage:storage];
    }
    
    return update;
}

+ (ANStorageUpdateModel*)reloadItems:(NSArray*)items inStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSArray* indexPathesArrayToReload = [ANStorageLoader indexPathArrayForItems:items inStorage:storage];
    if (indexPathesArrayToReload)
    {
        [update addUpdatedIndexPaths:indexPathesArrayToReload];
    }
    
    return update;
}

+ (NSIndexSet*)createSectionIfNotExist:(NSInteger)sectionIndex inStorage:(ANStorageModel*)storage
{
    NSMutableIndexSet* insertedSectionIndexes = [NSMutableIndexSet indexSet];
    if (ANIsIndexValid(sectionIndex) && storage)
    {
        for (NSUInteger sectionIterator = storage.sections.count; sectionIterator <= sectionIndex; sectionIterator++)
        {
            [storage addSection:[ANStorageSectionModel new]];
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
