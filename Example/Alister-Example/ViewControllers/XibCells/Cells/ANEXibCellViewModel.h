//
//  ANEXibCellViewModel.h
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@interface ANEXibCellViewModel : NSObject

+ (instancetype)viewModelWithUsername:(NSString*)username
                       andActiveState:(BOOL)isActive;

- (NSString*)username;
- (BOOL)activeState;

@end
