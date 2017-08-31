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
#import "ANStorageLog.h"

@interface ANStorageRemover ()

@property (nonatomic, strong) ANStorageModel* storageModel; //HOTFIX:

@end

@implementation ANStorageRemover

+ (instancetype)removerWithStorageModel:(ANStorageModel*)storageModel
{
    ANStorageRemover* remover = [self new];
    remover.storageModel = storageModel;
    
    return remover;
}

- (void)removeItem:(id)item
{
    ANStorageModel* storage = self.storageModel;
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSIndexPath* indexPath = [ANStorageLoader indexPathForItem:item inStorage:storage];
    
    if (indexPath)
    {
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:indexPath.section inStorage:storage];
        [section removeItemAtIndex:indexPath.row];
        [update addDeletedIndexPaths:@[indexPath]];
    }
    else
    {
        ANStorageLog(@"ANStorage: item to delete: %@ was not found", item);
    }
    
    [self.updateDelegate collectUpdate:update];
}

- (void)removeItemsAtIndexPaths:(NSSet*)indexPaths
{
    ANStorageModel* storage = self.storageModel;
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];

    NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(compare:)];
    NSArray* indexPathsArray = [[indexPaths allObjects] sortedArrayUsingDescriptors:@[sort]];
    
    [indexPathsArray enumerateObjectsUsingBlock:^(NSIndexPath*  _Nonnull indexPath, __unused NSUInteger idx, __unused BOOL*  _Nonnull stop) {
        id object = [ANStorageLoader itemAtIndexPath:indexPath inStorage:storage];
        if (object)
        {
            ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:indexPath.section
                                                                   inStorage:storage];
            [section removeItemAtIndex:indexPath.row];
            [update addDeletedIndexPaths:@[indexPath]];
        }
        else
        {
            ANStorageLog(@"ANStorage: item to delete was not found at indexPath : %@ ", indexPath);
        }
    }];
    
    [self.updateDelegate collectUpdate:update];
}

- (void)removeItems:(NSSet*)items
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    ANStorageModel* storage = self.storageModel;
    NSMutableArray* indexPaths = [NSMutableArray array];
    
    [items.allObjects enumerateObjectsUsingBlock:^(id  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSIndexPath* indexPath = [ANStorageLoader indexPathForItem:item inStorage:storage];
        if (indexPath)
        {
            [indexPaths addObject:indexPath];
        }
    }];
    
    [indexPaths sortUsingSelector:@selector(compare:)];
    NSArray* reversed = [[indexPaths reverseObjectEnumerator] allObjects];
    
    [reversed enumerateObjectsUsingBlock:^(NSIndexPath*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ANStorageSectionModel* section = [storage sectionAtIndex:obj.section];
        [section removeItemAtIndex:obj.row];
    }];
    
    [update addDeletedIndexPaths:indexPaths];
    
    [self.updateDelegate collectUpdate:update];
}

- (void)removeAllItemsAndSections
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    ANStorageModel* storage = self.storageModel;
    if ([storage sections].count)
    {
        [storage removeAllSections];
        update.isRequireReload = YES;
    }
    
    [self.updateDelegate collectUpdate:update];
}

- (void)removeSections:(NSIndexSet*)indexSet
{
    __block ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    ANStorageModel* storage = self.storageModel;
    
    for (NSInteger counter = [storage numberOfSections] - 1; counter >= 0; counter --)
    {
        if ([indexSet containsIndex:(NSUInteger)counter])
        {
            [storage removeSectionAtIndex:counter];
            [update addDeletedSectionIndex:(NSUInteger)counter];
        }
    }

    [self.updateDelegate collectUpdate:update];
}

@end
