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
@property(weak, nonatomic) UIPopoverController *popover;
@end

@protocol SettingViewControllerDelegate <NSObject>
- (void)settingViewControllerDidFinish:(SettingViewController *)settingViewController
                 calendarOptionChanged:(BOOL)calendarOptionChanged;
@end