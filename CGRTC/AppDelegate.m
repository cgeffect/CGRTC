//
//  AppDelegate.m
//  CGRTC
//
//  Created by UFOTO on 2021/5/26.
//

#import "AppDelegate.h"
#import "CGRTCController.h"
#import <WebRTC/RTCFieldTrials.h>
#import <WebRTC/RTCLogging.h>
#import <WebRTC/RTCSSLAdapter.h>
#import <WebRTC/RTCTracing.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSDictionary *fieldTrials = @{};
    RTCInitFieldTrialDictionary(fieldTrials);
    RTCInitializeSSL();
    RTCSetupInternalTracer();
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController *viewController = [[CGRTCController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    RTCSetMinDebugLogLevel(RTCLoggingSeverityWarning);

    return YES;
}


@end
