//
//  XCTestCase+Springboard.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 9/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (Springboard)

- (void)updateAppName:(NSString*)appName;

- (void)deleteApp;

@end











































//DO not touch!

@class NSArray, NSDictionary, NSString, XCAccessibilityElement, XCApplicationQuery, XCUIApplicationImpl;

@interface XCUIApplication ()
{
    BOOL _accessibilityActive;
    BOOL _ancillary;
    BOOL _eventLoopIsIdle;
    int _processID;
    unsigned long long _state;
    XCUIElement *_keyboard;
    NSArray *_launchArguments;
    NSDictionary *_launchEnvironment;
    XCUIApplicationImpl *_applicationImpl;
    XCApplicationQuery *_applicationQuery;
    unsigned long long _generation;
}
@property unsigned long long generation; // @synthesize generation=_generation;
@property BOOL eventLoopIsIdle; // @synthesize eventLoopIsIdle=_eventLoopIsIdle;
@property(retain) XCApplicationQuery *applicationQuery; // @synthesize applicationQuery=_applicationQuery;
@property(retain) XCUIApplicationImpl *applicationImpl; // @synthesize applicationQuery=_applicationQuery;
@property(readonly, copy) NSString *bundleID; // @synthesize bundleID=_bundleID;
@property(readonly, copy) NSString *path; // @synthesize path=_path;
@property BOOL ancillary; // @synthesize ancillary=_ancillary;
@property(nonatomic) BOOL accessibilityActive; // @synthesize accessibilityActive=_accessibilityActive;
@property(readonly) XCUIElement *keyboard; // @synthesize keyboard=_keyboard;
@property(readonly, nonatomic) UIInterfaceOrientation interfaceOrientation; //TODO tvos
@property(readonly, nonatomic) BOOL running;
@property(nonatomic) pid_t processID; // @synthesize processID=_processID;
@property unsigned long long state; // @synthesize state=_state;
@property(readonly) XCAccessibilityElement *accessibilityElement;

+ (id)keyPathsForValuesAffectingRunning;
+ (instancetype)appWithPID:(pid_t)processID;

- (void)dismissKeyboard;
- (void)_waitForViewControllerViewDidDisappearWithTimeout:(double)arg1;
- (void)_waitForQuiescence;
- (void)terminate;
- (void)_launchUsingXcode:(BOOL)arg1;
- (void)launch;
- (id)application;
- (id)description;
- (id)lastSnapshot;
- (id)query;
- (void)clearQuery;
- (XCUIElementType)elementType;
- (id)initPrivateWithPath:(id)arg1 bundleID:(id)arg2;
- (id)init;

@end


#import <XCTest/XCUIElement.h>
#import <TargetConditionals.h>

@class NSString, XCElementSnapshot, XCUIApplication, XCUIElementQuery;

@interface XCUIElement ()
{
    BOOL _safeQueryResolutionEnabled;
    XCUIElementQuery *_query;
    XCElementSnapshot *_lastSnapshot;
}

@property BOOL safeQueryResolutionEnabled; // @synthesize safeQueryResolutionEnabled=_safeQueryResolutionEnabled;
@property(retain) XCElementSnapshot *lastSnapshot; // @synthesize lastSnapshot=_lastSnapshot;
@property(readonly) XCUIElementQuery *query; // @synthesize query=_query;
@property(readonly, nonatomic) UIInterfaceOrientation interfaceOrientation;
@property(readonly) BOOL hasKeyboardFocus;
@property(readonly, nonatomic) XCUIApplication *application;

- (id)initWithElementQuery:(id)arg1;

- (unsigned long long)traits;
- (void)resolveHandleUIInterruption:(BOOL)arg1;
- (void)resolve;

#if !TARGET_OS_TV
- (id)hitPointCoordinate;
#endif

@end

