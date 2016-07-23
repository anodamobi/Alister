//
//  ANStorageUpdateModel.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdateModel.h"

@interface ANStorageUpdateModel ()

@property (nonatomic, strong) NSMutableIndexSet* deletedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet* insertedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet* updatedSectionIndexes;

@property (nonatomic, strong) NSMutableArray* deletedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray* insertedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray* updatedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray* movedRowsIndexPaths;

@end

@implementation ANStorageUpdateModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.deletedRowIndexPaths = [NSMutableArray new];
        self.insertedRowIndexPaths = [NSMutableArray new];
        self.updatedRowIndexPaths = [NSMutableArray new];
        self.movedRowsIndexPaths = [NSMutableArray new];
        
        self.deletedSectionIndexes = [NSMutableIndexSet new];
        self.insertedSectionIndexes = [NSMutableIndexSet new];
        self.updatedSectionIndexes = [NSMutableIndexSet new];
    }
    return self;
}


#pragma mark - Common

- (BOOL)isEmpty
{
    BOOL hasUpdates = ((self.deletedSectionIndexes.count +
                       self.insertedSectionIndexes.count +
                       self.updatedSectionIndexes.count +
                       self.deletedRowIndexPaths.count +
                       self.insertedRowIndexPaths.count +
                       self.updatedRowIndexPaths.count +
                        self.movedRowsIndexPaths.count) != 0);
    
    BOOL isEmpty = (!hasUpdates && !self.isRequireReload);
    return isEmpty;
}

- (void)mergeWith:(id<ANStorageUpdateModelInterface>)model
{
    [self addInsertedSectionIndexes:model.insertedSectionIndexes];
    [self addUpdatedSectionIndexes:model.updatedSectionIndexes];
    [self addDeletedSectionIndexes:model.deletedSectionIndexes];
    
    [self addInsertedIndexPaths:model.insertedRowIndexPaths];
    [self addMovedIndexPaths:model.movedRowsIndexPaths];
    [self addUpdatedIndexPaths:model.updatedRowIndexPaths];
    [self addDeletedIndexPaths:model.deletedRowIndexPaths];
    
    self.isRequireReload = [model isRequireReload] || self.isRequireReload;
}


#pragma mark - ANStorageUpdateModelInterface

- (void)addDeletedSectionIndex:(NSUInteger)index
{
    [self.deletedSectionIndexes addIndex:index];
}

- (void)addUpdatedSectionIndex:(NSUInteger)index
{
    [self.updatedSectionIndexes addIndex:index];
}

- (void)addInsertedSectionIndex:(NSUInteger)index
{
    [self.insertedSectionIndexes addIndex:index];
}

- (void)addInsertedSectionIndexes:(NSIndexSet*)indexSet
{
    if (indexSet)
    {
        [self.insertedSectionIndexes addIndexes:indexSet];
    }
}

- (void)addUpdatedSectionIndexes:(NSIndexSet*)indexSet
{
    if (indexSet)
    {
        [self.updatedSectionIndexes addIndexes:indexSet];
    }
}

- (void)addDeletedSectionIndexes:(NSIndexSet*)indexSet
{
    if (indexSet)
    {
        [self.deletedSectionIndexes addIndexes:indexSet];
    }
}


#pragma mark - Index Paths

- (void)addInsertedIndexPaths:(NSArray*)items
{
    if (items && items.count)
    {
        [self.insertedRowIndexPaths addObjectsFromArray:items];
    }
}

- (void)addUpdatedIndexPaths:(NSArray*)items
{
    if (items && items.count)
    {
        [self.updatedRowIndexPaths addObjectsFromArray:items];
    }
}

- (void)addDeletedIndexPaths:(NSArray*)items
{
    if (items && items.count)
    {
        [self.deletedRowIndexPaths addObjectsFromArray:items];
    }
}

- (void)addMovedIndexPaths:(NSArray*)items
{
    if (items && items.count)
    {
        [self.movedRowsIndexPaths addObjectsFromArray:items];
    }
}

@end
