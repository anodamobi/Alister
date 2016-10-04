//
//  ANTableView.m
//
//  Created by Oksana Kovalchuk on 4/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANTableView.h"

static CGFloat const kDefaultTableViewCellHeight = 44;
static CGFloat const kDefaultTableViewHeaderHeight = 40;

#define SYSTEM_VERSION          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IOS7_OR_HIGHER          (7.0 <= SYSTEM_VERSION)

#import "Masonry.h"
#import <FrameAccessor/FrameAccessor.h>

@interface ANTableView ()

@property (nonatomic, strong) UIView* stickedContainer;
@property (nonatomic, assign) CGFloat stickedFooterHeight;
@property (nonatomic, strong) UIView* bottomStickedFooterView;

@end

@implementation ANTableView

+ (instancetype)cleanTableWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    ANTableView* table = [[[self class] alloc] initWithFrame:frame style:style];
    [table setupAppearance];
    return table;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        self.delaysContentTouches = NO;
        if (IOS7_OR_HIGHER)
        {
            self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        }
    }
    return self;
}

- (void)addStickyFooter:(UIView*)footer withFixedHeight:(CGFloat)height
{
    self.stickedFooterHeight = height;
    self.bottomStickedFooterView = footer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutTableFooterView];
    
    CGRect frame = self.bottomStickedFooterView.frame;
    frame.size.height = self.stickedFooterHeight;
    frame.size.width = self.width;
    frame.origin.y = self.stickedContainer.height - frame.size.height;
    self.bottomStickedFooterView.frame = frame;
}

- (void)layoutTableFooterView
{
    if (self.bottomStickedFooterView && self.contentSize.height)
    {
        CGFloat contentSizeWithoutFooter = self.tableFooterView.frame.origin.y;
        CGFloat stickedFooterHeight = self.stickedFooterHeight;
        CGFloat frameHeight = self.frame.size.height;
        
        CGFloat minContentHeightWithFooter = contentSizeWithoutFooter + stickedFooterHeight;
        
        CGRect footerFrame = self.tableFooterView.frame;
        
        if (minContentHeightWithFooter <= frameHeight)
        {
            footerFrame.size.height = frameHeight - contentSizeWithoutFooter;
        }
        else
        {
            footerFrame.size.height = stickedFooterHeight;
        }
        self.tableFooterView.frame = footerFrame;
    }
}

- (void)setBottomStickedFooterView:(UIView*)bottomStickedFooterView
{
    _bottomStickedFooterView = bottomStickedFooterView;
    [self.stickedContainer addSubview:_bottomStickedFooterView];
}

- (UIView*)stickedContainer
{
    if (!_stickedContainer)
    {
        _stickedContainer = [UIView new];
        self.tableFooterView = self.stickedContainer;
    }
    return _stickedContainer;
}

- (void)setupAppearance
{
    self.rowHeight = kDefaultTableViewCellHeight;
    self.sectionHeaderHeight = kDefaultTableViewHeaderHeight;
    
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = nil;
    self.separatorColor = [UIColor colorWithRed:215/255 green:214/255 blue:218/255 alpha:1];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    // Because we set delaysContentTouches = NO, we return YES for UIButtons
    // so that scrolling works correctly when the scroll gesture
    // starts in the UIButtons.
    if ([view isKindOfClass:[UIButton class]])
    {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

@end
