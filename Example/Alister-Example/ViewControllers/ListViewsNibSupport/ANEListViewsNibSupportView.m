//
//  ANEListViewsNibSupportView.m
//  Alister-Example
//
//  Created by ANODA on 2/16/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

#import "ANEListViewsNibSupportView.h"
#import "ANEListViewsNibSupportConstants.h"
#import "Masonry.h"

@implementation ANEListViewsNibSupportView


#pragma mark - Lazy Load

- (ANTableView*)tableView
{
    if (!_tableView)
    {
        _tableView = [ANTableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.top.right.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(kANEListViewNibSupportCenterOffset);
        }];
    }
    
    return _tableView;
}

- (UICollectionView*)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[self _collectionLayout]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.bottom.right.left.equalTo(self);
            make.top.equalTo(self.mas_centerY).offset(-kANEListViewNibSupportCenterOffset);
        }];
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout*)_collectionLayout
{
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat cellWidth =  screenWidth / 4;
    
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(screenWidth, 110.f);
    layout.footerReferenceSize = CGSizeMake(screenWidth, 50.f);
    layout.sectionInset = UIEdgeInsetsZero;
    layout.itemSize = CGSizeMake(cellWidth, cellWidth);
    
    return layout;
}

@end
