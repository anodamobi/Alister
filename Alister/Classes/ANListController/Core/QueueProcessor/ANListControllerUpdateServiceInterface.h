//
//  ANListControllerQueueProcessorInterface.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/4/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@protocol ANListViewInterface;

@protocol ANListControllerUpdateServiceInterface <NSObject>

- (void)storageNeedsReloadWithIdentifier:(NSString*)identifier animated:(BOOL)isAnimated;
- (id<ANListViewInterface>)listView;

@end
