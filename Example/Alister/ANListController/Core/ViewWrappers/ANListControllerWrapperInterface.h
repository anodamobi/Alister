//
//  ANListViewInterface.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerUpdateViewInterface.h"

@protocol ANListControllerWrapperInterface <NSObject>

- (void)registerSupplementaryClass:(Class)supplementaryClass
                   reuseIdentifier:(NSString*)reuseIdentifier
                              kind:(NSString*)kind;

- (void)registerCellClass:(Class)cellClass forReuseIdentifier:(NSString*)identifier;

- (id<ANListControllerUpdateViewInterface>)cellForReuseIdentifier:(NSString*)reuseIdentifier atIndexPath:(NSIndexPath*)indexPath;

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForReuseIdentifer:(NSString*)reuseIdentifier
                                                     kind:(NSString*)kind
                                              atIndexPath:(NSIndexPath*)indexPath;

- (UIScrollView*)view;

@end
