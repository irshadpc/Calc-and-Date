//
//  CCSettingViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCSettingViewControllerDelegate;

@interface CCSettingViewController : UIViewController
@property (weak, nonatomic) id <CCSettingViewControllerDelegate> delegate;
@end

@protocol CCSettingViewControllerDelegate <NSObject>
- (void)settingViewControllerDidFinish:(CCSettingViewController *)viewController;
@end