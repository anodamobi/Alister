//
//  ANListControllerTableViewWrapper.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListViewInterface.h"

@class ANTableUpdateConfigurationModel;

@interface ANListTableView : NSObject <ANListViewInterface>

@property (nonatomic, strong) ANTableUpdateConfigurationModel* configModel;

+ (instancetype)wrapperWithTableView:(UITableView*)tableView;

@end
