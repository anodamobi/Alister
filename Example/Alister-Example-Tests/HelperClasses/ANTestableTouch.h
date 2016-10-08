//
//  ANTestableTouch.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/23/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ANTestableTouch : UITouch

+ (instancetype)touchWithView:(UIView*)view;

@end
