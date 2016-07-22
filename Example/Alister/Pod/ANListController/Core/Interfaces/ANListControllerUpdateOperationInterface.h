//
//  ANListControllerUpdateOperationInterface.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageListUpdateOperationInterface.h"

@protocol ANListControllerUpdateOperationInterface <ANStorageListUpdateOperationInterface>

- (void)setDelegate:(id)delegate;

@end


@protocol ANListControllerConfigurationModelInterface;
@protocol ANListViewInterface;

@protocol ANListControllerUpdateOperationDelegate <NSObject>

- (UIView<ANListViewInterface>*)listView;
- (id<ANListControllerConfigurationModelInterface>)configurationModel;
- (void)storageNeedsReloadWithIdentifier:(NSString*)identifier;

@end
