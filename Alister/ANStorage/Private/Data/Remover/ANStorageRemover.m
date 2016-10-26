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

@interface ANStorageRemover ()

@property (nonatomic, weak) ANStorageModel* storageModel;
@property (nonatomic, weak) id delegate;

@end

@implementation ANStorageRemover

+ (instancetype)removerWithStorageModel:(ANStorageModel*)storageModel andUpdateDelegate:(id)delegate
{
    ANStorageRemover* remover = [self new];
    remover.storageModel = storageModel;
    remover.delegate = delegate;
    
    return remover;
}

- (ANStorageUpdateModel*)removeItem:(id)item
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSIndexPath* indexPath = [ANStorageLoader indexPathForItem:item inStorage:self.storageModel];
    
    if (indexPath)
    {
        ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)indexPath.section inStorage:self.storageModel];
        [section removeItemAtIndex:(NSUInteger)indexPath.row];
        [update addDeletedIndexPaths:@[indexPath]];
    }
    else
    {
        ANStorageLog(@"ANStorage: item to delete: %@ was not found", item);
    }
    
    return update;
}

- (ANStorageUpdateModel*)removeItemsAtIndexPaths:(NSSet*)indexPaths
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];

    NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(compare:)];
    NSArray* indexPathsArray = [[indexPaths allObjects] sortedArrayUsingDescriptors:@[sort]];
    
    [indexPathsArray enumerateObjectsUsingBlock:^(NSIndexPath*  _Nonnull indexPath, __unused NSUInteger idx, __unused BOOL*  _Nonnull stop) {
        id object = [ANStorageLoader itemAtIndexPath:indexPath inStorage:self.storageModel];
        if (object)
        {
            ANStorageSectionModel* section = [ANStorageLoader sectionAtIndex:(NSUInteger)indexPath.section
                                                                   inStorage:self.storageModel];
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

- (ANStorageUpdateModel*)removeItems:(NSSet*)items
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSMutableArray* indexPaths = [NSMutableArray array];
    
    NSArray* sortedItemsArray = [[[items allObjects] reverseObjectEnumerator] allObjects];
    
    [sortedItemsArray enumerateObjectsUsingBlock:^(id  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath* indexPath = [ANStorageLoader indexPathForItem:item inStorage:self.storageModel];
        if (indexPath)
        {
            ANStorageSectionModel* section = [self.storageModel sectionAtIndex:(NSUInteger)indexPath.section];
            [section removeItemAtIndex:(NSUInteger)indexPath.row];
            [indexPaths addObject:indexPath];
        }
    }];
    
    [update addDeletedIndexPaths:indexPaths];
    
    return update;
}

- (ANStorageUpdateModel*)removeAllItemsAndSections
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if ([self.storageModel sections].count)
    {
        [self.storageModel removeAllSections];
        update.isRequireReload = YES;
    }
    
    return update;
}

- (ANStorageUpdateModel*)removeSections:(NSIndexSet*)indexSet
{
    __block ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    
    for (NSInteger reversedCounter = self.storageModel.sections.count - 1; reversedCounter >= 0; reversedCounter--)
    {
        if ([indexSet containsIndex:reversedCounter])
        {
            [self.storageModel removeSectionAtIndex:reversedCounter];
            [update addDeletedSectionIndex:reversedCounter];
        }
    }
    
    return update;
}

@end
