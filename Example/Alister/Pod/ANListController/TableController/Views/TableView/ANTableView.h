//
//  ANTableView.h
//
//  Created by Oksana Kovalchuk on 4/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

@interface ANTableView : UITableView

@property (nonatomic, strong) UIView* bottomStickedFooterView;

+ (instancetype)cleanTableWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)setupAppearance;

@end
