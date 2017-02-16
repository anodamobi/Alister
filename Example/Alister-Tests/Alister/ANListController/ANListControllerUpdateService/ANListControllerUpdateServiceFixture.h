//
//  ANListControllerUpdateServiceFixture.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/16/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerUpdateService.h"
#import "NSOperationQueueFixture.h"

@interface ANListControllerUpdateServiceFixture : ANListControllerUpdateService

@property (nonatomic, strong) NSOperationQueueFixture* queue;

@end
