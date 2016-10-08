



#import "SnapshotHelper.h"

@implementation SnapshotHelper
{
    XCUIApplication* _app;
    NSString* _deviceLanguage;
    NSString* _locale;
}

- (instancetype)initWithApp:(XCUIApplication *)app
{
    if ((self = [super init]))
    {
        _app = app;
        [self setLanguage];
        [self setLocale];
        [self setLaunchArguments];
    }
    return self;
}

- (void)snapshot:(NSString *)name waitForLoadingIndicator:(BOOL)wait
{
    if (wait)
    {
        [self waitForLoadingIndicatorToDisappear];
    }

    printf("snapshot: %s\n", name.UTF8String);
    sleep(1);
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationUnknown;
}

- (void)waitForLoadingIndicatorToDisappear {
    XCUIElementQuery* query = [[[_app.statusBars childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther];

    while (query.count > 4) {
        sleep(1);
        NSLog(@"Number of Elements in Status Bar: %ld... waiting for status bar to disappear", query.count);
    }
}

- (void)setLanguage {
    NSString* prefix = [self pathPrefix];
    if (prefix == nil) {
        return;
    }
    NSString* path = [prefix stringByAppendingPathComponent:@"language.txt"];

    NSError* error;
    _deviceLanguage = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%s could not detect language %@", __PRETTY_FUNCTION__, error);
        return;
    }
    _deviceLanguage = [_deviceLanguage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _app.launchArguments = [_app.launchArguments arrayByAddingObjectsFromArray:@[@"-AppleLanguages",[NSString stringWithFormat:@"(%@)", _deviceLanguage]]];
}

- (void)setLocale {
    NSString* prefix = [self pathPrefix];
    if (prefix == nil) {
        return;
    }
    NSString* path = [prefix stringByAppendingPathComponent:@"locale.txt"];

    NSError* error;
    _locale = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%s could not detect locale %@", __PRETTY_FUNCTION__, error);
        return;
    }
    _locale = [_locale stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (_locale.length == 0) {
        _locale = [NSLocale localeWithLocaleIdentifier:_deviceLanguage].localeIdentifier;
    }

    _app.launchArguments = [_app.launchArguments arrayByAddingObjectsFromArray:@[@"-AppleLocale", [NSString stringWithFormat:@"\"%@\"", _locale]]];
}

- (void)setLaunchArguments {
    NSString* prefix = [self pathPrefix];
    if (prefix == nil) {
        return;
    }
    NSString* path = [prefix stringByAppendingPathComponent:@"snapshot-launch_arguments.txt"];

    _app.launchArguments = [_app.launchArguments arrayByAddingObjectsFromArray:@[@"-FASTLANE_SNAPSHOT", @"YES", @"-ui_testing"]];

    NSError* error;
    NSString* argsString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%s could not detect launch arguments: %@", __PRETTY_FUNCTION__, error);
        return;
    }

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(\\\".+?\\\"|\\S+)" options:0 error:&error];
    if (error) {
        NSLog(@"%s could not detect launch arguments: %@", __PRETTY_FUNCTION__, error);
        return;
    }

    NSArray<NSTextCheckingResult*>* matches = [regex matchesInString:argsString options:0 range:NSMakeRange(0, argsString.length)];
    NSMutableArray<NSString*>* results = [NSMutableArray array];
    for (NSTextCheckingResult* match in matches) {
        [results addObject:[argsString substringWithRange:match.range]];
    }
    if (results.count > 0) {
        _app.launchArguments = [_app.launchArguments arrayByAddingObjectsFromArray:results];
    }
}

- (NSString*)pathPrefix {
    NSString* path = [[[NSProcessInfo processInfo] environment] objectForKey:@"SIMULATOR_HOST_HOME"];
    if (path == nil) {
        NSLog(@"Couldn't find Snapshot configuration files at ~/Library/Caches/tools.fastlane");
        return nil;
    }
    return [path stringByAppendingPathComponent:@"Library/Caches/tools.fastlane"];
}

@end
