//
//  ANEActivityCollectionCell.m
//  Alister-Example
//
//  Created by ANODA on 2/16/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

#import "ANEActivityCollectionCell.h"

@interface ANEActivityCollectionCell ()

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@end

@implementation ANEActivityCollectionCell

- (void)updateWithModel:(id)model
{
    self.titleLabel.text = model;
}

@end
