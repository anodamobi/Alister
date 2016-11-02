//
//  ANTableControllerManager.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerManagerInterface.h"
#import "ANListControllerConfigurationModelInterface.h"

@class ANTableViewFactory;
@class ANStorageUpdateController;
@class ANStorage;
@protocol ANListControllerWrapperInterface;

@protocol ANTableControllerManagerDelegate <NSObject>

- (ANStorage*)currentStorage;
- (UITableView*)tableView;
- (id<ANListControllerWrapperInterface>)listViewWrapper;
- (void)allUpdatesWereFinished;

@end

@interface ANTableControllerManager : NSObject <ANListControllerManagerInterface>

@property (nonatomic, weak) id<ANTableControllerManagerDelegate> delegate;

//- (UITableViewCell*)cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath;
//- (UIView*)supplementaryViewForIndex:(NSUInteger)index kind:(NSString*)kind;
//
//- (NSString*)titleForSupplementaryIndex:(NSUInteger)index kind:(NSString*)kind;
//
//- (id)supplementaryModelForIndex:(NSUInteger)index kind:(NSString*)kind;
//- (CGFloat)heightForSupplementaryIndex:(NSUInteger)index kind:(NSString*)kind;

@end
