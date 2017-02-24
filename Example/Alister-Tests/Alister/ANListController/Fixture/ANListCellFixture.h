//
//  ANListCellFixture.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/14/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerUpdateViewInterface.h"

@interface ANListCellFixture : NSObject <ANListControllerUpdateViewInterface>

@property (nonatomic, assign) BOOL wasUpdateCalled;

@end
