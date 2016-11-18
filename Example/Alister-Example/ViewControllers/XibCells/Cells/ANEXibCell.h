//
//  ANEXibCell.h
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANBaseTableViewCell.h"
#import "ANEXibCellViewModel.h"

@interface ANEXibCell : ANBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

@end
