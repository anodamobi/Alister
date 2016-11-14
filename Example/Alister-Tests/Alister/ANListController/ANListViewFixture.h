//
//  ANListViewFixture.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListViewInterface.h"

@interface ANListViewFixture : NSObject <ANListViewInterface>

@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id delegate;

@property (nonatomic, strong) NSString* headerDefaultKind;
@property (nonatomic, strong) NSString* footerDefaultKind;
@property (nonatomic, strong) NSString* animationKey;

@property (nonatomic, strong) Class lastCellClass;
@property (nonatomic, strong) Class lastModelClass;
@property (nonatomic, strong) NSString* lastKind;
@property (nonatomic, strong) NSString* lastIdentifier;

@property (nonatomic, strong) NSIndexPath* lastIndexPath;

@property (nonatomic, strong) id cell;
@property (nonatomic, strong) id supplementary;

@property (nonatomic, assign) BOOL wasRegisterCalled;
@property (nonatomic, assign) BOOL wasRetriveCalled;

@end
