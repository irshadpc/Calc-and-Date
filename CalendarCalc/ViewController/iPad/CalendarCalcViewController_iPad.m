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
@property(weak, nonatomic) IBOutlet UIButton *eventButton;
@property(weak, nonatomic) IBOutlet UIView *calendarViewContainer;
@property(weak, nonatomic) IBOutlet UIView *dateSelectButtonContainer;
@property(weak, nonatomic) IBOutlet UIView *prevButtonContainer;
@property(weak, nonatomic) IBOutlet UIView *nextButtonContainer;
@property(strong, nonatomic) DatePickerController *datePickerController;
@property(nonatomic, getter=isEventPopoverVisible) BOOL eventPopoverVisible;
@property(nonatomic, getter=isDateSelectPopoverVisible) BOOL dateSelectPopoverVisible;

- (IBAction)onEvent:(UIButton *)sender;
- (CGRect)dateSelectButtonFrame;
- (CGRect)prevButtonFrame;
- (CGRect)nextButtonFrame;
@end

@implementation CalendarCalcViewController_iPad {
    UIPopoverController *_currentPopover;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _datePickerController = [[DatePickerController alloc] init];
    }
    return self;
}

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

    self.eventViewController.delegate = self;
    [self setupLayoutWithOrientation:self.interfaceOrientation];
}

- (void)viewDidUnload {
    [self setCalendarViewContainer:nil];
    [self setDateSelectButtonContainer:nil];
    [self setPrevButtonContainer:nil];
    [self setNextButtonContainer:nil];
    [self setEventButton:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.datePickerController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration
{
    if ([_currentPopover isPopoverVisible]) {
        self.eventPopoverVisible = YES;
        [_currentPopover dismissPopoverAnimated:YES];
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
        [_currentPopover presentPopoverFromRect:self.eventButton.frame
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


#pragma mark - Override

- (void)showEventView:(UIButton *)sender
{
    if ([_currentPopover isPopoverVisible]) {
        [_currentPopover dismissPopoverAnimated:YES];
    }
    
    _currentPopover = [[UIPopoverController alloc] initWithContentViewController:self.eventViewController];
    _currentPopover.delegate = self;
    [_currentPopover presentPopoverFromRect:sender.frame
                                     inView:self.view
                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                   animated:YES];
}

- (void)configureView
{
    self.display.text = [self.calendarCalcFormatter displayResult];
    self.indicator.text = [self.calendarCalcFormatter displayIndicator];
    [self.clearButton setTitle:[self.calendarCalcFormatter displayClearButtonTitle]
                      forState:UIControlStateNormal];
}


#pragma mark - Action

- (IBAction)onEvent:(UIButton *)sender {
    [self showEventView:sender];
}


#pragma mark - EventViewController

- (void)eventViewControllerDidDone:(EventViewController *)eventViewController
{
    if ([_currentPopover isPopoverVisible]) {
        [_currentPopover dismissPopoverAnimated:YES];
    }
    [self onEventDone];
}


#pragma mark - UIPopoverController

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    
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