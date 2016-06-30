//
//  ANViewController.m
//  Alister
//
//  Created by Oksana Kovalchuk on 06/30/2016.
//  Copyright (c) 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANViewController.h"
#import "ANStorage.h"
#import "ANTableController.h"

@interface ANViewController ()

@end

@implementation ANViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    for (NSUInteger i = 0; i < 10; i++)
    {
        UITableView* table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        ANStorage* storage = [ANStorage new];
        ANTableController* tc = [ANTableController controllerWithTableView:table];
        [tc attachStorage:storage];
    }
}

@end
