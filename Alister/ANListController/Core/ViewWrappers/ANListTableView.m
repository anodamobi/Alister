//
//  ANListControllerTableViewWrapper.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListTableView.h"
#import "ANStorageUpdateModel.h"
#import "ANTableUpdateConfigurationModel.h"
#import "ANConstants.h"

@interface ANListTableView ()

@property (nonatomic, weak) UITableView* tableView;

@end

@implementation ANListTableView

+ (instancetype)wrapperWithTableView:(UITableView*)tableView
{
    ANListTableView* wrapper = [self new];
    wrapper.tableView = tableView;
    return wrapper;
}

- (UIScrollView*)view
{
    return self.tableView;
}

- (NSString*)animationKey
{
    return @"UITableViewReloadDataAnimationKey";
}

- (CGFloat)reloadAnimationDuration
{
    return 0.25f;
}

- (void)setDelegate:(id)delegate
{
    self.tableView.delegate = delegate;
}

- (void)setDataSource:(id)dataSource
{
    self.tableView.dataSource = dataSource;
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)registerSupplementaryClass:(Class)supplementaryClass
                   reuseIdentifier:(NSString*)reuseIdentifier
                              kind:(NSString*)kind
{
    NSAssert(kind, @"You must specify supplementary kind");
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(supplementaryClass, @"You must specify supplementary class");
    
    NSParameterAssert([supplementaryClass isSubclassOfClass:[UITableViewHeaderFooterView class]]);
    //TODO: dispatch to main
    [self.tableView registerClass:supplementaryClass forHeaderFooterViewReuseIdentifier:reuseIdentifier];
}

- (void)registerSupplementaryNib:(UINib*)nib
                 reuseIdentifier:(NSString*)reuseIdentifier
                            kind:(NSString*)kind
{
    NSAssert(nib, @"You must specify nib");
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(kind, @"You must specify supplementary kind");
    
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:reuseIdentifier];
}

- (void)registerCellClass:(Class)cellClass forReuseIdentifier:(NSString*)identifier
{
    NSAssert(cellClass, @"You must specify cell class");
    NSAssert(identifier, @"You must specify reuse identifier");
    
    [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerCellWithNib:(UINib*)nib forReuseIdentifier:(NSString*)identifier
{
    NSAssert(nib, @"You must specify nib");
    NSAssert(identifier, @"You must specify reuse identifier");
    
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
}

- (id<ANListControllerUpdateViewInterface>)cellForReuseIdentifier:(NSString*)reuseIdentifier atIndexPath:(NSIndexPath*)indexPath
{
    NSParameterAssert(reuseIdentifier);
    NSParameterAssert(indexPath);
    return [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
}

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForReuseIdentifer:(NSString*)reuseIdentifier
                                                                         kind:(__unused NSString*)kind
                                                                  atIndexPath:(__unused NSIndexPath*)indexPath
{
    NSParameterAssert(reuseIdentifier);
    return [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
}

- (id)defaultCell
{
    return [UITableViewCell new];
}

- (id)defaultSupplementary
{
    return [UITableViewHeaderFooterView new];
}

- (NSString*)defaultFooterKind
{
    return ANListDefaultFooterKind;
}

- (NSString*)defaultHeaderKind
{
    return ANListDefaultHeaderKind;
}

- (void)performUpdate:(ANStorageUpdateModel*)update animated:(BOOL)animated
{
    UITableView* tableView = self.tableView;
    ANTableUpdateConfigurationModel* configurationModel = self.configModel;
    
    UITableViewRowAnimation insertSectionAnimation = UITableViewRowAnimationNone;
    UITableViewRowAnimation deleteSectionAnimation = UITableViewRowAnimationNone;
    UITableViewRowAnimation reloadSectionAnimation = UITableViewRowAnimationNone;
    UITableViewRowAnimation insertRowAnimation = UITableViewRowAnimationNone;
    UITableViewRowAnimation deleteRowAnimation = UITableViewRowAnimationNone;
    UITableViewRowAnimation reloadRowAnimation = UITableViewRowAnimationNone;
    
    if (animated)
    {
        insertSectionAnimation = configurationModel.insertSectionAnimation;
        deleteSectionAnimation = configurationModel.deleteSectionAnimation;
        reloadSectionAnimation = configurationModel.reloadSectionAnimation;
        insertRowAnimation = configurationModel.insertRowAnimation;
        deleteRowAnimation = configurationModel.deleteRowAnimation;
        reloadRowAnimation = configurationModel.reloadRowAnimation;
    }
    
    NSMutableIndexSet* updatedSectionIndexes = [NSMutableIndexSet indexSet];
    [updatedSectionIndexes addIndexes:update.updatedSectionIndexes];
    [updatedSectionIndexes removeIndexes:update.insertedSectionIndexes];
    [updatedSectionIndexes removeIndexes:update.deletedSectionIndexes];
    
    [tableView beginUpdates];
    
    [tableView insertSections:update.insertedSectionIndexes withRowAnimation:insertSectionAnimation];
    [tableView deleteSections:update.deletedSectionIndexes withRowAnimation:deleteSectionAnimation];
    [tableView reloadSections:updatedSectionIndexes withRowAnimation:reloadSectionAnimation];
    
    [update.movedRowsIndexPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        ANStorageMovedIndexPathModel* movedIndexPath = (ANStorageMovedIndexPathModel*)obj;
        if (![update.deletedSectionIndexes containsIndex:(NSUInteger)movedIndexPath.fromIndexPath.section])
        {
            if (movedIndexPath.fromIndexPath && movedIndexPath.toIndexPath)
            {
                [tableView moveRowAtIndexPath:movedIndexPath.fromIndexPath toIndexPath:movedIndexPath.toIndexPath];
            }
        }
    }];
    
    [tableView insertRowsAtIndexPaths:update.insertedRowIndexPaths.allObjects withRowAnimation:insertRowAnimation];
    [tableView deleteRowsAtIndexPaths:update.deletedRowIndexPaths.allObjects withRowAnimation:deleteRowAnimation];
    [tableView reloadRowsAtIndexPaths:update.updatedRowIndexPaths.allObjects withRowAnimation:reloadRowAnimation];
    
    [tableView endUpdates];
}

@end
