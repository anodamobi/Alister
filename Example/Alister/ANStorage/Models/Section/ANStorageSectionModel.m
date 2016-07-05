//
//  ANStorageSectionModel.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageSectionModel.h"

@interface ANStorageSectionModel ()

@property (nonatomic, strong) NSMutableDictionary* supplementaries;
@property (nonatomic, strong) NSMutableArray* items;

@end

@implementation ANStorageSectionModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.items = [NSMutableArray array];
        self.supplementaries = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray*)objects
{
    return [self.items copy];
}

- (NSDictionary*)supplementaryObjects
{
    return [self.supplementaries copy];
}

- (NSUInteger)numberOfObjects
{
    return [self.items count];
}

- (void)addItem:(id)item
{
    [self.items addObject:item];
}

- (void)insertItem:(id)item atIndex:(NSUInteger)index
{
    [self.items insertObject:item atIndex:index];
}

- (void)removeItemAtIndex:(NSUInteger)index
{
    [self.items removeObjectAtIndex:index];
}

- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item
{
    [self.items replaceObjectAtIndex:index withObject:item];
}

- (void)updateSupplementaryModel:(id)model forKind:(NSString*)kind
{
    if (kind)
    {
        if (model)
        {
            self.supplementaries[kind] = model;
        }
        else
        {
            [self.supplementaries removeObjectForKey:kind];
        }
    }
}

- (id)supplementaryModelOfKind:(NSString*)kind
{
    if (kind)
    {
        return self.supplementaries[kind];
    }
    return nil;
}

@end
