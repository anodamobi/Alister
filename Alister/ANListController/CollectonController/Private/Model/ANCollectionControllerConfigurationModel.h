//
//  ANCollectionControllerConfigurationModel.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@interface ANCollectionControllerConfigurationModel : NSObject

@property (nonatomic, assign) BOOL isHandlingKeyboard;

+ (instancetype)defaultModel;

@end
