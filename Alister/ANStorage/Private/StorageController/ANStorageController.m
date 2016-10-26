//
//  ANStorageController.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import <Alister/ANStorageController.h>
#import "ANStorageUpdateModel.h"
#import "ANStorageUpdater.h"
#import "ANStorageSupplementaryManager.h"
#import "ANStorageRemover.h"
#import "ANStorageLoader.h"
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageSectionModel.h>

@interface ANStorageController ()

@property (nonatomic, strong) ANStorageRemover* remover;
@property (nonatomic, strong) ANStorageUpdater* updater;
@property (nonatomic, strong) ANStorageSupplementaryManager* supplementaryManager;


@end

@implementation ANStorageController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.storageModel = [ANStorageModel new];
        self.remover = [ANStorageRemover removerWithStorageModel:self.storageModel andUpdateDelegate:self.updateDelegate]; //TODO: delegate
        self.updater = [ANStorageUpdater updaterWithStorageModel:self.storageModel delegate:self.updateDelegate];
        
        self.supplementaryManager = [ANStorageSupplementaryManager supplementatyManagerWithStorageModel:self.storageModel
                                                                                           withDelegate:self.updateDelegate];
    }
    return self;
}

- (void)addItem:(id)item
{
    ANStorageUpdateModel* update = [self.updater addItem:item];
    [self.updateDelegate collectUpdate:update];
}

- (void)addItems:(NSArray*)items
{
    ANStorageUpdateModel* update = [self.updater addItems:items];
    [self.updateDelegate collectUpdate:update];
}

- (void)addItem:(id)item toSection:(NSUInteger)sectionIndex
{
    ANStorageUpdateModel* update = [self.updater addItem:item toSection:sectionIndex];
    [self.updateDelegate collectUpdate:update];
}

- (void)addItems:(NSArray*)items toSection:(NSUInteger)sectionIndex
{
    ANStorageUpdateModel* update = [self.updater addItems:items toSection:sectionIndex];
    [self.updateDelegate collectUpdate:update];
}

- (void)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath
{
    ANStorageUpdateModel* update = [self.updater addItem:item atIndexPath:indexPath];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Reloading

- (void)reloadItem:(id)item
{
    ANStorageUpdateModel* update = [self.updater reloadItem:item];
    [self.updateDelegate collectUpdate:update];
}

- (void)reloadItems:(id)items
{
    ANStorageUpdateModel* update = [self.updater reloadItems:items];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Removing

- (void)removeItem:(id)item
{
    ANStorageUpdateModel* update = [self.remover removeItem:item];
    [self.updateDelegate collectUpdate:update];
}

- (void)removeItemsAtIndexPaths:(NSSet*)indexPaths
{
    ANStorageUpdateModel* update = [self.remover removeItemsAtIndexPaths:indexPaths];
    [self.updateDelegate collectUpdate:update];
}

- (void)removeItems:(NSSet*)items
{
    ANStorageUpdateModel* update = [self.remover removeItems:items];
    [self.updateDelegate collectUpdate:update];
}

- (void)removeAllItemsAndSections
{
    ANStorageUpdateModel* update = [self.remover removeAllItemsAndSections];
    update.isRequireReload = YES;
    [self.updateDelegate collectUpdate:update];
}

- (void)removeSections:(NSIndexSet*)indexSet
{
    ANStorageUpdateModel* update = [self.remover removeSections:indexSet];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Replacing / Moving

- (void)replaceItem:(id)itemToReplace withItem:(id)replacingItem
{
    ANStorageUpdateModel* update = [self.updater replaceItem:itemToReplace withItem:replacingItem];
    [self.updateDelegate collectUpdate:update];
}

- (void)moveItemWithoutUpdateFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{
    [self.updater moveItemFromIndexPath:fromIndexPath
                                toIndexPath:toIndexPath];
    
    //to be consistent, in this case we don't need update as it will corrupt already updated tableview
    [self.updateDelegate collectUpdate:nil];
}

- (void)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{
    ANStorageUpdateModel* update = [self.updater moveItemFromIndexPath:fromIndexPath
                                                               toIndexPath:toIndexPath];
    [self.updateDelegate collectUpdate:update];
}


#pragma mark - Loading

- (NSArray*)sections
{
    return [self.storageModel sections];
}

- (id)objectAtIndexPath:(NSIndexPath*)indexPath
{
    return [ANStorageLoader itemAtIndexPath:indexPath inStorage:self.storageModel];
}

- (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex
{
    return [ANStorageLoader sectionAtIndex:sectionIndex inStorage:self.storageModel];
}

- (NSArray*)itemsInSection:(NSUInteger)sectionIndex
{
    return [ANStorageLoader itemsInSection:sectionIndex inStorage:self.storageModel];
}

- (NSIndexPath*)indexPathForItem:(id)item
{
    return [ANStorageLoader indexPathForItem:item inStorage:self.storageModel];
}

- (BOOL)isEmpty
{
    __block NSInteger count = 0;
    [[self sections] enumerateObjectsUsingBlock:^(ANStorageSectionModel*  _Nonnull obj, __unused NSUInteger idx, __unused BOOL*  _Nonnull stop) {
        
        count += [obj numberOfObjects];
        if (count)
        {
           *stop = YES;
        }
    }];
    return (count == 0);
}


#pragma mark - Supplementaries

- (void)updateSupplementaryHeaderKind:(NSString*)headerKind
{
    self.storageModel.headerKind = headerKind;
}

- (void)updateSupplementaryFooterKind:(NSString*)footerKind
{
    self.storageModel.footerKind = footerKind;
}

- (void)updateSectionHeaderModel:(id)headerModel forSectionIndex:(NSInteger)sectionIndex
{
    ANStorageUpdateModel* update = [self.supplementaryManager updateSectionHeaderModel:headerModel
                                                                           forSectionIndex:sectionIndex];
    [self.updateDelegate collectUpdate:update];
}

- (void)updateSectionFooterModel:(id)footerModel forSectionIndex:(NSInteger)sectionIndex
{
    ANStorageUpdateModel* update = [self.supplementaryManager updateSectionFooterModel:footerModel
                                                                           forSectionIndex:sectionIndex];
    [self.updateDelegate collectUpdate:update];
}

- (id)headerModelForSectionIndex:(NSUInteger)index
{
    return [self.supplementaryManager supplementaryModelOfKind:self.storageModel.headerKind
                                                   forSectionIndex:index];
}

- (id)footerModelForSectionIndex:(NSUInteger)index
{
    return [self.supplementaryManager supplementaryModelOfKind:self.storageModel.footerKind
                                                   forSectionIndex:index];
}

- (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionIndex
{
    return [self.supplementaryManager supplementaryModelOfKind:kind
                                                   forSectionIndex:sectionIndex];
}


#pragma mark - Private

- (void)setUpdateDelegate:(id<ANStorageUpdateOperationInterface>)updateDelegate
{
    if ([updateDelegate conformsToProtocol:@protocol(ANStorageUpdateOperationInterface)] || !updateDelegate)
    {
        _updateDelegate = updateDelegate;
    }
    else
    {
        NSAssert(NO, @"Delegate must conforms to protocol");
    }
}

@end
