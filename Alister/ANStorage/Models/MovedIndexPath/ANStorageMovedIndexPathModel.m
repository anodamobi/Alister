//
//  ANStorageMovedIndexPath.m
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANStorageMovedIndexPathModel.h"

@implementation ANStorageMovedIndexPathModel

+ (instancetype)modelWithFromIndexPath:(NSIndexPath*)fromIndexPath
                           toIndexPath:(NSIndexPath*)indexPath
{
    ANStorageMovedIndexPathModel* model = [self new];
    model.fromIndexPath = fromIndexPath;
    model.toIndexPath = indexPath;
    
    return model;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"fromIndexPath: %@, toIndexPath: %@", [self _descriptionStringForIndexPath:self.fromIndexPath],
                                                                             [self _descriptionStringForIndexPath:self.toIndexPath]];
}

- (NSString*)_descriptionStringForIndexPath:(NSIndexPath*)indexPath
{
    return [NSString stringWithFormat:@"length = %zd, path = %zd - %zd", indexPath.length, indexPath.section, indexPath.row];
}
                                   
@end
