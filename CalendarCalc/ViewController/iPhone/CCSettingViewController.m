//
//  CCSettingViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCSettingViewController.h"
#import "CCAppDelegate+Setting.h"

@interface CCSettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *includeStartDayOption;
@property (weak, nonatomic) IBOutlet UISwitch *dynamicCalendarOption;
- (IBAction)onDone:(UIBarButtonItem *)sender;
- (IBAction)onCancel:(UIBarButtonItem *)sender;
- (void)saveSettings;
@end

@implementation CCSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.includeStartDayOption.on = [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] includeStartDayOption];
    self.dynamicCalendarOption.on = [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] dynamicCalendarOption];
}

- (void)viewDidUnload {
    [self setIncludeStartDayOption:nil];
    [self setDynamicCalendarOption:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDone:(UIBarButtonItem *)sender {
    [self saveSettings];
    [self.delegate settingViewControllerDidFinish:self];
}

- (IBAction)onCancel:(UIBarButtonItem *)sender {
    [self.delegate settingViewControllerDidFinish:self];
}



#pragma mark - Private

- (void)saveSettings
{
    CCAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate setIncludeStartDayOption:self.includeStartDayOption.isOn];
    [delegate setDynamicCalendarOption:self.dynamicCalendarOption.isOn];
}


@end
