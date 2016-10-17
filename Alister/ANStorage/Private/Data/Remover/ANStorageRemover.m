//
//  ANStorageRemover.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageRemover.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageLoader.h"
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageSectionModel.h>
#import "ANStorageLog.h"

@implementation ANStorageRemover

+ (ANStorageUpdateModel*)removeItem:(id)item fromStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSIndexPath* indexPath = [ANStorageLoader indexPathForItem:item inStorage:storage];
    
    if (indexPath)
    {
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)indexPath.section inStorage:storage];
        [section removeItemAtIndex:(NSUInteger)indexPath.row];
        [update addDeletedIndexPaths:@[indexPath]];
    }
    else
    {
        ANStorageLog(@"ANStorage: item to delete: %@ was not found", item);
    }
    
    return update;
}

+ (ANStorageUpdateModel*)removeItemsAtIndexPaths:(NSSet*)indexPaths fromStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];

    NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(compare:)];
    NSArray* indexPathsArray = [[indexPaths allObjects] sortedArrayUsingDescriptors:@[sort]];
    
    [indexPathsArray enumerateObjectsUsingBlock:^(NSIndexPath*  _Nonnull indexPath, __unused NSUInteger idx, __unused BOOL*  _Nonnull stop) {
        id object = [ANStorageLoader itemAtIndexPath:indexPath inStorage:storage];
        if (object)
        {
            ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)indexPath.section
                                                                   inStorage:storage];
            [section removeItemAtIndex:(NSUInteger)indexPath.row];
            [update addDeletedIndexPaths:@[indexPath]];
        }
        else
        {
            ANStorageLog(@"ANStorage: item to delete was not found at indexPath : %@ ", indexPath);
        }
    }];
    
    return update;
}

+ (ANStorageUpdateModel*)removeItems:(NSSet*)items fromStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSMutableArray* indexPaths = [NSMutableArray array];
    
    NSArray* sortedItemsArray = [[[items allObjects] reverseObjectEnumerator] allObjects];
    
    [sortedItemsArray enumerateObjectsUsingBlock:^(id  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath* indexPath = [ANStorageLoader indexPathForItem:item inStorage:storage];
        if (indexPath)
        {
            ANStorageSectionModel* section = [storage sectionAtIndex:(NSUInteger)indexPath.section];
            [section removeItemAtIndex:(NSUInteger)indexPath.row];
            [indexPaths addObject:indexPath];
        }
    }];
    
    [update addDeletedIndexPaths:indexPaths];
    
    return update;
}

+ (ANStorageUpdateModel*)removeAllItemsAndSectionsFromStorage:(ANStorageModel*)storage
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if ([storage sections].count)
    {
        [storage removeAllSections];
        update.isRequireReload = YES;
    }
    
    return update;
}

+ (ANStorageUpdateModel*)removeSections:(NSIndexSet*)indexSet fromStorage:(ANStorageModel*)storage
{
    __block ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    
    for (NSInteger reversedCounter = storage.sections.count - 1; reversedCounter >= 0; reversedCounter--)
    {
        if ([indexSet containsIndex:reversedCounter])
        {
            [storage removeSectionAtIndex:reversedCounter];
            [update addDeletedSectionIndex:reversedCounter];
        }
    }
    
    return update;
}

@end
