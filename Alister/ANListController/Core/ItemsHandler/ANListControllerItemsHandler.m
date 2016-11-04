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

@interface ANListControllerItemsHandler ()

@property (nonatomic, strong) id<ANListControllerMappingServiceInterface> mappingService;
@property (nonatomic, weak) id<ANListViewInterface> listView;

@end

@implementation ANListControllerItemsHandler

- (instancetype)initWithListView:(id<ANListViewInterface>)listView
                  mappingService:(id<ANListControllerMappingServiceInterface>)mappingService
{
    self = [super init];
    if (self)
    {
        self.listView = listView;
        self.mappingService = mappingService;
    }
    return self;
}


#pragma mark - ANListControllerReusableInterface

- (void)registerFooterClass:(Class)viewClass forModelClass:(Class)modelClass
{
    [self registerSupplementaryClass:viewClass forModelClass:modelClass kind:self.listView.footerDefaultKind];
}

- (void)registerHeaderClass:(Class)viewClass forModelClass:(Class)modelClass
{
    [self registerSupplementaryClass:viewClass forModelClass:modelClass kind:self.listView.headerDefaultKind];
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
        NSLog(@"No mapping was created for supplementary!"); //TODO: wrap logs
    }
}


#pragma mark - Cells

- (void)registerCellClass:(Class)cellClass forModelClass:(Class)modelClass
{
    NSString* identifier = [self.mappingService registerViewModelClass:modelClass];
    if (identifier)
    {
        [self.listView registerCellClass:cellClass forReuseIdentifier:identifier];
    }
    else
    {
        NSLog(@"No mapping was created for cell!"); //TODO: wrap logs
    }
}


#pragma mark - Loading

- (id<ANListControllerUpdateViewInterface>)cellForModel:(id)viewModel atIndexPath:(NSIndexPath*)indexPath
{
    NSString* identifier = [self.mappingService identifierForViewModelClass:[viewModel class]];
    id<ANListControllerUpdateViewInterface> cell = nil;
    if (identifier)
    {
        cell = [self.listView cellForReuseIdentifier:identifier atIndexPath:indexPath];
        [cell updateWithModel:viewModel]; //TODO: safety
    }
    else
    {
        NSLog(@"%@ does not have cell mapping for model class: %@", [self class], [viewModel class]);; //TODO: wrap logs
    }
    
    NSParameterAssert(cell);
    return cell;
}

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForModel:(id)viewModel
                                                                kind:(NSString*)kind
                                                        forIndexPath:(NSIndexPath*)indexPath
{
    NSString* identifier = [self.mappingService identifierForViewModelClass:[viewModel class]];
    id<ANListControllerUpdateViewInterface> view = nil;
    if (identifier)
    {
        id<ANListViewInterface> wrapper = self.listView;
        view = [wrapper supplementaryViewForReuseIdentifer:identifier kind:kind atIndexPath:indexPath];
        [view updateWithModel:viewModel]; //TODO: safety
    }
    else
    {
        NSLog(@"%@ does not have supplementary mapping for model class: %@",
              [self class], [viewModel class]); //TODO: wrap logs
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
