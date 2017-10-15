//
//  ANBaseListTableCell.h
//  Wallper
//
//  Created by ANODA on 4/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANBaseTableViewCell.h"

@interface ANBaseListTableCell : ANBaseTableViewCell

@property (nonatomic, strong, nonnull) UILabel* titleLabel;
@property (nonatomic, strong, nonnull) UIImageView* iconImageView;

+ (void)updateBaseColor:(UIColor* _Nonnull)baseColor andTextColor:(UIColor* _Nonnull)textColor;

@end
