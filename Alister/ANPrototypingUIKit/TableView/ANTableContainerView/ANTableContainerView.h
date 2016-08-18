//
//  SMTableContainerView.h
//  Wallper
//
//  Created by ANODA on 1/13/15.
//  Copyright (c) 2015 ANODA. All rights reserved.
//

#import "ANTableView.h"

@interface ANTableContainerView : UIView

@property (nonatomic, strong) ANTableView* tableView;

+ (instancetype)containerWithTableViewStyle:(UITableViewStyle)style;
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
