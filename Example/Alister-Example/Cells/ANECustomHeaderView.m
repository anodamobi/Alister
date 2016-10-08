//
//  ANECustomHeaderView.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomHeaderView.h"
#import <Masonry/Masonry.h>

@interface ANECustomHeaderView ()

@property (nonatomic, strong) UISegmentedControl* segmentControl;

@end

@implementation ANECustomHeaderView

- (void)updateWithModel:(ANECustomHeaderViewModel*)model
{
    if (!self.segmentControl.numberOfSegments)
    {
        [model.segmentTitles enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, __unused BOOL* _Nonnull stop) {
            [self.segmentControl insertSegmentWithTitle:obj atIndex:idx animated:NO];
        }];
    }
}

- (UISegmentedControl*)segmentControl
{
    if (!_segmentControl)
    {
        _segmentControl = [UISegmentedControl new];
        [self.contentView addSubview:_segmentControl];
        
        [_segmentControl mas_makeConstraints:^(MASConstraintMaker* make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    
    return _segmentControl;
}

@end
