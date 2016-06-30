//
//  ANListControllerQueueProcessor.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@protocol ANListControllerConfigurationModelInterface;

@protocol ANListControllerQueueProcessorDelegate <NSObject>

- (id<ANListControllerConfigurationModelInterface>)configurationModel;
- (void)reloadFinished;

@end

@interface ANListControllerQueueProcessor : NSObject

@property (nonatomic, weak) id<ANListControllerQueueProcessorDelegate> delegate;
@property (nonatomic, strong) Class updateOperationClass;
@property (nonatomic, strong) Class reloadOperationClass;

@end
