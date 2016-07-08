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

#pragma mark - Get

- (NSArray*)objects
{
    return [self.items copy];
}

- (NSUInteger)numberOfObjects
{
    return [self.items count];
}


#pragma mark - Add

- (void)addItem:(id)item
{
    if (item)
    {
        [self.items addObject:item];
    }
}

- (void)insertItem:(id)item atIndex:(NSUInteger)index
{
    if (item && self.items.count >= index)
    {
        [self.items insertObject:item atIndex:index];
    }
}


#pragma mark - Remove

- (void)removeItemAtIndex:(NSUInteger)index
{
    if (self.items.count > index)
    {
        [self.items removeObjectAtIndex:index];
    }
}


#pragma mark - Replace

- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item
{
    if (item && self.items.count >= index)
    {
        [self.items replaceObjectAtIndex:index withObject:item];
    }
}


#pragma mark - Supplementaries

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

- (NSDictionary*)supplementaryObjects
{
    return [self.supplementaries copy];
}

@end
