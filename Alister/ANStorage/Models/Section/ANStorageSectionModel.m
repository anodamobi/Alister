//
//  ANStorageSectionModel.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageSectionModel.h"
#import "ANStorageLog.h"
#import "ANStorageValidator.h"

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

- (NSInteger)numberOfObjects
{
    return (NSInteger)[self.items count];
}


#pragma mark - Add

- (void)addItem:(id)item
{
    if (item)
    {
        [self.items addObject:item];
    }
    else
    {
        ANStorageLog(@"You trying to add nil object - %@", NSStringFromSelector(_cmd));
    }
}

- (void)insertItem:(id)item atIndex:(NSInteger)index
{
    if (item)
    {
        if (ANIsIndexValid(index))
        {
            if (self.items.count >= (NSUInteger)index)
            {
                [self.items insertObject:item atIndex:(NSUInteger)index];
            }
            else
            {
                ANStorageLog(@"You trying to insert object at index == NSNotFound - %@", NSStringFromSelector(_cmd));
            }
        }
        else
        {
            ANStorageLog(@"You trying to insert object at index == NSNotFound - %@", NSStringFromSelector(_cmd));
        }
    }
    else
    {
        ANStorageLog(@"You trying to add nil object - %@", NSStringFromSelector(_cmd));
    }
}


#pragma mark - Remove

- (void)removeItemAtIndex:(NSInteger)index
{
    if (ANIsIndexValid(index) && self.items.count > (NSUInteger)index)
    {
        [self.items removeObjectAtIndex:(NSUInteger)index];
    }
    else
    {
        ANStorageLog(@"You trying remove object at non existing index - %ld, %@", index, NSStringFromSelector(_cmd));
    }
}


#pragma mark - Replace

- (void)replaceItemAtIndex:(NSInteger)index withItem:(id)item
{
    if (item && ANIsIndexValid(index))
    {
        if (self.items.count >= (NSUInteger)index && self.items.count != 0)
        {
            [self.items replaceObjectAtIndex:(NSUInteger)index withObject:item];
        }
        else
        {
            ANStorageLog(@"You trying replace object at non existing index - %ld, %@", index, NSStringFromSelector(_cmd));
        }
    }
    else
    {
        ANStorageLog(@"You trying to replace object with nil - %@", NSStringFromSelector(_cmd));
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
    else
    {
        ANStorageLog(@"You trying to add supplementary - with nil kind");
    }
}

- (id)supplementaryModelOfKind:(NSString*)kind
{
    id model = nil;
    if (kind)
    {
        model = self.supplementaries[kind];
    }
    else
    {
        ANStorageLog(@"You trying to get supplementary - with nil kind");
    }
    return model;
}

- (NSDictionary*)supplementaryObjects
{
    return [self.supplementaries copy];
}

@end
