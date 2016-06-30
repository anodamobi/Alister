//
//  ANStorageModel.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageModel.h"

@interface ANStorageModel ()

@property (nonatomic, strong) NSMutableArray* sectionModels;

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

- (id)sectionAtIndex:(NSUInteger)index
{
    if (self.sectionModels.count > index)
    {
        return self.sectionModels[index];
    }
    return nil;
}

- (void)addSection:(id)section
{
    [self.sectionModels addObject:section];
}

- (void)removeSectionAtIndex:(NSUInteger)index
{
    [self.sectionModels removeObjectAtIndex:index];
}

- (void)removeAllSections
{
    [self.sectionModels removeAllObjects];
}


@end
