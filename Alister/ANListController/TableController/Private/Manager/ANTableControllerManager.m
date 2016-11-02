//
//  ANTableControllerManager.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 1/31/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANTableControllerManager.h"
#import <Alister/ANStorage.h>
#import <Alister/ANStorageSectionModel.h>
#import "ANListControllerQueueProcessor.h"
#import "ANListControllerItemsHandler.h"
#import "ANListControllerConfigurationModel.h"
#import "ANTableControllerUpdateOperation.h"
#import "ANListControllerMappingService.h"

@interface ANTableControllerManager () <ANListControllerItemsHandlerDelegate, ANListControllerQueueProcessorDelegate>

@property (nonatomic, strong) ANListControllerItemsHandler* cellItemsHandler;
@property (nonatomic, strong) ANListControllerQueueProcessor* updateProcessor;
@property (nonatomic, strong) ANListControllerConfigurationModel* configurationModel;

@end

@implementation ANTableControllerManager

//- (instancetype)init
//{
//    self = [super init];
//    if (self)
//    {
//        self.cellItemsHandler = [[ANListControllerItemsHandler alloc] initWithMappingService:[ANListControllerMappingService new]];
//        self.cellItemsHandler.delegate = self;
//        
//        self.updateProcessor = [ANListControllerQueueProcessor new];
//        self.updateProcessor.delegate = self;
//        self.updateProcessor.updateOperationClass = [ANTableControllerUpdateOperation class];
//        
//        self.configurationModel = [ANListControllerConfigurationModel defaultModel];
//    }
//    return self;
//}
//
//- (id<ANListControllerReusableInterface>)reusableViewsHandler
//{
//    return self.cellItemsHandler;
//}
//
//- (id<ANStorageUpdatingInterface>)updateHandler
//{
//    return self.updateProcessor;
//}
//
//- (UIView<ANListViewInterface>*)listView
//{
//    return (UIView<ANListViewInterface>*)[self.delegate tableView];
//}
//
//- (id<ANListControllerWrapperInterface>)listViewWrapper
//{
//    return [self.delegate listViewWrapper];
//}
//
//- (void)allUpdatesFinished
//{
//    [self.delegate allUpdatesWereFinished];
//}
//






#pragma mark - UITableView Delegate Helpers

//- (NSString*)titleForSupplementaryIndex:(NSUInteger)index kind:(NSString*)kind
//{
//    id model = [self supplementaryModelForIndex:index kind:kind];
//    if ([model isKindOfClass:[NSString class]])
//    {
//        UIView* view = [self supplementaryViewForIndex:index kind:kind];
//        if (!view)
//        {
//            return model;
//        }
//    }
//    return nil;
//}
//
//- (UIView*)supplementaryViewForIndex:(NSUInteger)index kind:(NSString*)kind
//{
//    id model = [self supplementaryModelForIndex:index kind:kind];
//    return (UIView*)[self.cellItemsHandler supplementaryViewForModel:model kind:kind forIndexPath:nil];
//}
//
//- (id)supplementaryModelForIndex:(NSUInteger)index kind:(NSString*)kind
//{
//    BOOL isHeader = [kind isEqualToString:[self.delegate.currentStorage headerSupplementaryKind]];
//    BOOL value = isHeader ?
//    self.configurationModel.shouldDisplayHeaderOnEmptySection :
//    self.configurationModel.shouldDisplayFooterOnEmptySection;
//    ANStorage* storage = self.delegate.currentStorage;
//    
//    if ((storage.sections.count && [[storage sectionAtIndex:index] numberOfObjects]) || value)
//    {
//        if (isHeader)
//        {
//            return [storage headerModelForSectionIndex:index];
//        }
//        else
//        {
//            return [storage footerModelForSectionIndex:index];
//        }
//    }
//    return nil;
//}
//
//- (CGFloat)heightForSupplementaryIndex:(NSUInteger)index kind:(NSString*)kind
//{
//    //apple bug HACK: for plain tables, for bottom section separator visibility
//    
//    UITableView* tableView = [self.delegate tableView];
//    
//    BOOL isHeader = [kind isEqualToString:[self.delegate.currentStorage headerSupplementaryKind]];
//    
//    BOOL shouldMaskSeparator = ((tableView.style == UITableViewStylePlain) && !isHeader);
//    
//    CGFloat minHeight = shouldMaskSeparator ? 0.1f : CGFLOAT_MIN;
//    id model = [self supplementaryModelForIndex:index kind:kind];
//    if (model)
//    {
//        BOOL isTitleStyle = ([self titleForSupplementaryIndex:index kind:kind] != nil);
//        if (isTitleStyle)
//        {
//            return UITableViewAutomaticDimension;
//        }
//        else
//        {
//            return isHeader ? tableView.sectionHeaderHeight : tableView.sectionFooterHeight;
//        }
//    }
//    else
//    {
//        return minHeight;
//    }
//}
//
//- (UITableViewCell*)cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath
//{
//    return (UITableViewCell*)[self.cellItemsHandler cellForModel:model atIndexPath:indexPath];
//}

@end
