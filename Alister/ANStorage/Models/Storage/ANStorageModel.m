//
//  ANStorageModel.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageSectionModel.h>

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
    }
    return self;
}

- (NSArray*)sections
{
    return [self.sectionModels copy];
}

- (void)addSection:(id)section
{
    if (section && [section isKindOfClass:[ANStorageSectionModel class]])
    {
        [self.sectionModels addObject:section];
    }
}

- (NSArray*)itemsInSection:(NSUInteger)section
{
    if (self.sectionModels.count > section)
    {
        ANStorageSectionModel* sectionModel = self.sectionModels[section];
        return sectionModel.objects;
    }
    return nil;
}

- (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)index
{
    if (self.sectionModels.count > index)
    {
        return self.sectionModels[index];
    }
    return nil;
}

- (void)removeSectionAtIndex:(NSUInteger)index
{
    if (index < self.sectionModels.count)
    {
        [self.sectionModels removeObjectAtIndex:index];
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
        object = [self _objectAtIndex:(NSUInteger)indexPath.row
                            inSection:(NSUInteger)indexPath.section];
    }
    return object;
}


#pragma mark - Private

- (id)_objectAtIndex:(NSUInteger)index inSection:(NSUInteger)section
{
    if (self.sectionModels.count > index)
    {
        ANStorageSectionModel* model = self.sectionModels[section];
        if ([model numberOfObjects] > index)
        {
            return model.objects[index];
        }
    }
    return nil;
}

@end
