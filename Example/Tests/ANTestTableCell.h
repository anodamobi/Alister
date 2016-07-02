//
//  ANTestTableCellTableViewCell.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/2/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerUpdateViewInterface.h"

@interface ANTestTableCell : UITableViewCell<ANListControllerUpdateViewInterface>

@property (nonatomic, strong) id model;

@end
