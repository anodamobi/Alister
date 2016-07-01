//
//  ANStorageController.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageController.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageUpdater.h"
#import "ANStorageSupplementaryManager.h"
#import "ANStorageRemover.h"
#import "ANStorageLoader.h"
#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"

@interface ANStorageController ()

@property (nonatomic, copy) NSString* footerKind;
@property (nonatomic, copy) NSString* headerKind;

@end

@implementation ANStorageController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.storage = [ANStorageModel new];
    }
    return self;
}

- (void)addItem:(id)item
{
    ANStorageUpdateModel* update = [ANStorageUpdater addItem:item toStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}

- (void)addItems:(NSArray*)items
{
    ANStorageUpdateModel* update = [ANStorageUpdater addItems:items toStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}

- (void)addItem:(id)item toSection:(NSUInteger)sectionIndex
{
    ANStorageUpdateModel* update = [ANStorageUpdater addItem:item toSection:sectionIndex toStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}

- (void)addItems:(NSArray*)items toSection:(NSUInteger)sectionIndex
{
    ANStorageUpdateModel* update = [ANStorageUpdater addItems:items toSection:sectionIndex toStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}

- (void)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath
{
    ANStorageUpdateModel* update = [ANStorageUpdater addItem:item atIndexPath:indexPath toStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Reloading

- (void)reloadItem:(id)item
{
    ANStorageUpdateModel* update = [ANStorageUpdater reloadItem:item inStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}

- (void)reloadItems:(id)items
{
    ANStorageUpdateModel* update = [ANStorageUpdater reloadItems:items inStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Removing

- (void)removeItem:(id)item
{
    ANStorageUpdateModel* update = [ANStorageRemover removeItem:item fromStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}

- (void)removeItemsAtIndexPaths:(NSArray*)indexPaths
{
    ANStorageUpdateModel* update = [ANStorageRemover removeItemsAtIndexPaths:indexPaths fromStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}

- (void)removeItems:(NSArray*)items
{
    ANStorageUpdateModel* update = [ANStorageRemover removeItems:items fromStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}

- (void)removeAllItems
{
    ANStorageUpdateModel* update = [ANStorageRemover removeAllItemsFromStorage:self.storage];
    update.isRequireReload = YES;
    [self.updateDelegate collectUpdate:update];
}

- (void)removeSections:(NSIndexSet*)indexSet
{
    ANStorageUpdateModel* update = [ANStorageRemover removeSections:indexSet fromStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Replacing / Moving

- (void)replaceItem:(id)itemToReplace withItem:(id)replacingItem
{
    ANStorageUpdateModel* update = [ANStorageUpdater replaceItem:itemToReplace withItem:replacingItem inStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}

- (void)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{
    ANStorageUpdateModel* update = [ANStorageUpdater moveItemFromIndexPath:fromIndexPath
                                                               toIndexPath:toIndexPath
                                                                 inStorage:self.storage];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Loading

- (NSArray*)sections
{
    return [self.storage sections];
}

- (id)objectAtIndexPath:(NSIndexPath*)indexPath
{
    return [ANStorageLoader itemAtIndexPath:indexPath inStorage:self.storage];
}

- (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex
{
    return [ANStorageLoader sectionAtIndex:sectionIndex inStorage:self.storage];
}

- (NSArray*)itemsInSection:(NSUInteger)sectionIndex
{
    return [ANStorageLoader itemsInSection:sectionIndex inStorage:self.storage];
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath
{
    return [ANStorageLoader itemAtIndexPath:indexPath inStorage:self.storage];
}

- (NSIndexPath*)indexPathForItem:(id)item
{
    return [ANStorageLoader indexPathForItem:item inStorage:self.storage];
}

- (BOOL)isEmpty
{
    __block NSInteger count = 0;
    [[self sections] enumerateObjectsUsingBlock:^(ANStorageSectionModel*  _Nonnull obj, __unused NSUInteger idx, __unused BOOL * _Nonnull stop) {
        
        count += [obj numberOfObjects];
        if (count)
        {
            *stop = YES;
        }
    }];
    return (count == 0);
}

#pragma mark - Supplementaries

- (void)setSectionHeaderModel:(id)headerModel forSectionIndex:(NSUInteger)sectionIndex
{
    NSAssert(self.headerKind, @"you need to register model before");
    
    ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionHeaderModel:headerModel
                                                                           forSectionIndex:sectionIndex
                                                                                 inStorage:self.storage
                                                                                      kind:self.headerKind];
    [self.updateDelegate collectUpdate:update];
}

- (void)setSectionFooterModel:(id)footerModel forSectionIndex:(NSUInteger)sectionIndex
{
    NSAssert(self.footerKind, @"you need to register model before");
    ANStorageUpdateModel* update = [ANStorageSupplementaryManager updateSectionFooterModel:footerModel
                                                                           forSectionIndex:sectionIndex
                                                                                 inStorage:self.storage
                                                                                      kind:self.footerKind];
    [self.updateDelegate collectUpdate:update];
}

- (void)setSupplementaryHeaderKind:(NSString*)headerKind
{
    self.headerKind = headerKind;
}

- (void)setSupplementaryFooterKind:(NSString*)footerKind
{
    self.footerKind = footerKind;
}

- (id)headerModelForSectionIndex:(NSUInteger)index
{
    return [ANStorageSupplementaryManager supplementaryModelOfKind:self.headerKind
                                                   forSectionIndex:index
                                                         inStorage:self.storage];
}

- (id)footerModelForSectionIndex:(NSUInteger)index
{
    return [ANStorageSupplementaryManager supplementaryModelOfKind:self.footerKind
                                                   forSectionIndex:index
                                                         inStorage:self.storage];
}

- (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionNumber
{
    return [ANStorageSupplementaryManager supplementaryModelOfKind:kind
                                                   forSectionIndex:sectionNumber
                                                         inStorage:self.storage];
}

@end
