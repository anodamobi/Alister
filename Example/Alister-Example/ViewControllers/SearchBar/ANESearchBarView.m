//
//  ANESearchBarView.m
//  Alister-Example
//
//  Created by ANODA on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANESearchBarView.h"
#import "ANTableView.h"

static CGFloat const kANESearchBarViewNavigationBarHeight = 64.f;
static CGFloat const kANESearchBarViewSearchBarHeight = 44.f;

@implementation ANESearchBarView

- (void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    self.searchBar.frame = CGRectMake(0, kANESearchBarViewNavigationBarHeight, width, kANESearchBarViewSearchBarHeight);
    
    CGFloat searchBarMaxY = CGRectGetMaxY(self.searchBar.frame);
    self.tableView.frame = CGRectMake(0, searchBarMaxY, width, height - searchBarMaxY);
    
    [super layoutSubviews];
}


#pragma mark - Lazy Load

- (ANTableView*)tableView
{
    if (!_tableView)
    {
        _tableView = [[ANTableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
        [self addSubview:_tableView];
    }
    
    return _tableView;
}

- (UISearchBar*)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        [self addSubview:_searchBar];
    }
    
    return _searchBar;
}

@end
