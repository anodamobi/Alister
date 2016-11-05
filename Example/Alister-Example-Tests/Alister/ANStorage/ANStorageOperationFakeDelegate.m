//
//  ANStorageOperationFakeDelegate.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageOperationFakeDelegate.h"

@implementation ANStorageOperationFakeDelegate

- (id<ANListViewInterface>)listView
{
    return nil;
}

- (void)storageNeedsReloadWithIdentifier:(NSString *)identifier animated:(BOOL)isAnimated
{
    
}

- (void)storageNeedsReloadWithIdentifier:(NSString *)identifier
{
    
}

@end
