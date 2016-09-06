//
//  ANTestableCollectionView.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestableCollectionView.h"

@interface ANTestableCollectionView ()

@property (nonatomic, strong) UIWindow* currentWindow;

@end

@implementation ANTestableCollectionView

- (void)reloadData
{

}

- (void)updateWindow:(UIWindow*)window
{
    self.currentWindow = window;
}

- (UIWindow *)window
{
    return self.currentWindow;
}

@end
