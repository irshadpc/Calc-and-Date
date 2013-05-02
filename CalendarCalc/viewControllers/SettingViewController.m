//
//  CCSettingViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "SettingViewController.h"
#import "CalendarSelectViewController.h"
#import "ViewSheet.h"
#import "AppDelegate+Setting.h"

@interface SettingViewController ()
@property(weak, nonatomic) IBOutlet UISwitch *includeStartDayOption;
@property(weak, nonatomic) IBOutlet UISwitch *dynamicCalendarOption;
@property(strong, nonatomic) CalendarSelectViewController *calendarSelectViewController;

- (void)onDone:(UIBarButtonItem *)sender;
- (void)onCancel:(UIBarButtonItem *)sender;
- (IBAction)onCalendarSettings:(UIButton *)sender;
- (void)saveSettings;
@end

@implementation SettingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.includeStartDayOption.on = [appDelegate includeStartDayOption];
    self.dynamicCalendarOption.on = [appDelegate dynamicCalendarOption];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGRect dynaimcCalendarOptionFrame = self.dynamicCalendarOption.frame;
        self.contentSizeForViewInPopover = CGSizeMake(self.view.frame.size.width,
                                                      dynaimcCalendarOptionFrame.origin.y +
                                                      dynaimcCalendarOptionFrame.size.height + 20.0);
    } else {
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                target:self
                                                                                                action:@selector(onCancel:)]];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                                 target:self
                                                                                                 action:@selector(onDone:)]];
    }

    self.calendarSelectViewController = [[CalendarSelectViewController alloc] initWithNibName:@"CalendarSelectViewController"
                                                                                       bundle:nil];
    [self.calendarSelectViewController setDisabledCalendars:[appDelegate disabledCalendars]];
}

- (void)viewDidUnload {
    [self setIncludeStartDayOption:nil];
    [self setDynamicCalendarOption:nil];
    [super viewDidUnload];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self saveSettings];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onDone:(UIBarButtonItem *)sender {
    [self saveSettings];
    [self.delegate settingViewControllerDidFinish:self];
}

- (void)onCancel:(UIBarButtonItem *)sender {
    [self.delegate settingViewControllerDidFinish:self];
}

- (IBAction)onCalendarSettings:(UIButton *)sender
{
    [self.navigationController pushViewController:self.calendarSelectViewController
                                         animated:YES];
}


#pragma mark - Private

- (void)saveSettings
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate setIncludeStartDayOption:self.includeStartDayOption.isOn];
    [appDelegate setDynamicCalendarOption:self.dynamicCalendarOption.isOn];
    if ([self.calendarSelectViewController isChanged]) {
        [appDelegate setDisabledCalendars:[self.calendarSelectViewController disabledCalendars]];
        [self.delegate settingViewControllerDidChangedCalendarSetting:self];
    }
}
@end
