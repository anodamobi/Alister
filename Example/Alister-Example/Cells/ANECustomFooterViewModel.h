//
//  ANECustomFooterViewModel.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@interface ANECustomFooterViewModel : NSObject

+ (instancetype)viewModelWithAttrString:(NSAttributedString*)attrString;

- (NSAttributedString*)attributedString;

@end
