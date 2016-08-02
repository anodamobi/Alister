//
//  ANBaseTableHeaderFooterView.h
//
//  Created by Oksana Kovalchuk on 4/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANBaseTableViewHeaderFooterView.h"

@interface ANBaseTableHeaderView : ANBaseTableViewHeaderFooterView

@property (nonatomic, assign) UIEdgeInsets titleInsets;
@property (nonatomic, strong) UILabel* titleLabel;

@end
