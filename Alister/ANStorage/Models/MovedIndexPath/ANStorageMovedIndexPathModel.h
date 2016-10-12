//
//  ANStorageMovedIndexPath.h
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

@interface ANStorageMovedIndexPathModel : NSObject

@property (nonatomic, strong) NSIndexPath* fromIndexPath;
@property (nonatomic, strong) NSIndexPath* toIndexPath;

+ (instancetype)modelWithFromIndexPath:(NSIndexPath*)fromIndexPath
                           toIndexPath:(NSIndexPath*)indexPath;

@end
