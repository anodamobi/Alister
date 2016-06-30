//
//  ANListItemsBuilder.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerItemsHandler.h"
#import "ANListControllerMappingService.h"
#import "ANListControllerMappingModel.h"

@interface ANListControllerItemsHandler ()

@property (nonatomic, weak) id<ANListControllerItemsHandlerDelegate> delegate;
@property (nonatomic, strong) ANListControllerMappingService* mappingService;

@end

@implementation ANListControllerItemsHandler

+ (instancetype)handlerWithDelegate:(id<ANListControllerItemsHandlerDelegate>)delegate
{
    ANListControllerItemsHandler* model = [self new];
    model.delegate = delegate;
    return model;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.mappingService = [ANListControllerMappingService new];
    }
    return self;
}

- (NSString*)headerDefaultKind
{
    return [self.delegate configurationModel].defaultHeaderSupplementary;
}

- (NSString*)footerDefaultKind
{
    return [self.delegate configurationModel].defaultFooterSupplementary;
}


#pragma mark - ANListControllerReusableInterface
#pragma mark - Supplementaries

- (void)registerFooterClass:(Class)viewClass forModelClass:(Class)modelClass
{
    [self _registerSupplementaryClass:viewClass forViewModelClass:modelClass kind:self.footerDefaultKind isSystem:NO];
}

- (void)registerHeaderClass:(Class)viewClass forModelClass:(Class)modelClass
{
    [self _registerSupplementaryClass:viewClass forViewModelClass:modelClass kind:self.headerDefaultKind isSystem:NO];
}

- (void)registerHeaderClass:(Class)viewClass forSystemClass:(Class)modelClass
{
    [self _registerSupplementaryClass:viewClass forViewModelClass:modelClass kind:self.headerDefaultKind isSystem:YES];
}

- (void)registerFooterClass:(Class)viewClass forSystemClass:(Class)modelClass
{
    [self _registerSupplementaryClass:viewClass forViewModelClass:modelClass kind:self.footerDefaultKind isSystem:YES];
}

- (void)registerSupplementaryClass:(Class)supplementaryClass forSystemClass:(Class)modelClass kind:(NSString*)kind
{
    [self _registerSupplementaryClass:supplementaryClass forViewModelClass:modelClass kind:kind isSystem:NO];
}

- (void)registerSupplementaryClass:(Class)supplementaryClass forModelClass:(Class)modelClass kind:(NSString*)kind
{
    [self _registerSupplementaryClass:supplementaryClass forViewModelClass:modelClass kind:kind isSystem:YES];
}


#pragma mark - Cells

- (void)registerCellClass:(Class)cellClass forModelClass:(Class)modelClass
{
    [self _registerCellClass:cellClass forViewModelClass:modelClass isSystem:NO];
}

- (void)registerCellClass:(Class)cellClass forSystemClass:(Class)modelClass
{
    [self _registerCellClass:cellClass forViewModelClass:modelClass isSystem:YES];
}


#pragma mark - Loading

- (id<ANListControllerUpdateViewInterface>)cellForModel:(id)viewModel atIndexPath:(NSIndexPath*)indexPath
{
    ANListControllerMappingModel* mapping = [self.mappingService findCellMappingForViewModel:viewModel];
    NSAssert(mapping, @"%@ does not have cell mapping for model class: %@",[self class], [viewModel class]);
    
    id<ANListControllerUpdateViewInterface> cell = nil;
    if (mapping)
    {
        cell = [[self.delegate listViewWrapper] cellForReuseIdentifier:mapping.classIdentifier ? : @""
                                                           atIndexPath:indexPath];
        [cell updateWithModel:viewModel];
    }
    NSParameterAssert(cell);
    return cell;
}

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForModel:(id)viewModel kind:(NSString*)kind forIndexPath:(NSIndexPath*)indexPath
{
    ANListControllerMappingModel* mapping = [self.mappingService findSupplementaryMappingForViewModel:viewModel kind:kind];
    id<ANListControllerUpdateViewInterface> view = nil;
    if (mapping)
    {
        view = [[self.delegate listViewWrapper] supplementaryViewForReuseIdentifer:mapping.classIdentifier ? : @""
                                                                              kind:mapping.kind
                                                                       atIndexPath:indexPath];
        [view updateWithModel:viewModel];
    }
    return view;
}


#pragma mark - Private

- (void)_registerSupplementaryClass:(Class)viewClass
                  forViewModelClass:(Class)viewModelClass
                               kind:(NSString*)kind
                           isSystem:(BOOL)isSystem
{
    NSParameterAssert(kind);
    
    ANListControllerMappingModel* mapping = [self.mappingService mappingForViewModelClass:viewModelClass
                                                                                     kind:kind
                                                                                 isSystem:isSystem];
    [[self.delegate listViewWrapper] registerSupplementaryClass:viewClass
                                                reuseIdentifier:mapping.classIdentifier
                                                           kind:kind];
    [self.mappingService addMapping:mapping];
}

- (void)_registerCellClass:(Class)cellClass forViewModelClass:(Class)viewModelClass isSystem:(BOOL)isSystem
{
    ANListControllerMappingModel* mapping = [self.mappingService cellMappingForViewModelClass:viewModelClass
                                                                                     isSystem:isSystem];
    
    [[self.delegate listViewWrapper] registerCellClass:cellClass forReuseIdentifier:mapping.classIdentifier];
    [self.mappingService addMapping:mapping];
}

@end
