//
//  AppDelegate.m
//  AppsFlyerObj
//
//  Created by LuyenBG on 2/10/18.
//  Copyright © 2018 LuyenBG. All rights reserved.
//

#import "AppDelegate.h"
#import <AppsFlyerLib/AppsFlyerTracker.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AppsFlyerTracker sharedTracker].appsFlyerDevKey = @"uCX9meXuM7aCsh3Zb4Q9KD";
    [AppsFlyerTracker sharedTracker].appleAppID = @"123456789";
    [AppsFlyerTracker sharedTracker].delegate = self;
    [AppsFlyerTracker sharedTracker].isDebug = true;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[AppsFlyerTracker sharedTracker] trackAppLaunch];
    //Tracking In-App Events
    [[AppsFlyerTracker sharedTracker] trackEvent: AFEventLevelAchieved withValues:@{AFEventParamLevel: @9,
                                                                                    AFEventParamScore:@100,
                                                                                    //Revenue In-App Event
                                                                                    AFEventParamContentId:@"1234567",
                                                                                    AFEventParamContentType:@"category_a",
                                                                                    AFEventParamRevenue:@1.99,
                                                                                    AFEventParamCurrency:@"USD"
                                                                                    }];
    //Get AppsFlyer Device ID
    NSString *appsflyer = [AppsFlyerTracker sharedTracker].appleAppID;
    //Set Customer User ID
    [AppsFlyerTracker sharedTracker].customerUserID = @"my user ID";
    //Set User Email
    [[AppsFlyerTracker sharedTracker] setUserEmails:@[@"email1@domain.com", @"email2@domain.com"] withCryptType:EmailCryptTypeSHA1];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//Tracking Deep Linking
-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    [[AppsFlyerTracker sharedTracker] continueUserActivity:userActivity restorationHandler:restorationHandler];
    return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[AppsFlyerTracker sharedTracker] handleOpenURL:url sourceApplication:sourceApplication withAnnotation:annotation];
    return YES;
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [[AppsFlyerTracker sharedTracker] handleOpenUrl:url options:options];
    return YES;
}
//Tracking Push Notifications
-(void) application:(UIApplication*) application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {
    [[AppsFlyerTracker sharedTracker] handlePushNotification:userInfo];
}

@end
