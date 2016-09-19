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
@property (nonatomic, strong) ANTestableCollectionView* collectionView;

@end

@implementation ANTestableListControllerUpdateOperationDelegate

- (void)updateWithTestableTableView:(ANTestableTableView*)tableView
{
    self.tableView = tableView;
}

- (void)updateWithTestableCollectionView:(ANTestableCollectionView *)collectionView
{
    self.collectionView = collectionView;
}

- (id<ANListControllerConfigurationModelInterface>)configurationModel
{
    return [ANListControllerConfigurationModel defaultModel];
}

- (UIView<ANListViewInterface>*)listView
{
    UIView <ANListViewInterface> * view = nil;
    if (self.tableView)
    {
        view = self.tableView;
    }
    else if (self.collectionView)
    {
        view = self.collectionView;
    }
    
    return view;
}

- (void)storageNeedsReloadWithIdentifier:(NSString *)identifier
{

}

@end
