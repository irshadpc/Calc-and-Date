//
//  CCAppDelegate.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "AppDelegate.h"
#import "CalendarCalcViewController_iPhone.h"
#import "CalendarCalcViewController_iPad.h"
#import "UserDefaultsKeys.h"

@interface NSString (NibName)
+ (NSString *)calendarCalcViewController;
@end
@implementation NSString (NibName)
+ (NSString *)calendarCalcViewController
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return @"CalendarCalcViewController_iPad";
    }
    
    if ([UIScreen mainScreen].bounds.size.height == 568.0) {
        return @"CalendarCalcViewController_iPhone_4inch";
    } else {
        return @"CalendarCalcViewController_iPhone";
    }
}
@end


@implementation AppDelegate

static const CGFloat Phone4InchHeight = 568.0;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableDictionary *userDefaults = [[NSMutableDictionary alloc] init];
    [userDefaults setValue:@"NO" forKey:IncludeStartDay];
    [userDefaults setValue:@"YES" forKey:DynamicCalendar];
    [userDefaults setValue:@"YES" forKey:EventColor];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"key_click"
                                                          ofType:@"aif"];
    NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error: nil];
    [self.player setVolume:0.5];
    [self.player prepareToPlay];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.viewController = [[CalendarCalcViewController_iPhone alloc] initWithNibName:[NSString calendarCalcViewController]
                                                                                  bundle:nil];
    } else {
        self.viewController = [[CalendarCalcViewController_iPad alloc] initWithNibName:[NSString calendarCalcViewController]
                                                                                bundle:nil];
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
