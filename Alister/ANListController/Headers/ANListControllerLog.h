//
//  ANListControllerLog.h
//  Pods
//
//  Created by ANODA on 10/20/16.
//
//

#ifdef ANListControllerLog
#define ANListControllerLog(s, ...) NSLog(s, ##__VA_ARGS__)
#else
#define ANListControllerLog(s, ...)
#endif
