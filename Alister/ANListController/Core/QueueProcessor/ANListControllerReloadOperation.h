//
//  ANListControllerReloadOperation.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@protocol ANListControllerUpdateServiceInterface;

@interface ANListControllerReloadOperation : NSOperation

@property (nonatomic, assign) BOOL shouldAnimate;
@property (nonatomic, weak) id<ANListControllerUpdateServiceInterface> delegate;

@end
