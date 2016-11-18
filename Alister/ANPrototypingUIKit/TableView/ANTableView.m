//
//  ANTableView.m
//
//  Created by Oksana Kovalchuk on 4/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANTableView.h"

static CGFloat const kDefaultTableViewCellHeight = 44;
static CGFloat const kDefaultTableViewHeaderHeight = 40;
static CGFloat const kDefaultNavigationBarHeight = 44;
static CGFloat const kDefaultStatusBarHeight = 20;


@interface ANTableView ()

@property (nonatomic, strong) UIView* stickedContainer;
@property (nonatomic, assign) CGFloat stickedFooterHeight;
@property (nonatomic, strong) UIView* bottomStickedFooterView;
@property (nonatomic, assign) BOOL additionalContentSizeAdded;

@end

@implementation ANTableView

+ (instancetype)tableViewDefaultStyleWithFrame:(CGRect)frame style:(UITableViewStyle)style
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
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
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
    frame.size.width = CGRectGetWidth(self.frame);
    frame.origin.y = CGRectGetHeight(self.stickedContainer.frame) - CGRectGetHeight(frame);
    self.bottomStickedFooterView.frame = frame;
}

- (void)layoutTableFooterView
{
    if (self.bottomStickedFooterView && self.contentSize.height > 0)
    {
        CGFloat contentSizeWithoutFooter = self.tableFooterView.frame.origin.y;
        CGFloat stickedFooterHeight = self.stickedFooterHeight;
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        
        CGFloat additionalHeight = 0;
        if (self.window.rootViewController && [self.window.rootViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController* navigationController = (UINavigationController*)self.window.rootViewController;
            
            BOOL isTopControllerModal = NO;
            if (navigationController.presentedViewController)
            {
                isTopControllerModal = [self _checkIfViewControllerIsModal:navigationController.presentedViewController];
            }
            
            BOOL isNavigationBarHidden = navigationController.navigationBarHidden;
            if (!isNavigationBarHidden && !isTopControllerModal)
            {
                additionalHeight += kDefaultNavigationBarHeight;
            }
        }
        
        if (![UIApplication sharedApplication].isStatusBarHidden)
        {
            additionalHeight += kDefaultStatusBarHeight;
        }
    
        frameHeight -= additionalHeight;
        
        CGFloat minContentHeightWithFooter = contentSizeWithoutFooter + stickedFooterHeight;
        
        CGRect footerFrame = self.tableFooterView.frame;
        
        if (minContentHeightWithFooter <= frameHeight)
        {
            footerFrame.size.height = frameHeight - contentSizeWithoutFooter;
        }
        else
        {
            footerFrame.size.height = stickedFooterHeight;
            if (!self.additionalContentSizeAdded)
            {
                CGSize currentSize = self.contentSize;
                currentSize.height += stickedFooterHeight;
                self.contentSize = currentSize;
                self.additionalContentSizeAdded = YES;
            }
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

- (BOOL)touchesShouldCancelInContentView:(UIView*)view
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


#pragma mark - Private

- (BOOL)_checkIfViewControllerIsModal:(UIViewController*)viewController
{
    BOOL isModal = NO;
    
    if ([viewController presentingViewController])
    {
        isModal = YES;
    }
    if ([[viewController presentingViewController] presentedViewController] == viewController)
    {
        isModal = YES;
    }
    if ([[[viewController navigationController] presentingViewController] presentedViewController] == [viewController navigationController])
    {
        isModal = YES;
    }
    if ([[[viewController tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]])
    {
        isModal = YES;
    }

    return isModal;
}

@end
