//
//  ANStorageUpdater.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdater.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageSectionModel.h"
#import "ANStorageLoader.h"
#import "ANStorageMovedIndexPathModel.h"
#import "ANStorageModel.h"
#import "ANStorageLog.h"
#import "ANStorageConstants.h"

@implementation ANStorageUpdater

+ (ANStorageUpdateModel*)addItem:(id)item toStorage:(ANStorageModel*)model
{
    return [self addItem:item toSection:0 toStorage:model];
}

+ (ANStorageUpdateModel*)addItems:(NSArray*)items toStorage:(ANStorageModel*)model
{
    return [self addItems:items toSection:0 toStorage:model];
}

+ (ANStorageUpdateModel*)addItem:(id)item toSection:(NSUInteger)sectionNumber toStorage:(ANStorageModel*)model
{
    if (item)
    {
        return [self addItems:@[item] toSection:sectionNumber toStorage:model];
    }
    return nil;
}

+ (ANStorageUpdateModel*)addItems:(NSArray*)items toSection:(NSUInteger)sectionNumber toStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (items && items.count)
    {
        NSIndexSet* insertedSections = [self createSectionIfNotExist:sectionNumber inStorage:storage];
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:sectionNumber inStorage:storage];
        
        NSUInteger numberOfItems = [section numberOfObjects];
        NSMutableArray* insertedIndexPaths = [NSMutableArray array];
        for (id item in items)
        {
            [section addItem:item];
            [insertedIndexPaths addObject:[NSIndexPath indexPathForRow:(NSInteger)numberOfItems
                                                             inSection:(NSInteger)sectionNumber]];
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
    if (indexPath)
    {
        NSIndexSet* insertedSections = [self createSectionIfNotExist:(NSUInteger)indexPath.section
                                                           inStorage:storage];
        
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)indexPath.section
                                                               inStorage:storage];
        
        if ([section.objects count] < (NSUInteger)indexPath.row)
        {
            ANStorageLog(@"Dailed to insert item for section: %ld, row: %ld, only %lu items in section",
                         (long)indexPath.section,
                         (long)indexPath.row,
                         (unsigned long)[section.objects count]);
            return update;
        }
        [section insertItem:item atIndex:(NSUInteger)indexPath.row];
        
        [update addInsertedSectionIndexes:insertedSections];
        [update addInsertedIndexPaths:@[indexPath]];
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
        ANStorageSectionModel* fromSection = [ANStorageLoader sectionAtIndex:(NSUInteger)fromIndexPath.section
                                                                   inStorage:storage];
        if (fromSection)
        {
            NSIndexSet* insertedSections = [self createSectionIfNotExist:(NSUInteger)toIndexPath.section
                                                               inStorage:storage];
            
            ANStorageSectionModel* toSection = [ANStorageLoader sectionAtIndex:(NSUInteger)toIndexPath.section
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
    NSIndexPath* indexPathToReload = [ANStorageLoader indexPathForItem:item inStorage:storage];
    if (indexPathToReload)
    {
        [update addUpdatedIndexPaths:@[indexPathToReload]];
    }
    return update;
}

+ (ANStorageUpdateModel*)reloadItems:(id)items inStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSArray* indexPathesArrayToReload = [ANStorageLoader indexPathArrayForItems:items inStorage:storage];
    if (indexPathesArrayToReload)
    {
        [update addUpdatedIndexPaths:indexPathesArrayToReload];
    }
    return update;
}

+ (NSIndexSet*)createSectionIfNotExist:(NSUInteger)sectionNumber inStorage:(ANStorageModel*)storage
{
     NSMutableIndexSet* insertedSectionIndexes = [NSMutableIndexSet indexSet];
    if (sectionNumber < ANStorageMaxItemsCount)
    {
        for (NSUInteger sectionIterator = storage.sections.count; sectionIterator <= sectionNumber; sectionIterator++)
        {
            [storage addSection:[ANStorageSectionModel new]];
            [insertedSectionIndexes addIndex:sectionIterator];
        }
    }
    else
    {
        NSAssert(NO, @"Section number is too big %lu, check is everything ok? please submit issue", (unsigned long)sectionNumber);
    }
    
    return insertedSectionIndexes;
}

@end
