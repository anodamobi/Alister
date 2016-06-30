//
//  ANTableControllerReloadOperation.h
//  PetrolApp
//
//  Created by Oksana Kovalchuk on 2/15/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@class ANListControllerConfigurationModel;

@protocol ANTableControllerReloadOperationDelegate <NSObject>

- (UITableView*)tableView;
- (ANListControllerConfigurationModel*)configurationModel;

@end

@interface ANTableControllerReloadOperation : NSOperation

@property (nonatomic, weak) id<ANTableControllerReloadOperationDelegate> delegate;

+ (instancetype)reloadOperationWithAnimation:(BOOL)shouldAnimate;

@end
