//
//  ANBaseDomainModel.m
//
//  Created by Oksana Kovalchuk on 18/12/14.
//  Copyright (c) 2014 Oksana Kovalchuk. All rights reserved.
//

#import "ANBaseDomainModel.h"
#import <objc/runtime.h>
#import <libextobjc/extobjc.h>

// Used to cache the reflection performed in +propertyKeys.
static void *ANBaseModelCachedPropertyKeysKey = &ANBaseModelCachedPropertyKeysKey;

@implementation ANBaseDomainModel


#pragma mark NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, self.dictionaryValue];
}


#pragma mark Reflection

+ (void)enumeratePropertiesUsingBlock:(void (^)(objc_property_t property, BOOL *stop))block
{
    Class cls = self;
    BOOL stop = NO;
    
    while (!stop && ![cls isEqual:[ANBaseDomainModel class]])
    {
        unsigned count = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        
        cls = cls.superclass;
        if (properties == NULL) continue;
        
        @onExit {
            free(properties);
        };
        
        for (unsigned i = 0; i < count; i++)
        {
            block(properties[i], &stop);
            if (stop) break;
        }
    }
}

+ (NSSet*)propertyKeys
{
    NSSet *cachedKeys = objc_getAssociatedObject(self, ANBaseModelCachedPropertyKeysKey);
    if (cachedKeys != nil) return cachedKeys;
    
    NSMutableSet *keys = [NSMutableSet set];
    
    [self enumeratePropertiesUsingBlock:^(objc_property_t property, BOOL *stop) {
        
        ext_propertyAttributes *attributes = ext_copyPropertyAttributes(property);
        @onExit {
            free(attributes);
        };
        
        if (attributes->readonly && attributes->ivar == NULL) return;
        
        NSString *key = @(property_getName(property));
        [keys addObject:key];
    }];
    
    // It doesn't really matter if we replace another thread's work, since we do
    // it atomically and the result should be the same.
    objc_setAssociatedObject(self, ANBaseModelCachedPropertyKeysKey, keys, OBJC_ASSOCIATION_COPY);
    
    return keys;
}

- (NSDictionary*)dictionaryValue
{
    return [self dictionaryWithValuesForKeys:self.class.propertyKeys.allObjects];
}


@end
