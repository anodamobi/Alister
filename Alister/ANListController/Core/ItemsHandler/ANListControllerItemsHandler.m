//
//  ANListItemsBuilder.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerItemsHandler.h"
#import "ANListControllerMappingService.h"

@interface ANListControllerItemsHandler ()

@property (nonatomic, strong) ANListControllerMappingService* mappingService;

@end

@implementation ANListControllerItemsHandler

- (instancetype)initWithMappingService:(ANListControllerMappingService*)mappingService
{
    self = [super init];
    if (self)
    {
        self.mappingService = mappingService;
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
    [self registerSupplementaryClass:viewClass forModelClass:modelClass kind:self.footerDefaultKind];
}

- (void)registerHeaderClass:(Class)viewClass forModelClass:(Class)modelClass
{
    [self registerSupplementaryClass:viewClass forModelClass:modelClass kind:self.headerDefaultKind];
}

- (void)registerSupplementaryClass:(Class)supplementaryClass forModelClass:(Class)modelClass kind:(NSString*)kind
{
    NSString* identifier = [self.mappingService registerViewModelClass:modelClass kind:kind];
    if (identifier)
    {
        [[self.delegate listViewWrapper] registerSupplementaryClass:supplementaryClass
                                                    reuseIdentifier:identifier
                                                               kind:kind];
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
        [[self.delegate listViewWrapper] registerCellClass:cellClass forReuseIdentifier:identifier];
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
        cell = [[self.delegate listViewWrapper] cellForReuseIdentifier:identifier atIndexPath:indexPath];
        [cell updateWithModel:viewModel]; //TODO: safety
    }
    else
    {
         NSLog(@"%@ does not have cell mapping for model class: %@",[self class], [viewModel class]);; //TODO: wrap logs
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
        id<ANListControllerWrapperInterface> wrapper = [self.delegate listViewWrapper];
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

@end
