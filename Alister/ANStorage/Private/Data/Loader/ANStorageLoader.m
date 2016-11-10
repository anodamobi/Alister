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
    if (storage && indexPath)
    {
        if (indexPath.section < [storage numberOfSections])
        {
            NSArray* sectionItems = [self itemsInSection:indexPath.section inStorage:storage];
            if ((NSUInteger)indexPath.row < [sectionItems count])
            {
                object = sectionItems[(NSUInteger)indexPath.row];
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
    }
    else
    {
        ANStorageLog(@"ANStorage: Storage or indexPath is nil");
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

+ (NSArray*)itemsInSection:(NSInteger)sectionIndex inStorage:(ANStorageModel*)storage
{
    NSArray* objects = nil;
    if ([storage numberOfSections] > sectionIndex)
    {
        ANStorageSectionModel* section = [storage sectionAtIndex:sectionIndex];
        objects = [section objects];
    }
    return objects;
}

+ (ANStorageSectionModel*)sectionAtIndex:(NSInteger)sectionIndex inStorage:(ANStorageModel*)storage
{
    ANStorageSectionModel* model = nil;
    if ((NSInteger)storage.sections.count > sectionIndex)
    {
        model = [storage sectionAtIndex:sectionIndex];
    }
    else
    {
        ANStorageLog(@"Section index is out of bounds");
    }
    return model;
}

+ (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSInteger)sectionIndex inStorage:(ANStorageModel*)storage
{
    ANStorageSectionModel* sectionModel = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:storage];
    return [sectionModel supplementaryModelOfKind:kind];
}

@end
