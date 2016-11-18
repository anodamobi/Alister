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

@property (nonatomic, strong) NSMutableSet* deletedRowIndexPaths;
@property (nonatomic, strong) NSMutableSet* insertedRowIndexPaths;
@property (nonatomic, strong) NSMutableSet* updatedRowIndexPaths;
@property (nonatomic, strong) NSMutableSet* movedRowsIndexPaths;

@end

@implementation ANStorageUpdateModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.deletedRowIndexPaths = [NSMutableSet new];
        self.insertedRowIndexPaths = [NSMutableSet new];
        self.updatedRowIndexPaths = [NSMutableSet new];
        self.movedRowsIndexPaths = [NSMutableSet new];
        
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
    
    [self addInsertedIndexPaths:model.insertedRowIndexPaths.allObjects];
    [self addMovedIndexPaths:model.movedRowsIndexPaths.allObjects];
    [self addUpdatedIndexPaths:model.updatedRowIndexPaths.allObjects];
    [self addDeletedIndexPaths:model.deletedRowIndexPaths.allObjects];
    
    self.isRequireReload = ([model isRequireReload] || self.isRequireReload);
}

- (BOOL)isEqual:(id)other
{
    if (other == self)
    {
        return YES;
    }
    else
    {
        BOOL result = YES;
        ANStorageUpdateModel* otherModel = other;
        
        result = (result && ([self.deletedRowIndexPaths isEqualToSet:self.deletedRowIndexPaths]));
        result = (result && ([self.insertedRowIndexPaths isEqualToSet:self.insertedRowIndexPaths ]));
        result = (result && ([self.updatedRowIndexPaths isEqualToSet:self.updatedRowIndexPaths]));
        result = (result && ([self.movedRowsIndexPaths isEqualToSet:self.movedRowsIndexPaths]));
        
        result = (result && ([self.insertedSectionIndexes isEqualToIndexSet:self.insertedSectionIndexes]));
        result = (result && ([self.deletedSectionIndexes isEqualToIndexSet:self.deletedSectionIndexes]));
        result = (result && ([self.updatedSectionIndexes isEqualToIndexSet:self.updatedSectionIndexes]));
        
        result = result && (self.isRequireReload == otherModel.isRequireReload);
        
        return result;
    }
}

- (NSUInteger)hash
{
    return (self.deletedSectionIndexes.hash +
            self.insertedSectionIndexes.hash +
            self.updatedSectionIndexes.hash +
            self.deletedRowIndexPaths.hash +
            self.insertedRowIndexPaths.hash +
            self.updatedRowIndexPaths.hash +
            self.movedRowsIndexPaths.hash +
            (NSUInteger)self.isRequireReload);
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
