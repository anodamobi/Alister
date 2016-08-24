//
//  ANTestableListControllerUpdateOperationDelegate.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ANTableControllerUpdateOperation.h"
#import "ANTestableTableView.h"

@interface ANTestableListControllerUpdateOperationDelegate : NSObject <ANListControllerUpdateOperationDelegate>

- (void)updateWithTestableTableView:(ANTestableTableView*)tableView;

@end
