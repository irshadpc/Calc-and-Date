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

@interface SettingViewController ()<CalendarSelectViewControllerDelegate>
@property(weak, nonatomic) IBOutlet UINavigationItem *titlebar;
@property(weak, nonatomic) IBOutlet UISwitch *includeStartDayOption;
@property(weak, nonatomic) IBOutlet UISwitch *dynamicCalendarOption;
@property(strong, nonatomic) UIView *childView;

- (IBAction)onDone:(UIBarButtonItem *)sender;
- (IBAction)onCancel:(UIBarButtonItem *)sender;
- (IBAction)onIncludeStartDayOptionChanged:(UISwitch *)sender;
- (IBAction)onDynamicCalendarOptionChanged:(UISwitch *)sender;
- (IBAction)onCalendarSettings:(UIButton *)sender;
- (void)saveSettings;
@end

@implementation SettingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.includeStartDayOption.on = [(AppDelegate *)[[UIApplication sharedApplication] delegate] includeStartDayOption];
    self.dynamicCalendarOption.on = [(AppDelegate *)[[UIApplication sharedApplication] delegate] dynamicCalendarOption];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGRect dynaimcCalendarOptionFrame = self.dynamicCalendarOption.frame;
        self.contentSizeForViewInPopover = CGSizeMake(self.view.frame.size.width,
                                                      dynaimcCalendarOptionFrame.origin.y +
                                                      dynaimcCalendarOptionFrame.size.height + 20.0);
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
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] setIncludeStartDayOption:sender.isOn];
    }
}

- (IBAction)onDynamicCalendarOptionChanged:(UISwitch *)sender {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] setDynamicCalendarOption:sender.isOn];
    }
}

- (IBAction)onCalendarSettings:(UIButton *)sender
{
    CalendarSelectViewController *viewController = [[CalendarSelectViewController alloc]
                                                    initWithNibName:@"CalendarSelectViewController"
                                                    bundle:nil];
    [viewController setDelegate:self];
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}


#pragma mark - CalendarSelectViewController

- (void)calendarSelectViewControllerDidFinish:(CalendarSelectViewController *)calendarSelectViewController
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         [calendarSelectViewController.view setAlpha:0];
                     } 
                     completion:^(BOOL finished) {
                         [calendarSelectViewController willMoveToParentViewController:nil];
                         [calendarSelectViewController.view removeFromSuperview];
                         [calendarSelectViewController removeFromParentViewController];
                     }];
}


#pragma mark - Private

- (void)saveSettings
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate setIncludeStartDayOption:self.includeStartDayOption.isOn];
    [delegate setDynamicCalendarOption:self.dynamicCalendarOption.isOn];
}
@end
