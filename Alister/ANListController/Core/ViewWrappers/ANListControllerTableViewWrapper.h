//
//  ANListControllerTableViewWrapper.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerWrapperInterface.h"

@protocol ANListControllerTableViewWrapperDelegate <NSObject>

- (UITableView*)tableView;

@end

@interface ANListControllerTableViewWrapper : NSObject <ANListControllerWrapperInterface>

@property (nonatomic, weak) id<ANListControllerTableViewWrapperDelegate> delegate;

+ (instancetype)wrapperWithDelegate:(id<ANListControllerTableViewWrapperDelegate>)delegate;

@end
