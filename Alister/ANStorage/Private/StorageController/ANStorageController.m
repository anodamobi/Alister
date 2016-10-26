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
        self.updater = [ANStorageUpdater updaterWithStorageModel:self.storageModel updateDelegate:self.updateDelegate];
        
        self.supplementaryManager = [ANStorageSupplementaryManager supplementatyManagerWithStorageModel:self.storageModel
                                                                                         updateDelegate:self.updateDelegate];
    }
    return self;
}

- (void)addItem:(id)item
{
    [self.updater addItem:item];
}

- (void)addItems:(NSArray*)items
{
    [self.updater addItems:items];
}

- (void)addItem:(id)item toSection:(NSUInteger)sectionIndex
{
    [self.updater addItem:item toSection:sectionIndex];
}

- (void)addItems:(NSArray*)items toSection:(NSUInteger)sectionIndex
{
    [self.updater addItems:items toSection:sectionIndex];
}

- (void)addItem:(id)item atIndexPath:(NSIndexPath*)indexPath
{
    [self.updater addItem:item atIndexPath:indexPath];
}


#pragma mark - Reloading

- (void)reloadItem:(id)item
{
    [self.updater reloadItem:item];
}

- (void)reloadItems:(id)items
{
    [self.updater reloadItems:items];
}


#pragma mark - Removing

- (void)removeItem:(id)item
{
    [self.remover removeItem:item];
}

- (void)removeItemsAtIndexPaths:(NSSet*)indexPaths
{
    [self.remover removeItemsAtIndexPaths:indexPaths];
}

- (void)removeItems:(NSSet*)items
{
    [self.remover removeItems:items];
}

- (void)removeAllItemsAndSections
{
    [self.remover removeAllItemsAndSections];
}

- (void)removeSections:(NSIndexSet*)indexSet
{
    [self.remover removeSections:indexSet];
}


#pragma mark - Replacing / Moving

- (void)replaceItem:(id)itemToReplace withItem:(id)replacingItem
{
    [self.updater replaceItem:itemToReplace withItem:replacingItem];
}

- (void)moveItemWithoutUpdateFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{
    [self.updater moveItemWithoutUpdateFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
}

- (void)moveItemFromIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{
    [self.updater moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
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
    [self.supplementaryManager updateSectionHeaderModel:headerModel forSectionIndex:sectionIndex];
}

- (void)updateSectionFooterModel:(id)footerModel forSectionIndex:(NSInteger)sectionIndex
{
    [self.supplementaryManager updateSectionFooterModel:footerModel forSectionIndex:sectionIndex];
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
