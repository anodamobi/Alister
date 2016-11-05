//
//  ANTestableTableView.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableTableView.h"

@implementation ANTestableTableView

- (void)reloadData
{
    
}

- (void)registerCellClass:(Class)cellClass forReuseIdentifier:(NSString *)identifier
{
    
}

- (void)setDataSource:(id)dataSource
{
    
}

- (void)setDelegate:(id)delegate
{
    
}

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForReuseIdentifer:(NSString *)reuseIdentifier
                                                                         kind:(NSString *)kind
                                                                  atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (id<ANListControllerUpdateViewInterface>)cellForReuseIdentifier:(NSString *)reuseIdentifier
                                                      atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)registerSupplementaryClass:(Class)supplementaryClass
                   reuseIdentifier:(NSString *)reuseIdentifier
                              kind:(NSString *)kind
{
    
}

- (UIScrollView*)view
{
    return nil;
}

- (NSString*)headerDefaultKind
{
    return nil;
}

- (NSString*)footerDefaultKind
{
    return nil;
}

- (CGFloat)reloadAnimationDuration
{
    return 0;
}

- (NSString *)animationKey
{
    return nil;
}

- (void)performUpdate:(ANStorageUpdateModel *)update animated:(BOOL)animated
{
    
}

@end
