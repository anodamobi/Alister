//
//  ANTableView.h
//
//  Created by Oksana Kovalchuk on 4/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

@interface ANTableView : UITableView

+ (instancetype)tableViewDefaultStyleWithFrame:(CGRect)frame style:(UITableViewStyle)style;

- (void)addStickyFooter:(UIView*)footer withFixedHeight:(CGFloat)height;
- (void)updateStickerHeight:(CGFloat)height;

@end
