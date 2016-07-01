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
#import "ANListControllerQueueProcessor.h"
#import "ANListControllerItemsHandler.h"
#import "ANListControllerConfigurationModel.h"
#import "ANTableControllerUpdateOperation.h"

@interface ANTableControllerManager () <ANListControllerItemsHandlerDelegate, ANListControllerQueueProcessorDelegate>

@property (nonatomic, strong) ANListControllerItemsHandler* cellItemsHandler;
@property (nonatomic, strong) ANListControllerQueueProcessor* updateProcessor;
@property (nonatomic, strong) ANListControllerConfigurationModel* configurationModel;

@end

@implementation ANTableControllerManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.cellItemsHandler = [ANListControllerItemsHandler handlerWithDelegate:self];
        self.updateProcessor = [ANListControllerQueueProcessor new];
        self.updateProcessor.delegate = self;
        self.updateProcessor.updateOperationClass = [ANTableControllerUpdateOperation class];
        
        self.configurationModel = [ANListControllerConfigurationModel defaultModel];
    }
    return self;
}

- (id<ANListControllerReusableInterface>)reusableViewsHandler
{
    return self.cellItemsHandler;
}

- (id<ANStorageUpdatingInterface>)updateHandler
{
    return self.updateProcessor;
}

- (UIView<ANListViewInterface>*)listView
{
    return (UIView<ANListViewInterface>*)[self.delegate tableView];
}

- (id<ANListControllerWrapperInterface>)listViewWrapper
{
    return [self.delegate listViewWrapper];
}

- (void)allUpdatesFinished
{
    [self.delegate allUpdatesAreFinished];
}


#pragma mark - UITableView Delegate Helpers

- (NSString*)titleForSupplementaryIndex:(NSUInteger)index type:(ANTableViewSupplementaryType)type
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

- (UIView*)supplementaryViewForIndex:(NSUInteger)index type:(ANTableViewSupplementaryType)type
{
    id model = [self supplementaryModelForIndex:index type:type];
    BOOL isHeader = (type == ANTableViewSupplementaryTypeHeader);
    NSString* kind = isHeader ? self.configurationModel.defaultHeaderSupplementary : self.configurationModel.defaultFooterSupplementary;
    
    return (UIView*)[self.cellItemsHandler supplementaryViewForModel:model kind:kind forIndexPath:nil];
}

- (id)supplementaryModelForIndex:(NSUInteger)index type:(ANTableViewSupplementaryType)type
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

- (CGFloat)heightForSupplementaryIndex:(NSUInteger)index type:(ANTableViewSupplementaryType)type
{
    //apple bug HACK: for plain tables, for bottom section separator visibility
    
    UITableView* tableView = [self.delegate tableView];
    
    BOOL shouldMaskSeparator = ((tableView.style == UITableViewStylePlain) &&
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
            return isHeader ? tableView.sectionHeaderHeight : tableView.sectionFooterHeight;
        }
    }
    else
    {
        return minHeight;
    }
}

- (UITableViewCell*)cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath
{
    return (UITableViewCell*)[self.cellItemsHandler cellForModel:model atIndexPath:indexPath];
}

@end
