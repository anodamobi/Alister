//
//  ANTableControllerManager.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANTableControllerManager.h"
#import "ANStorage.h"
#import "ANStorageSectionModel.h"
#import "ANTableControllerUpdater.h"
#import "ANListControllerItemsHandler.h"
#import "ANListControllerConfigurationModel.h"

@interface ANTableControllerManager () <ANListControllerItemsHandlerDelegate, ANTableControllerUpdaterDelegate>

@property (nonatomic, strong) ANListControllerItemsHandler* cellFactory;
@property (nonatomic, strong) ANTableControllerUpdater* updateController;
@property (nonatomic, strong) ANListControllerConfigurationModel* configurationModel;

@end

@implementation ANTableControllerManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.cellFactory = [ANListControllerItemsHandler handlerWithDelegate:self];
        self.updateController = [ANTableControllerUpdater new];
        self.updateController.delegate = self;
        
        self.configurationModel = [ANListControllerConfigurationModel defaultModel];
    }
    return self;
}

- (id<ANListControllerReusableInterface>)reusableViewsHandler
{
    return self.cellFactory;
}

- (id<ANStorageUpdatingInterface>)updateHandler
{
    return self.updateController;
}

- (UITableView*)tableView
{
    return [self.delegate tableView];
}

- (id<ANListControllerWrapperInterface>)listViewWrapper
{
    return [self.delegate listViewWrapper];
}


#pragma mark - UITableView Delegate Helpers

- (NSString*)titleForSupplementaryIndex:(NSInteger)index type:(ANTableViewSupplementaryType)type
{
    id model = [self supplementaryModelForIndex:index type:type];
    if ([model isKindOfClass:[NSString class]])
    {
        UIView* view = [self supplementaryViewForIndex:index type:type];
        if (!view)
        {
            return model;
        }
    }
    return nil;
}

- (UIView*)supplementaryViewForIndex:(NSInteger)index type:(ANTableViewSupplementaryType)type
{
    id model = [self supplementaryModelForIndex:index type:type];
    BOOL isHeader = (type == ANTableViewSupplementaryTypeHeader);
    NSString* kind = isHeader ? self.configurationModel.defaultHeaderSupplementary : self.configurationModel.defaultFooterSupplementary;
    
    return (UIView*)[self.cellFactory supplementaryViewForModel:model kind:kind forIndexPath:nil];
}

- (id)supplementaryModelForIndex:(NSInteger)index type:(ANTableViewSupplementaryType)type
{
    BOOL isHeader = (type == ANTableViewSupplementaryTypeHeader);
    BOOL value = isHeader ?
    self.configurationModel.shouldDisplayHeaderOnEmptySection :
    self.configurationModel.shouldDisplayFooterOnEmptySection;
    ANStorage* storage = self.delegate.currentStorage;
    
    if ((storage.sections.count && [[storage sectionAtIndex:index] numberOfObjects]) || value)
    {
        if (type == ANTableViewSupplementaryTypeHeader)
        {
            return [storage headerModelForSectionIndex:index];
        }
        else
        {
            return [storage footerModelForSectionIndex:index];
        }
    }
    return nil;
}

- (CGFloat)heightForSupplementaryIndex:(NSInteger)index type:(ANTableViewSupplementaryType)type
{
    //apple bug HACK: for plain tables, for bottom section separator visibility
    BOOL shouldMaskSeparator = ((self.tableView.style == UITableViewStylePlain) &&
                                (type == ANTableViewSupplementaryTypeFooter));
    
    CGFloat minHeight = shouldMaskSeparator ? 0.1 : CGFLOAT_MIN;
    id model = [self supplementaryModelForIndex:index type:type];
    if (model)
    {
        BOOL isTitleStyle = ([self titleForSupplementaryIndex:index type:type] != nil);
        if (isTitleStyle)
        {
            return UITableViewAutomaticDimension;
        }
        else
        {
            BOOL isHeader = (type == ANTableViewSupplementaryTypeHeader);
            return isHeader ? self.tableView.sectionHeaderHeight : self.tableView.sectionFooterHeight;
        }
    }
    else
    {
        return minHeight;
    }
}

- (UITableViewCell*)cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath
{
    return (UITableViewCell*)[self.cellFactory cellForModel:model atIndexPath:indexPath];
}

@end
