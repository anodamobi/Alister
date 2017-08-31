//
//  ANStorageMovedIndexPath.h
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

/**
 This is a private class for Alister. You should not call this methods directly.
 */
@interface ANStorageMovedIndexPathModel : NSObject

/**
 Indicates FROM which position item will be moved
 */
@property (nonatomic, strong, nullable) NSIndexPath* fromIndexPath;

/**
  Indicates TO which position item will be moved
 */
@property (nonatomic, strong, nullable) NSIndexPath* toIndexPath;


/**
 Designated initializer

 @param fromIndexPath from which indexPath item will be moved
 @param indexPath     where item should be placed after update

 @return ANStorageMovedIndexPathModel* new instance of object with setted properties.
 */
+ (instancetype)modelWithFromIndexPath:(NSIndexPath*)fromIndexPath
                           toIndexPath:(NSIndexPath*)indexPath;

@end

NS_ASSUME_NONNULL_END
