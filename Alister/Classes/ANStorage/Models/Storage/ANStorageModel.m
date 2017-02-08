//
//  ANStorageModel.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"
#import "Alister.h"

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
        self.headerKind = ANListDefaultHeaderKind;
        self.footerKind = ANListDefaultFooterKind;
    }
    return self;
}

- (void)setHeaderKind:(NSString*)headerKind
{
    __block NSString* oldKind = _headerKind;
    [self.sectionModels enumerateObjectsUsingBlock:^(ANStorageSectionModel* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj replaceSupplementaryKind:oldKind onKind:headerKind];
    }];
    _headerKind = headerKind;
}

- (void)setFooterKind:(NSString*)footerKind
{
    __block NSString* oldKind = _footerKind;
    [self.sectionModels enumerateObjectsUsingBlock:^(ANStorageSectionModel* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj replaceSupplementaryKind:oldKind onKind:footerKind];
    }];
    _footerKind = footerKind;
    
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

- (NSString*)debugDescription
{
    NSMutableString* string = [NSMutableString string];
    
    [self.sectionModels enumerateObjectsUsingBlock:^(ANStorageSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [string appendFormat:@"=================Section #%d================\n", idx];
        
        //supplementaries
        if (obj.supplementaryObjects.count)
        {
            [string appendFormat:@"supplementaries { \n"];
            [obj.supplementaryObjects enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull object, BOOL * _Nonnull stopFlag) {
               
                [string appendFormat:@"    %@ - %@\n", key, object];
            }];
            [string appendFormat:@"}\n"];
        }
        
        [string appendFormat:@"Objects = { \n"];
        
        [obj.objects enumerateObjectsUsingBlock:^(id  _Nonnull object, NSUInteger index, BOOL * _Nonnull stopValue) {
            [string appendFormat:@"    %d = { %@ }\n", index, object];
        }];
        
        [string appendFormat:@"}\n"];
    }];
    
    return string;
}

@end
