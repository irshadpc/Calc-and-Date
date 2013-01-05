//
//  CCAppDelegate.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCAppDelegate.h"
#import "CCCalendarCalcViewController.h"
#import "CCCalendarCalcViewController_iPhone.h"
#import "CCCalendarCalcViewController_iPad.h"
#import "CCUserDefaultsKeys.h"

@implementation CCAppDelegate

static const CGFloat Phone4InchHeight = 568.0;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableDictionary *userDefaults = [[NSMutableDictionary alloc] init];
    [userDefaults setValue:@"NO" forKey:kIncludeStartDay];
    [userDefaults setValue:@"YES" forKey:kDynamicCalendar];
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];

    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"key_click"
                                                          ofType:@"aif"];
    NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error: nil];
    [self.player setVolume:0.5];
    [self.player prepareToPlay];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([UIScreen mainScreen].bounds.size.height == Phone4InchHeight) {
            self.viewController = [[CCCalendarCalcViewController_iPhone alloc]
                                   initWithNibName:@"CCCalendarCalcViewController_iPhone_4inch" bundle:nil];
        } else {
            self.viewController = [[CCCalendarCalcViewController_iPhone alloc] 
                                   initWithNibName:@"CCCalendarCalcViewController_iPhone" bundle:nil];
        }
    } else {
        self.viewController = [[CCCalendarCalcViewController_iPad alloc]
                               initWithNibName:@"CCCalendarCalcViewController_iPad" bundle:nil];
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
