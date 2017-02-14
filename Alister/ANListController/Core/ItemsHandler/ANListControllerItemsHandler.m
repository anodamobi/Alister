//
//  ANListItemsBuilder.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerItemsHandler.h"
#import "ANListControllerMappingService.h"
#import "ANListControllerUpdateViewInterface.h"
#import "ANListViewInterface.h"
#import "ANListControllerLog.h"
#import "Alister.h"

@implementation ANListControllerItemsHandler

@synthesize mappingService = _mappingService;

- (instancetype)initWithListView:(id<ANListViewInterface>)listView
                  mappingService:(id<ANListControllerMappingServiceInterface>)mappingService
{
    self = [super init];
    if (self)
    {
        _listView = listView;
        _mappingService = mappingService;
    }
    return self;
}


#pragma mark - ANListControllerReusableInterface

- (void)registerFooterClass:(Class)viewClass forModelClass:(Class)modelClass
{
    [self registerSupplementaryClass:viewClass forModelClass:modelClass kind:[self.listView defaultFooterKind]];
}

- (void)registerHeaderClass:(Class)viewClass forModelClass:(Class)modelClass
{
    [self registerSupplementaryClass:viewClass forModelClass:modelClass kind:[self.listView defaultHeaderKind]];
}

- (void)registerSupplementaryClass:(Class)supplementaryClass forModelClass:(Class)modelClass kind:(NSString*)kind
{
    NSString* identifier = [self.mappingService registerViewModelClass:modelClass kind:kind];
    if (identifier)
    {
        [self.listView registerSupplementaryClass:supplementaryClass reuseIdentifier:identifier kind:kind];
    }
    else
    {
        ANListControllerLog(@"No mapping was created for supplementary!");
    }
}


#pragma mark - Nibs

- (void)registerFooterForNibName:(NSString*)nibName inBundle:(NSBundle*)bundle forModelClass:(Class)modelClass
{
    [self _registerSupplementaryWithNibName:nibName inBundle:bundle forModelClass:modelClass kind:[self.listView defaultFooterKind]];
}

- (void)registerHeaderForNibName:(NSString*)nibName inBundle:(NSBundle*)bundle forModelClass:(Class)modelClass
{
    [self _registerSupplementaryWithNibName:nibName inBundle:bundle forModelClass:modelClass kind:[self.listView defaultHeaderKind]];
}

- (void)registerCellForNibName:(NSString*)nibName inBundle:(NSBundle*)bundle forModelClass:(Class)modelClass
{
    [self _registerCellWithNibName:nibName inBundle:bundle forModelClass:modelClass];
}

- (void)_registerSupplementaryWithNibName:(NSString*)nibName inBundle:(NSBundle*)bundle forModelClass:(Class)modelClass kind:(NSString*)kind
{
    NSString* identifier = [self.mappingService registerViewModelClass:modelClass kind:kind withNibName:nibName inBundle:bundle];
    if (identifier)
    {
        [self.listView registerSupplementaryNib:nib reuseIdentifier:identifier kind:kind];
    }
    else
    {
        ANListControllerLog(@"No mapping was created for cell!");
    }
}

- (void)_registerCellWithNibName:(NSString*)nibName inBundle:(NSBundle*)bundle forModelClass:(Class)modelClass
{
    UINib* nib = [bundle loadNibNamed:nibName owner:nil options:nil].firstObject;
    NSString* identifier = nil;
    
    if (nib && identifier)
    {
        [self.listView registerCellWithNib:nib forReuseIdentifier:identifier];
    }
    else
    {
        ANListControllerLog(@"No mapping was created for cell!");
    }
}


#pragma mark - Cells

- (void)registerCellClass:(Class)cellClass forModelClass:(Class)modelClass
{
    [self registerCellClass:cellClass forModelClass:modelClass withNib:nil];
}

- (void)registerCellClass:(Class)cellClass forModelClass:(Class)modelClass withNib:(UINib*)nib
{
    NSString* identifier = [self.mappingService registerViewModelClass:modelClass];
    if (identifier)
    {
        [self.listView registerCellClass:cellClass forReuseIdentifier:identifier];
    }
    else
    {
        ANListControllerLog(@"No mapping was created for cell!");
    }
}


#pragma mark - Loading

- (nullable id<ANListControllerUpdateViewInterface>)cellForModel:(id)viewModel atIndexPath:(NSIndexPath*)indexPath
{
    NSString* identifier = [self.mappingService identifierForViewModelClass:[viewModel class]];
    id<ANListControllerUpdateViewInterface> cell = nil;
    id<ANListViewInterface> listView = self.listView;
    
    if (identifier)
    {
        cell = [listView cellForReuseIdentifier:identifier atIndexPath:indexPath];
        [cell updateWithModel:viewModel]; //TODO: safety
    }
    else
    {//TODO: uncomment
//        NSAssert(cell, @"%@ does not have cell mapping for model class: %@", [self class], [viewModel class]);
        cell = [listView defaultCell];
    }
    
    return cell;
}

- (nullable id<ANListControllerUpdateViewInterface>)supplementaryViewForModel:(id)viewModel
                                                                         kind:(NSString*)kind
                                                                 forIndexPath:(nullable NSIndexPath*)indexPath
{
    NSString* identifier = [self.mappingService identifierForViewModelClass:[viewModel class] kind:kind];
    id<ANListControllerUpdateViewInterface> view = nil;
    id<ANListViewInterface> listView = self.listView;
    if (identifier)
    {
        view = [listView supplementaryViewForReuseIdentifer:identifier kind:kind atIndexPath:indexPath];
        [view updateWithModel:viewModel];
    }
    else
    { //TODO: uncomment
//        NSAssert(view, @"%@ does not have supplementary mapping for model class: %@",
//                 [self class], [viewModel class]);
        view = [listView defaultSupplementary];
    }
    return view;
}


#pragma mark - Private

- (id<ANListControllerMappingServiceInterface>)mappingService
{
    if (!_mappingService)
    {
        _mappingService = [ANListControllerMappingService new];
    }
    return _mappingService;
}

@end
