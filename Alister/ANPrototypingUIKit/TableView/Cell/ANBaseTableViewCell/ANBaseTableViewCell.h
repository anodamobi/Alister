//
//  ANTableViewController.h
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANListControllerUpdateViewInterface.h"

@interface ANBaseTableViewCell : UITableViewCell <ANListControllerUpdateViewInterface>

@property (nonatomic, assign) BOOL isTransparent;
@property (nonatomic, strong, nonnull) UIColor* selectionColor;

@end
