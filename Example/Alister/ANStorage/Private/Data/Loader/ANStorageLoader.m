//
//  ANStorageLoader.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageLoader.h"
#import "ANStorageModel.h"
#import "ANStorageSectionModelInterface.h"
#import "ANStorageSectionModel.h"

@implementation ANStorageLoader

+ (NSArray*)indexPathArrayForItems:(NSArray*)items inStorage:(ANStorageModel*)storage
{
    NSMutableArray* indexPaths = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [items count]; i++)
    {
        NSIndexPath* foundIndexPath = [self indexPathForItem:[items objectAtIndex:i] inStorage:storage];
        if (!foundIndexPath)
        {
            NSLog(@"ANStorage: object %@ not found", [items objectAtIndex:i]);
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
    if (indexPath.section < [storage.sections count])
    {
        NSArray* section = [self itemsInSection:indexPath.section inStorage:storage];
        if (indexPath.row < [section count])
        {
            object = [section objectAtIndex:indexPath.row];
        }
        else
        {
            NSLog(@"ANStorage: Row not found while searching for item");
        }
    }
    else
    {
        NSLog(@"ANStorage: Section not found while searching for item");
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
            foundedIndexPath = [NSIndexPath indexPathForRow:index inSection:sectionIndex];
            *stop = YES;
        }
    }];
    return foundedIndexPath;
}

+ (NSArray*)itemsInSection:(NSUInteger)sectionNumber inStorage:(ANStorageModel*)storage
{
    NSArray* objects;
    if ([storage.sections count] > sectionNumber)
    {
        ANStorageSectionModel* section = storage.sections[sectionNumber];
        objects = [section objects];
    }
    return objects;
}

+ (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex inStorage:(ANStorageModel*)storage
{
    if (storage.sections.count > sectionIndex)
    {
        return [storage.sections objectAtIndex:sectionIndex];
    }
    else
    {
        NSLog(@"Section index is out of bounds");
    }
    return nil;
}

@end
