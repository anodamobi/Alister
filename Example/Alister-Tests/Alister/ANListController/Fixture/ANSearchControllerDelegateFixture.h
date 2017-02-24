//
//  ANSearchControllerDelegateFixture.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerSearchManager.h"

@interface ANSearchControllerDelegateFixture : NSObject <ANListControllerSearchManagerDelegate>

@property (nonatomic, assign) NSInteger cancelCount;
@property (nonatomic, strong) ANStorage* storage; //TODO: fill with data

- (ANStorage*)lastGeneratedStorage;
- (NSArray*)allGeneratedStoragesArray;

@end
