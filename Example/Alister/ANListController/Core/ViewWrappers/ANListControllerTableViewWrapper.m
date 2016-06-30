//
//  ANListControllerTableViewWrapper.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerTableViewWrapper.h"

@interface ANListControllerTableViewWrapper ()

@end

@implementation ANListControllerTableViewWrapper

+ (instancetype)wrapperWithDelegate:(id<ANListControllerTableViewWrapperDelegate>)delegate
{
    ANListControllerTableViewWrapper* wrapper = [self new];
    wrapper.delegate = delegate;
    return wrapper;
}

- (UIScrollView*)view
{
    return [self.delegate tableView];
}

- (void)registerSupplementaryClass:(Class)supplementaryClass
                    reuseIdentifier:(NSString*)reuseIdentifier
                               kind:(NSString*)kind
{
    NSAssert(kind, @"You must specify supplementary kind");
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(supplementaryClass, @"You must specify supplementary class");
    
    NSParameterAssert([supplementaryClass isSubclassOfClass:[UITableViewHeaderFooterView class]]);
    
    [self.delegate.tableView registerClass:supplementaryClass forHeaderFooterViewReuseIdentifier:reuseIdentifier];
}

- (void)registerCellClass:(Class)cellClass forReuseIdentifier:(NSString*)identifier
{
    NSAssert(cellClass, @"You must specify cell class");
    NSAssert(identifier, @"You must specify reuse identifier");
    
    [self.delegate.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (id<ANListControllerUpdateViewInterface>)cellForReuseIdentifier:(NSString*)reuseIdentifier atIndexPath:(NSIndexPath*)indexPath
{
    NSParameterAssert(reuseIdentifier);
    NSParameterAssert(indexPath);
    return [self.delegate.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
}

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForReuseIdentifer:(NSString*)reuseIdentifier
                                                     kind:(NSString*)kind
                                              atIndexPath:(NSIndexPath*)indexPath
{
    NSParameterAssert(reuseIdentifier);
    return [self.delegate.tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
}

@end
