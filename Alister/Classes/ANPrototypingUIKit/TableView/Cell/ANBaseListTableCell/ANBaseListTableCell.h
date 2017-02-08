//
//  ANBaseListTableCell.h
//  Wallper
//
//  Created by ANODA on 4/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANBaseTableViewCell.h"

@interface ANBaseListTableCell : ANBaseTableViewCell

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* iconImageView;

+ (void)updateBaseColor:(UIColor*)baseColor andTextColor:(UIColor*)textColor;

@end
