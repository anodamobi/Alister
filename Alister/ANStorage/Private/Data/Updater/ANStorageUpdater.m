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
#import "ANStorageModel.h"
#import "ANStorageLog.h"
#import "ANStorageValidator.h"

@interface ANStorageUpdater ()

@property (nonatomic, weak) ANStorageModel* storageModel;

@end

@implementation ANStorageUpdater

+ (instancetype)updaterWithStorageModel:(ANStorageModel*)model updateDelegate:(nonnull id<ANStorageUpdateOperationInterface>)delegate
{
    ANStorageUpdater* updater = [self new];
    updater.storageModel = model;
    updater.updateDelegate = delegate;
    
    return updater;
}

- (void)addItem:(id)item
{
    [self addItem:item toSection:0];
}

- (void)addItems:(NSArray*)items
{
    [self addItems:items toSection:0];
}

- (void)addItem:(id)item toSection:(NSUInteger)sectionIndex
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (item)
    {
        update = [self _addItems:@[item] toSection:sectionIndex];
    }
    else
    {
        ANStorageLog(@"You trying to add nil item in storage");
    }
    
    [self.updateDelegate collectUpdate:update];
}

- (void)addItems:(NSArray*)items toSection:(NSInteger)sectionIndex
{
    ANStorageUpdateModel* update = [self _addItems:items toSection:sectionIndex];
    [self.updateDelegate collectUpdate:update];
}

- (void)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath
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
    
    [self.updateDelegate collectUpdate:update];
}

- (void)replaceItem:(id)itemToReplace withItem:(id)replacingItem
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
    
    [self.updateDelegate collectUpdate:update];
}

- (void)moveItemWithoutUpdateFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{   //no collect update should be called. This method for native table view
    [self _moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
}

- (void)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{
    ANStorageUpdateModel* update = [self _moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Reload Items

- (void)reloadItem:(id)item
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    if (item)
    {
        update = [self _reloadItems:@[item]];
    }
    
    [self.updateDelegate collectUpdate:update];
}

- (void)reloadItems:(NSArray*)items
{
    ANStorageUpdateModel* update = [self _reloadItems:items];
    [self.updateDelegate collectUpdate:update];
}

//TODO: should now it be private?
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

- (void)updateSectionHeaderModel:(id)headerModel forSectionIndex:(NSInteger)sectionIndex
{
    ANStorageUpdateModel* update = [self _updateSupplementaryOfKind:self.storageModel.headerKind
                                                              model:headerModel
                                                    forSectionIndex:sectionIndex];
    [self.updateDelegate collectUpdate:update];
}

- (void)updateSectionFooterModel:(id)footerModel forSectionIndex:(NSInteger)sectionIndex
{
    ANStorageUpdateModel* update = [self _updateSupplementaryOfKind:self.storageModel.footerKind
                                                              model:footerModel
                                                    forSectionIndex:sectionIndex];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Private

- (ANStorageUpdateModel*)_addItems:(NSArray*)items toSection:(NSInteger)sectionIndex
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

- (ANStorageUpdateModel*)_reloadItems:(NSArray*)items
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    NSArray* indexPathesArrayToReload = [ANStorageLoader indexPathArrayForItems:items inStorage:self.storageModel];
    if (indexPathesArrayToReload)
    {
        [update addUpdatedIndexPaths:indexPathesArrayToReload];
    }
    
    return update;
}

- (ANStorageUpdateModel*)_moveItemFromIndexPath:(NSIndexPath*)fromIndexPath
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

//TODO: check is it need to be public for collectionView
- (ANStorageUpdateModel*)_updateSupplementaryOfKind:(NSString*)kind
                                              model:(id)model
                                    forSectionIndex:(NSUInteger)sectionIndex
{
    ANStorageUpdateModel* update = [ANStorageUpdateModel new];
    
    if (ANIsIndexValid(sectionIndex) && self.storageModel)
    {
        ANStorageSectionModel* section = nil;
        
        if (model)
        {
            NSIndexSet* set = [self createSectionIfNotExist:sectionIndex];
            [update addInsertedSectionIndexes:set];
            section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:self.storageModel];
        }
        else
        {   // if section not exist we don't need to remove it's model,
            // so no new sections will be created and update will be empty
            section = [ANStorageLoader sectionAtIndex:sectionIndex inStorage:self.storageModel];
        }
        [section updateSupplementaryModel:model forKind:kind];
    }
    
    return update;
}

@end
