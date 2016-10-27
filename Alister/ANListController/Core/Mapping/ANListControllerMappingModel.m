//
//  ANListMappingModel.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerMappingModel.h"

@implementation ANListControllerMappingModel

+ (instancetype)modelWithMappingClass:(Class)mappingClass
                                 kind:(NSString*)kind
                             isSystem:(BOOL)isSystem
                      classIdentifier:(NSString*)classIdentifier
{
    return [[self alloc] initWithMappingClass:mappingClass kind:kind isSystem:isSystem classIdentifier:classIdentifier];
}

- (instancetype)initWithMappingClass:(Class)mappingClass
                                kind:(NSString*)kind
                            isSystem:(BOOL)isSystem
                     classIdentifier:(NSString*)classIdentifier
{
    self = [super init];
    if (self)
    {
        _mappingClass = mappingClass;
        _kind = kind;
        _isSystem = isSystem;
        _reuseIdentifier = classIdentifier;
    }
    return self;
}

@end
