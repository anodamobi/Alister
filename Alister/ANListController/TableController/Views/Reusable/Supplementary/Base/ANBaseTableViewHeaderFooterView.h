//
//  ANTableViewHeaderFooterView.h
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANListControllerUpdateViewInterface.h"

@interface ANBaseTableViewHeaderFooterView : UITableViewHeaderFooterView <ANListControllerUpdateViewInterface>

@property (nonatomic, assign) BOOL isTransparent;

@end
