//
//  ANListControllerMappingService.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerMappingService.h"

static NSString* const kCellConstant = @"kANCellIdentifier";

@interface ANListControllerMappingService ()

@property (nonatomic, strong) NSMutableArray* mappings;

@end

@implementation ANListControllerMappingService

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.mappings = [NSMutableArray new];
    }
    return self;
}

- (ANListControllerMappingModel*)mappingForViewModelClass:(Class)viewModelClass kind:(NSString*)kind isSystem:(BOOL)isSystem
{
    NSAssert(viewModelClass, @"You must provide viewModel class for cell");
    NSAssert(kind, @"You must kind type for list item");
    
    ANListControllerMappingModel* model = [self _existingMappingForViewModel:viewModelClass kind:kind];
    if (!model)
    {
        model = [ANListControllerMappingModel new];
        model.classIdentifier = NSStringFromClass(viewModelClass);
        model.isSystem = isSystem;
        model.mappingClass = viewModelClass;
        model.kind = kind;
    }
    return model;
}

- (ANListControllerMappingModel*)cellMappingForViewModelClass:(Class)viewModelClass isSystem:(BOOL)isSystem
{
    return [self mappingForViewModelClass:viewModelClass kind:kCellConstant isSystem:isSystem];
}

- (ANListControllerMappingModel*)findCellMappingForViewModel:(id)viewModel
{
    return [self _existingMappingForViewModel:viewModel kind:kCellConstant];
}

- (ANListControllerMappingModel*)findSupplementaryMappingForViewModel:(id)viewModel kind:(NSString*)kind
{
    return [self _existingMappingForViewModel:viewModel kind:kind];
}

- (void)addMapping:(ANListControllerMappingModel*)model
{
    [self _addMapping:model];
}


#pragma mark - Private

- (ANListControllerMappingModel*)_existingMappingForViewModel:(Class)viewModel kind:(NSString*)kind
{
    __block ANListControllerMappingModel* mappingModel = nil;
    
    [self.mappings enumerateObjectsUsingBlock:^(ANListControllerMappingModel*  _Nonnull obj, __unused NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.kind isEqualToString:kind])
        {
            if (obj.isSystem)
            {
                if ([viewModel isKindOfClass:obj.mappingClass])
                {
                    mappingModel = obj;
                    *stop = YES;
                }
            }
            else
            {
                if ([viewModel isMemberOfClass:obj.mappingClass])
                {
                    mappingModel = obj;
                    *stop = YES;
                }
            }
        }
    }];
    return mappingModel;
}


#pragma mark - Private

- (void)_addMapping:(ANListControllerMappingModel*)model
{
    [self.mappings addObject:model];
}

@end
