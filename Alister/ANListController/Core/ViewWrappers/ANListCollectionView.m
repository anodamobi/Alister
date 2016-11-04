//
//  ANListControllerCollectionViewWrapper.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListCollectionView.h"
#import "ANStorageUpdateModel.h"

@interface ANListCollectionView ()

@property (nonatomic, weak) UICollectionView* collectionView;

@end

@implementation ANListCollectionView

+ (instancetype)wrapperWithCollectionView:(UICollectionView *)collectionView
{
    ANListCollectionView* wrapper = [self new];
    wrapper.collectionView = collectionView;
    return wrapper;
}

- (UIScrollView*)view
{
    return self.collectionView;
}

- (NSString*)headerDefaultKind
{
    return UICollectionElementKindSectionHeader;
}

- (NSString*)footerDefaultKind
{
    return UICollectionElementKindSectionFooter;
}

- (CGFloat)reloadAnimationDuration
{
    return 0.25;
}

- (void)setDelegate:(id)delegate
{
    self.collectionView.delegate = delegate;
}

- (void)setDataSource:(id)dataSource
{
    self.collectionView.dataSource = dataSource;
}

- (NSString*)animationKey
{
    return @"UICollectionViewReloadDataAnimationKey";
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

- (void)registerSupplementaryClass:(Class)supplementaryClass
                   reuseIdentifier:(NSString*)reuseIdentifier
                              kind:(NSString*)kind
{
    NSAssert(kind, @"You must specify supplementary kind");
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(supplementaryClass, @"You must specify supplementary class");
    
    NSParameterAssert([supplementaryClass isSubclassOfClass:[UICollectionReusableView class]]);
    
    [self.collectionView registerClass:supplementaryClass
            forSupplementaryViewOfKind:kind
                   withReuseIdentifier:reuseIdentifier];
}

- (void)registerCellClass:(Class)cellClass forReuseIdentifier:(NSString*)identifier
{
    NSAssert(cellClass, @"You must specify cell class");
    NSAssert(identifier, @"You must specify reuse identifier");
    
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (id<ANListControllerUpdateViewInterface>)cellForReuseIdentifier:(NSString*)reuseIdentifier atIndexPath:(NSIndexPath*)indexPath
{
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(indexPath, @"You must specify reuse indexPath");
    
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForReuseIdentifer:(NSString*)reuseIdentifier
                                                                         kind:(NSString*)kind
                                                                  atIndexPath:(NSIndexPath*)indexPath
{
    NSAssert(kind, @"You must specify kind");
    NSAssert(reuseIdentifier, @"You must specify reuse identifier");
    NSAssert(indexPath, @"You must specify reuse indexPath");
    
    return [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                   withReuseIdentifier:reuseIdentifier
                                                          forIndexPath:indexPath];
}

- (void)performUpdate:(ANStorageUpdateModel*)update
{
    UICollectionView* collectionView = self.collectionView;

    NSMutableIndexSet*  sectionsToInsert = [NSMutableIndexSet indexSet];

    [update.insertedSectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, __unused BOOL* stop) {
        if ((NSUInteger)[collectionView numberOfSections] <= idx)
        {
            [sectionsToInsert addIndex:idx];
        }
    }];

    NSUInteger sectionChanges = [update.deletedSectionIndexes count] +
            [update.insertedSectionIndexes count] +
            [update.updatedSectionIndexes count];

    NSUInteger itemChanges = [update.deletedRowIndexPaths count] +
            [update.insertedRowIndexPaths count] +
            [update.updatedRowIndexPaths count];

    if (sectionChanges)
    {
        [collectionView performBatchUpdates:^{
            [collectionView deleteSections:update.deletedSectionIndexes];
            [collectionView insertSections:sectionsToInsert];
            [collectionView reloadSections:update.updatedSectionIndexes];
        } completion:nil];
    }

    if ([self _shouldReloadCollectionView:collectionView
   toPreventInsertFirstItemIssueForUpdate:update])
    {
        [collectionView reloadData];
        return;
    }

    if ((itemChanges && (sectionChanges == 0)))
    {
        [collectionView performBatchUpdates:^{
            [collectionView deleteItemsAtIndexPaths:update.deletedRowIndexPaths];
            [collectionView insertItemsAtIndexPaths:update.insertedRowIndexPaths];
            [collectionView reloadItemsAtIndexPaths:update.updatedRowIndexPaths];
        } completion:nil];
    }
}

#pragma mark - workarounds

// This is to prevent a bug in UICollectionView from occurring.
// The bug presents itself when inserting the first object or deleting the last object in a collection view.
// http://stackoverflow.com/questions/12611292/uicollectionview-assertion-failure
// http://stackoverflow.com/questions/13904049/assertion-failure-in-uicollectionviewdata-indexpathforitematglobalindex
// This code should be removed once the bug has been fixed, it is tracked in OpenRadar
// http://openradar.appspot.com/12954582
- (BOOL)_shouldReloadCollectionView:(UICollectionView*)collectionView toPreventInsertFirstItemIssueForUpdate:(ANStorageUpdateModel*)update
{
    BOOL shouldReload = NO;

    for (NSIndexPath* indexPath in update.insertedRowIndexPaths)
    {
        if ([collectionView numberOfItemsInSection:indexPath.section] == 0)
        {
            shouldReload = YES;
        }
    }

    for (NSIndexPath* indexPath in update.deletedRowIndexPaths)
    {
        if ([collectionView numberOfItemsInSection:indexPath.section] == 1)
        {
            shouldReload = YES;
        }
    }

    if (collectionView.window == nil)
    {
        shouldReload = YES;
    }
    return shouldReload;
}

@end
