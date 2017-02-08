//
//  ANStorageFakeOperationDelegate.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/26/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageFakeOperationDelegate.h"

@implementation ANStorageFakeOperationDelegate

- (void)collectUpdate:(ANStorageUpdateModel*)updateModel
{
    self.lastUpdate = updateModel;
}

- (id<ANListViewInterface>)listView
{
    return nil;
}

- (void)storageNeedsReloadWithIdentifier:(NSString *)identifier animated:(BOOL)isAnimated
{
    
}

- (void)storageUpdateModelGenerated:(ANStorageUpdateModel *)updateModel
{
    
}

@end
