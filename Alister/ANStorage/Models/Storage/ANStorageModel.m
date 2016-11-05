//
//  ANStorageModel.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"

@interface ANStorageModel ()

@property (nonatomic, strong) NSMutableArray<ANStorageSectionModel*>* sectionModels;

@end

@implementation ANStorageModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.sectionModels = [NSMutableArray new];
        self.headerKind = @"ANStorageHeaderKind";
        self.footerKind = @"ANStorageFooterKind";
    }
    return self;
}

- (NSArray*)sections
{
    return [self.sectionModels copy];
}

- (NSInteger)numberOfSections
{
    return (NSInteger)self.sectionModels.count;
}

- (void)addSection:(id)section
{
    if (section && [section isKindOfClass:[ANStorageSectionModel class]])
    {
        [self.sectionModels addObject:section];
    }
}

- (NSArray*)itemsInSection:(NSInteger)section
{
    if (self.numberOfSections > section)
    {
        ANStorageSectionModel* sectionModel = [self sectionAtIndex:section];
        return sectionModel.objects;
    }
    return nil;
}

- (ANStorageSectionModel*)sectionAtIndex:(NSInteger)index
{
    if (self.numberOfSections > index && index >= 0)
    {
        return self.sectionModels[(NSUInteger)index];
    }
    return nil;
}

- (void)removeSectionAtIndex:(NSInteger)index
{
    if (index < self.numberOfSections && index >= 0)
    {
        [self.sectionModels removeObjectAtIndex:(NSUInteger)index];
    }
}

- (void)removeAllSections
{
    [self.sectionModels removeAllObjects];
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath
{
    id object = nil;
    if (indexPath && [indexPath isKindOfClass:[NSIndexPath class]])
    {
        object = [self _objectAtIndex:indexPath.row inSection:indexPath.section];
    }
    return object;
}

- (BOOL)isEmpty
{
    __block NSInteger count = 0;
    [self.sections enumerateObjectsUsingBlock:^(ANStorageSectionModel* _Nonnull obj, NSUInteger idx, BOOL* _Nonnull stop) {
        count += obj.numberOfObjects;
        if (count)
        {
            *stop = YES;
        }
    }];
    
    return (count == 0);
}


#pragma mark - Private

- (id)_objectAtIndex:(NSInteger)index inSection:(NSInteger)section
{
    if (self.numberOfSections > section && section >= 0 && index >= 0)
    {
        ANStorageSectionModel* model = [self sectionAtIndex:section];
        if ([model numberOfObjects] > index && index >= 0)
        {
            return model.objects[(NSUInteger)index];
        }
    }
    return nil;
}

@end
