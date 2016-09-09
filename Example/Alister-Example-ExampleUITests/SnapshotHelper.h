

@import Foundation;
@import XCTest;

@interface SnapshotHelper : NSObject

- (instancetype)initWithApp:(XCUIApplication*)app;

- (void)snapshot:(NSString*)name waitForLoadingIndicator:(BOOL)wait;

@end
