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

@property (nonatomic, strong) NSMutableDictionary* viewModelToIndentifierMap;

@end

@implementation ANListControllerMappingService

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.mappings = [NSMutableArray new];
        self.viewModelToIndentifierMap = [NSMutableDictionary new];
    }
    return self;
}

- (NSString*)registerIdentifierForViewModel:(Class)viewModelClass
{
    NSString* identifier = nil;
    if (viewModelClass)
    {
        identifier = NSStringFromClass(viewModelClass);
        [self.viewModelToIndentifierMap setObject:identifier forKey:viewModelClass];
    }
    return identifier;
}

- (NSString*)registerIdentifierForViewModel:(Class)viewModelClass kind:(NSString*)kind
{
    
}

- (NSString*)identifierForViewModel:(Class)keyClass
{
    NSString* identifier = nil;
    
    if (keyClass)
    {
        identifier = [self.viewModelToIndentifierMap objectForKey:keyClass];
        
        if (!identifier)
        {
            // No mapping found for this key class, but it may be a subclass of another object that does
            // have a mapping, so let's see what we can find.
            Class superClass = nil;
            for (Class class in self.viewModelToIndentifierMap.allKeys)
            {
                // We want to find the lowest node in the class hierarchy so that we pick the lowest ancestor
                // in the hierarchy tree.
                if ([keyClass isSubclassOfClass:class] && (!superClass || [class isSubclassOfClass:superClass]))
                {
                    superClass = class;
                }
            }
            
            if (nil != superClass)
            {
                identifier = [self.viewModelToIndentifierMap objectForKey:superClass];
                
                // Add this subclass to the map so that next time this result is instant.
                [self.viewModelToIndentifierMap setObject:identifier forKey:keyClass];
            }
        }
        
        if (!identifier)
        {
            // We couldn't find a mapping at all so let's add an empty mapping.
            [self.viewModelToIndentifierMap setObject:[NSNull class] forKey:keyClass];
            
        }
        else if (identifier == [NSNull class])
        {
            // Don't return null mappings.
            identifier = nil;
        }
    }
    return identifier;
}

- (NSString*)identifierForViewModel:(Class)viewModelClass kind:(NSString*)kind
{
    return nil;
}




- (ANListControllerMappingModel*)mappingForViewModelClass:(Class)viewModelClass kind:(NSString*)kind isSystem:(BOOL)isSystem
{
    NSAssert(viewModelClass, @"You must provide viewModel class for cell");
    NSAssert(kind, @"You must kind type for list item");
    
    ANListControllerMappingModel* model = [self _existingMappingForViewModel:viewModelClass kind:kind];
    if (!model)
    {
        model = [ANListControllerMappingModel modelWithMappingClass:viewModelClass
                                                               kind:kind
                                                           isSystem:isSystem
                                                    classIdentifier:NSStringFromClass(viewModelClass)];
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
    [self.mappings addObject:model];
}


#pragma mark - Private

- (ANListControllerMappingModel*)_existingMappingForViewModel:(Class)viewModel kind:(NSString*)kind
{
    __block ANListControllerMappingModel* mappingModel = nil;
    
    [self.mappings enumerateObjectsUsingBlock:^(ANListControllerMappingModel*  _Nonnull obj, __unused NSUInteger idx, BOOL*  _Nonnull stop) {
        
        if ([obj.kind isEqualToString:kind])
        {
            if (obj.isSystem)
            {
                if ([viewModel isKindOfClass:obj.mappingClass])
                {
                    mappingModel = obj;
                    * stop = YES;
                }
            }
            else
            {
                if ([viewModel isMemberOfClass:obj.mappingClass])
                {
                    mappingModel = obj;
                    * stop = YES;
                }
            }
        }
    }];
    return mappingModel;
}

@end
