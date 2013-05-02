//
//  CCSettingViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingViewControllerDelegate;

@interface SettingViewController : UIViewController
@property(weak, nonatomic) id<SettingViewControllerDelegate> delegate;
@end

@protocol SettingViewControllerDelegate <NSObject>
- (void)settingViewControllerDidFinish:(SettingViewController *)settingViewController;
- (void)settingViewControllerDidChangedCalendarSetting:(SettingViewController *)settingViewController;
@end