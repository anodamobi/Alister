//
//  ANTableControllerManager.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerManagerInterface.h"
#import "ANListControllerConfigurationModelInterface.h"

typedef NS_ENUM(NSInteger, ANTableViewSupplementaryType)
{
    ANTableViewSupplementaryTypeHeader,
    ANTableViewSupplementaryTypeFooter
};

@class ANTableViewFactory;
@class ANStorageUpdateController;
@class ANStorage;
@protocol ANListControllerWrapperInterface;

@protocol ANTableControllerManagerDelegate <NSObject>

- (ANStorage*)currentStorage;
- (UITableView*)tableView;
- (id<ANListControllerWrapperInterface>)listViewWrapper;
- (void)allUpdatesAreFinished;

@end

@interface ANTableControllerManager : NSObject <ANListControllerManagerInterface>

@property (nonatomic, weak) id<ANTableControllerManagerDelegate> delegate;

- (UITableViewCell*)cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath;
- (UIView*)supplementaryViewForIndex:(NSUInteger)index type:(ANTableViewSupplementaryType)type;

- (NSString*)titleForSupplementaryIndex:(NSUInteger)index type:(ANTableViewSupplementaryType)type;

- (id)supplementaryModelForIndex:(NSUInteger)index type:(ANTableViewSupplementaryType)type;
- (CGFloat)heightForSupplementaryIndex:(NSUInteger)index type:(ANTableViewSupplementaryType)type;

@end
