//
//  SMTableContainerView.h
//  Wallper
//
//  Created by ANODA on 1/13/15.
//  Copyright (c) 2015 ANODA. All rights reserved.
//

#import "ANTableView.h"

@interface ANTableContainerView : UIView

@property (nonatomic, strong, nonnull) ANTableView* tableView;

+ (instancetype _Nonnull)containerWithTableViewStyle:(UITableViewStyle)style;
- (instancetype _Nonnull)initWithTableViewStyle:(UITableViewStyle)style;

@end
