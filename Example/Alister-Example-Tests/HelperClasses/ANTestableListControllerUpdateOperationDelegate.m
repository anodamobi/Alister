//
//  ANTestableListControllerUpdateOperationDelegate.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableListControllerUpdateOperationDelegate.h"
#import "ANTestableListView.h"
#import "ANListControllerConfigurationModel.h"

@interface ANTestableListControllerUpdateOperationDelegate ()

@property (nonatomic, strong) ANTestableTableView* tableView;

@end

@implementation ANTestableListControllerUpdateOperationDelegate

- (void)updateWithTestableTableView:(ANTestableTableView*)tableView
{
    self.tableView = tableView;
}

- (id<ANListControllerConfigurationModelInterface>)configurationModel
{
    return [ANListControllerConfigurationModel defaultModel];
}

- (UIView<ANListViewInterface>*)listView
{
    return self.tableView;
}

- (void)storageNeedsReloadWithIdentifier:(NSString *)identifier
{

}

@end
