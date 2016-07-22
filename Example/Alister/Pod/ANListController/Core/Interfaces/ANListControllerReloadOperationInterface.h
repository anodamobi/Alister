//
//  ANListControllerReloadOperationInterface.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@protocol ANListViewInterface;
@class ANListControllerConfigurationModel;

@protocol ANListControllerReloadOperationDelegate <NSObject>

- (UIView<ANListViewInterface>*)listView;
- (ANListControllerConfigurationModel*)configurationModel;

@end

@protocol ANListControllerReloadOperationInterface

- (void)setDelegate:(id<ANListControllerReloadOperationDelegate>)delegate;
- (void)setShouldAnimate:(BOOL)shouldAnimate;

@end


