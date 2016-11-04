//
//  ANListControllerTableViewWrapper.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListViewInterface.h"

@interface ANListTableView : NSObject <ANListViewInterface>

+ (instancetype)wrapperWithTableView:(UITableView*)tableView;

@end
