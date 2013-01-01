//
//  CCAppDelegate.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCAppDelegate.h"
#import "CCViewController_iPhone.h"
#import "CCCalendarCalcViewController.h"
#import "CCSettingViewController.h"
#import "CCUserDefaultsKeys.h"

@implementation CCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableDictionary *userDefaults = [[NSMutableDictionary alloc] init];
    [userDefaults setValue:@"NO" forKey:kIncludeStartDay];
    [userDefaults setValue:@"YES" forKey:kDynamicCalendar];
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[CCViewController_iPhone alloc] initWithNibName:@"CCViewController_iPhone" bundle:nil];
        self.viewController.frontViewController = [[CCCalendarCalcViewController alloc] initWithNibName:@"CCCalendarCalcViewController_iPhone" bundle:nil];
        self.viewController.backViewController = [[CCSettingViewController alloc] initWithNibName:@"CCSettingViewController" bundle:nil];
    } else {
        //self.viewController = [[CCCalendarCalcViewController alloc] initWithNibName:@"CCViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
