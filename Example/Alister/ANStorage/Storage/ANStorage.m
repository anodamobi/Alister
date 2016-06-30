//
//  ANStorage.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorage.h"
#import "ANStorageController.h"
#import "ANStorageUpdateOperation.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageLog.h"

@interface ANStorage ()

@property (nonatomic, strong) ANStorageController* controller;
@property (nonatomic, assign) BOOL isSearchingType;

@end

@implementation ANStorage

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _identifier = [[NSUUID UUID] UUIDString];
        self.controller = [ANStorageController new];
    }
    return self;
}

- (void)updateWithAnimationWithBlock:(ANDataStorageUpdateBlock)block
{
    [self _updateWithBlock:block animatable:YES];
}

- (void)updateWithoutAnimationWithBlock:(ANDataStorageUpdateBlock)block
{
    [self _updateWithBlock:block animatable:NO];
}


- (void)reloadStorageWithAnimation:(BOOL)isAnimatable
{
    id<ANStorageUpdatingInterface> listController = self.listController;
    if (isAnimatable)
    {
        [listController storageNeedsReloadAnimatedWithIdentifier:self.identifier];
    }
    else
    {
        [listController storageNeedsReloadWithIdentifier:self.identifier];
    }
}

- (void)_updateWithBlock:(ANDataStorageUpdateBlock)block animatable:(BOOL)isAnimatable
{
    if (block)
    {
        if (!self.isSearchingType)
        {
            id<ANStorageUpdatingInterface> listController = self.listController;
            if (listController)
            {
                ANStorageUpdateOperation* updateOperation = nil;
                updateOperation = [ANStorageUpdateOperation operationWithExecutionBlock:^(ANStorageUpdateOperation *operation) {
                    self.controller.updateDelegate = operation;
                    block(self.controller);
                }];
                
                [listController storageDidPerformUpdate:updateOperation withIdentifier:self.identifier animatable:isAnimatable];
            }
            else
            {
                block(self.controller);
            }
        }
        else
        {
            block(self.controller);
        }
    }
}

- (instancetype)searchStorageForSearchString:(NSString*)searchString inSearchScope:(NSInteger)searchScope
{
    ANStorage* storage = [[self class] new];
    storage.isSearchingType = YES;
    
    NSPredicate* predicate;
    if (self.storagePredicateBlock)
    {
        predicate = self.storagePredicateBlock(searchString, searchScope);
    }
    if (predicate)
    {
        [storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
            
            [self.sections enumerateObjectsUsingBlock:^(ANStorageSectionModel* obj, NSUInteger idx, BOOL *stop) {
                NSArray* filteredObjects = [obj.objects filteredArrayUsingPredicate:predicate];
                [storageController addItems:filteredObjects toSection:idx];
            }];
        }];
    }
    else
    {
        ANStorageLog(@"No predicate was created, so no searching. Check your setter for storagePredicateBlock");
    }
    return storage;
}


#pragma mark - ANStorageRetrivingInterface

- (NSArray*)sections
{
    return [self.controller sections];
}

- (id)objectAtIndexPath:(NSIndexPath*)indexPath
{
    return [self.controller objectAtIndexPath:indexPath];
}

- (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex
{
    return [self.controller sectionAtIndex:sectionIndex];
}

- (id)headerModelForSectionIndex:(NSUInteger)index
{
    return [self.controller headerModelForSectionIndex:index];
}

- (id)footerModelForSectionIndex:(NSUInteger)index
{
    return [self.controller footerModelForSectionIndex:index];
}

- (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionNumber
{
    return [self.controller supplementaryModelOfKind:kind forSectionIndex:sectionNumber];
}

- (NSArray*)itemsInSection:(NSUInteger)sectionIndex
{
    return [self.controller itemsInSection:sectionIndex];
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath
{
    return [self.controller itemAtIndexPath:indexPath];
}

- (NSIndexPath*)indexPathForItem:(id)item
{
    return [self.controller indexPathForItem:item];
}

- (BOOL)isEmpty
{
    return [self.controller isEmpty];
}

@end
