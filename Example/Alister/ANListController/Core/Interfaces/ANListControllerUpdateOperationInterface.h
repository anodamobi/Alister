//
//  ANListControllerUpdateOperationInterface.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@protocol ANStorageUpdateCollectionOperationInterface;

@protocol ANListControllerUpdateOperationInterface <ANStorageUpdateCollectionOperationInterface>

- (void)setDelegate:(id)delegate;
- (void)setName:(NSString*)name;
- (void)setShouldAnimate:(BOOL)shouldAnimate;

@end
