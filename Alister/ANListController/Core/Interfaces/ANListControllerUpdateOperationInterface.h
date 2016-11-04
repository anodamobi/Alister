//
//  ANListControllerUpdateOperationInterface.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageListUpdateOperationInterface.h"
#import "ANListViewInterface.h"

@protocol ANListControllerUpdateOperationInterface <ANStorageListUpdateOperationInterface>

- (void)setDelegate:(id)delegate;
- (void)setShouldAnimate:(BOOL)shouldAnimate;

@end


@protocol ANListControllerUpdateOperationDelegate <NSObject>

- (id<ANListViewInterface>)listView;
- (void)storageNeedsReloadWithIdentifier:(NSString*)identifier;

@end
