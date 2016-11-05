//
//  SMTableContainerView.m
//  Wallper
//
//  Created by ANODA on 1/13/15.
//  Copyright (c) 2015 ANODA. All rights reserved.
//

#import "ANTableContainerView.h"
#import "ANTableView.h"
#import "Masonry.h"

@implementation ANTableContainerView

+ (instancetype)containerWithTableViewStyle:(UITableViewStyle)style
{
    return [[self alloc] initWithTableViewStyle:style];
}

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self)
    {
        ANTableView* tableView = [[ANTableView alloc] initWithFrame:CGRectZero style:style];
        _tableView = tableView;
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
