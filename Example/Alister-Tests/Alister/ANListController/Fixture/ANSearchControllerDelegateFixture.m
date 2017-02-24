//
//  ANSearchControllerDelegateFixture.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANSearchControllerDelegateFixture.h"
#import "ANStorage.h"

@interface ANSearchControllerDelegateFixture ()

@property (nonatomic, strong) ANStorage* lastGeneratedStorage;
@property (nonatomic, strong) NSMutableArray* allGeneratedStorages;

@end

@implementation ANSearchControllerDelegateFixture

- (NSArray *)allGeneratedStoragesArray
{
    return [self.allGeneratedStorages copy];
}

- (void)searchControllerCreatedStorage:(ANStorage*)searchStorage
{
    self.lastGeneratedStorage = searchStorage;
    
    id object = searchStorage ? searchStorage : (id)[NSNull null];
    [self.allGeneratedStorages addObject:object];
}

- (void)searchControllerDidCancelSearch
{
    self.cancelCount ++;
}

- (NSMutableArray*)allGeneratedStorages
{
    if (!_allGeneratedStorages)
    {
        _allGeneratedStorages = [NSMutableArray new];
    }
    return _allGeneratedStorages;
}

- (ANStorage*)storage
{
    if (!_storage)
    {
        _storage = [ANStorage new];
        NSArray* itemsForScope1 = @[@"test", @"test1", @"test2", @"test4"];
        NSArray* items = [itemsForScope1 arrayByAddingObjectsFromArray:@[@"anoda", @"tiger", @"tooth",
                                                                         @"tool", @"something", @"anything"]];
        
        [_storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:items];
        }];
    }
    return _storage;
}

@end
