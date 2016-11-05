//
//  ANTestableCollectionView.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 8/24/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListViewInterface.h"

@interface ANTestableCollectionView : UICollectionView <ANListViewInterface>

- (void)updateWindow:(UIWindow*)window;

@end
