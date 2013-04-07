//
//  CCCalendarCalcViewController_iPad.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/03.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController_iPad.h"
#import "CalendarCalcViewController_iPad+Orientation.h"
#import "DatePickerController.h"

@interface CalendarCalcViewController_iPad ()<EventViewControllerDelegate> 
@property(nonatomic, getter=isEventPopoverVisible) BOOL eventPopoverVisible;
@property(nonatomic, getter=isDateSelectPopoverVisible) BOOL dateSelectPopoverVisible;

- (IBAction)onEvent:(UIButton *)sender;
- (CGRect)dateSelectButtonFrame;
- (CGRect)prevButtonFrame;
- (CGRect)nextButtonFrame;
@end

@implementation CalendarCalcViewController_iPad
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.calendarViewContainer addSubview:self.calendarViewController.view];

    [self.calendarViewController.dateSelectButton setFrame:[self dateSelectButtonFrame]];
    [self.dateSelectButtonContainer addSubview:self.calendarViewController.dateSelectButton];
   
    [self.calendarViewController.prevButton setFrame:[self prevButtonFrame]];
    [self.prevButtonContainer addSubview:self.calendarViewController.prevButton];

    [self.calendarViewController.nextButton setFrame:[self nextButtonFrame]];
    [self.nextButtonContainer addSubview:self.calendarViewController.nextButton];

    [self setupLayoutWithOrientation:self.interfaceOrientation];
}

- (void)viewDidUnload {
    [self setCalendarViewContainer:nil];
    [self setDateSelectButtonContainer:nil];
    [self setPrevButtonContainer:nil];
    [self setNextButtonContainer:nil];
    [self setEventButton:nil];
    [self setCalcViewContainer:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration
{
    if ([self.currentPopover isPopoverVisible]) {
        self.eventPopoverVisible = YES;
        [self.currentPopover dismissPopoverAnimated:YES];
    }
   
    if ([self.calendarViewController isPopoverVisible]) {
        self.dateSelectPopoverVisible = YES;
        [self.calendarViewController dismissPopoverAnimated:YES];
    }

    [UIView animateWithDuration:0.25 animations:^{
        [self setupLayoutWithOrientation:toInterfaceOrientation];
    }];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (self.isEventPopoverVisible) {
        [self.currentPopover presentPopoverFromRect:self.eventButton.frame
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionAny
                                           animated:YES];
        self.eventPopoverVisible = NO;
    }
   
    if (self.isDateSelectPopoverVisible) {
        [self.calendarViewController presentPopoverAnimated:YES];
        self.dateSelectPopoverVisible = NO;
    }
}


#pragma mark - Action

- (IBAction)onEvent:(UIButton *)sender {
    [self showEventView:sender];
}


#pragma mark - Private

- (CGRect)dateSelectButtonFrame
{
    return CGRectMake(0,
                      0,
                      self.dateSelectButtonContainer.bounds.size.width,
                      self.dateSelectButtonContainer.bounds.size.height);
}

- (CGRect)prevButtonFrame
{
    return CGRectMake(0,
                      0,
                      self.prevButtonContainer.bounds.size.width,
                      self.prevButtonContainer.bounds.size.height);
}

- (CGRect)nextButtonFrame
{
    return CGRectMake(0,
                      0,
                      self.nextButtonContainer.bounds.size.width,
                      self.nextButtonContainer.bounds.size.height);
}
@end