//
//  ANStorageLog.h
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#ifdef ANStorageLog
#define ANStorageLog(s, ...) NSLog(s, ##__VA_ARGS__)
#else
#define ANStorageLog(s, ...)
#endif
