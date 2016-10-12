//
//  ANStorageLoader.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageLoader.h"
#import <Alister/ANStorageModel.h>
#import "ANStorageSectionModelInterface.h"
#import <Alister/ANStorageSectionModel.h>
#import "ANStorageLog.h"

@implementation ANStorageLoader

+ (NSArray*)indexPathArrayForItems:(NSArray*)items inStorage:(ANStorageModel*)storage
{
    NSMutableArray* indexPaths = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < [items count]; i++)
    {
        NSIndexPath* foundIndexPath = [self indexPathForItem:items[i] inStorage:storage];
        if (!foundIndexPath)
        {
            ANStorageLog(@"ANStorage: object %@ not found", items[i]);
        }
        else
        {
            [indexPaths addObject:foundIndexPath];
        }
    }
    return indexPaths;
}

+ (id)itemAtIndexPath:(NSIndexPath*)indexPath inStorage:(ANStorageModel*)storage
{
    id object = nil;
    if ((NSUInteger)indexPath.section < [storage.sections count])
    {
        NSArray* section = [self itemsInSection:(NSUInteger)indexPath.section inStorage:storage];
        if ((NSUInteger)indexPath.row < [section count])
        {
            object = section[(NSUInteger)indexPath.row];
        }
        else
        {
            ANStorageLog(@"ANStorage: Row not found while searching for item");
        }
    }
    else
    {
        ANStorageLog(@"ANStorage: Section not found while searching for item");
    }
    return object;
}

+ (NSIndexPath*)indexPathForItem:(id)item inStorage:(ANStorageModel*)storage
{
    __block NSIndexPath* foundedIndexPath = nil;
    
    [storage.sections enumerateObjectsUsingBlock:^(id<ANStorageSectionModelInterface> obj, NSUInteger sectionIndex, BOOL*stop) {
        
        NSArray* rows = [obj objects];
        NSUInteger index = [rows indexOfObject:item];
        if (index != NSNotFound)
        {
            foundedIndexPath = [NSIndexPath indexPathForRow:(NSInteger)index
                                                  inSection:(NSInteger)sectionIndex];
           * stop = YES;
        }
    }];
    return foundedIndexPath;
}

+ (NSArray*)itemsInSection:(NSUInteger)sectionIndex inStorage:(ANStorageModel*)storage
{
    NSArray* objects = nil;
    if ([storage.sections count] > sectionIndex)
    {
        ANStorageSectionModel* section = storage.sections[sectionIndex];
        objects = [section objects];
    }
    return objects;
}

+ (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex inStorage:(ANStorageModel*)storage
{
    if (storage.sections.count > sectionIndex)
    {
        return storage.sections[sectionIndex];
    }
    else
    {
        ANStorageLog(@"Section index is out of bounds");
    }
    return nil;
}

@end
