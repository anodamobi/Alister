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
#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"
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
    
    [indexPathsArray enumerateObjectsUsingBlock:^(NSIndexPath*  _Nonnull indexPath, __unused NSUInteger idx, __unused BOOL * _Nonnull stop) {
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
    
    [items enumerateObjectsUsingBlock:^(id  _Nonnull item, __unused BOOL * _Nonnull stop) {
       
        NSIndexPath* indexPath = [ANStorageLoader indexPathForItem:item inStorage:storage];
        if (indexPath)
        {
            ANStorageSectionModel* section = [storage sectionAtIndex:(NSUInteger)indexPath.section];
            [section removeItemAtIndex:(NSUInteger)indexPath.row];
        }
    }];
    
    [update addDeletedIndexPaths:indexPaths];
    return update;
}

+ (ANStorageUpdateModel*)removeAllItemsFromStorage:(ANStorageModel*)storage
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
    
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, __unused BOOL * _Nonnull stop) {
        
        if (storage.sections.count > idx)
        {
            [storage removeSectionAtIndex:idx];
            [update addDeletedSectionIndex:idx];
        }
    }];
    return update;
}

@end
