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
@property (weak, nonatomic) IBOutlet UINavigationItem *titlebar;
@property (weak, nonatomic) IBOutlet UISwitch *includeStartDayOption;
@property (weak, nonatomic) IBOutlet UISwitch *dynamicCalendarOption;
- (IBAction)onDone:(UIBarButtonItem *)sender;
- (IBAction)onCancel:(UIBarButtonItem *)sender;
- (IBAction)onIncludeStartDayOptionChanged:(UISwitch *)sender;
- (IBAction)onDynamicCalendarOptionChanged:(UISwitch *)sender;
- (void)saveSettings;
@end

@implementation CCSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.includeStartDayOption.on = [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] includeStartDayOption];
    self.dynamicCalendarOption.on = [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] dynamicCalendarOption];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGRect dynaimcCalendarOptionFrame = self.dynamicCalendarOption.frame;
        self.contentSizeForViewInPopover = CGSizeMake(self.view.frame.size.width,
                                                      dynaimcCalendarOptionFrame.origin.y +
                                                      dynaimcCalendarOptionFrame.size.height + 8.0);
        self.titlebar.leftBarButtonItem = nil;
        self.titlebar.rightBarButtonItem = nil;
    }
}

- (void)viewDidUnload {
    [self setIncludeStartDayOption:nil];
    [self setDynamicCalendarOption:nil];
    [self setTitlebar:nil];
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

- (IBAction)onIncludeStartDayOptionChanged:(UISwitch *)sender {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] setIncludeStartDayOption:sender.isOn];
    }
}

- (IBAction)onDynamicCalendarOptionChanged:(UISwitch *)sender {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] setDynamicCalendarOption:sender.isOn];
    }
}



#pragma mark - Private

- (void)saveSettings
{
    CCAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate setIncludeStartDayOption:self.includeStartDayOption.isOn];
    [delegate setDynamicCalendarOption:self.dynamicCalendarOption.isOn];
}


@end
