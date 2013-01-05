//
//  CCCalendarCalcViewController_iPad.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/03.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcViewController_iPad.h"
#import "CCCalendarCalcViewController_iPad+Orientation.h"
#import "CCYearMonthPickerController.h"

@interface CCCalendarCalcViewController_iPad () <CCEventViewControllerDelegate> {
  @private
    UIPopoverController *_currentPopover;
    BOOL _isEventPopoverVisible;
    BOOL _isDateSelectPopoverVisible;
}
@property (weak, nonatomic) IBOutlet UIButton *eventButton;
@property (weak, nonatomic) IBOutlet UIView *calendarViewContainer;
@property (weak, nonatomic) IBOutlet UIView *dateSelectButtonContainer;
@property (weak, nonatomic) IBOutlet UIView *prevButtonContainer;
@property (weak, nonatomic) IBOutlet UIView *nextButtonContainer;
@property (strong, nonatomic) CCYearMonthPickerController *yearMonthPickerController;

- (IBAction)onEvent:(UIButton *)sender;
- (CGRect)dateSelectButtonFrame;
- (CGRect)prevButtonFrame;
- (CGRect)nextButtonFrame;
@end

@implementation CCCalendarCalcViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _yearMonthPickerController = [[CCYearMonthPickerController alloc] init];
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
    self.eventViewController = nil;
    self.yearMonthPickerController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration
{
    if ([_currentPopover isPopoverVisible]) {
        _isEventPopoverVisible = YES;
        [_currentPopover dismissPopoverAnimated:YES];
    }
   
    if ([self.calendarViewController isPopoverVisible]) {
        _isDateSelectPopoverVisible = YES;
        [self.calendarViewController dismissPopoverAnimated:YES];
    }

    [UIView animateWithDuration:0.25 animations:^{
        [self setupLayoutWithOrientation:toInterfaceOrientation];
    }];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (_isEventPopoverVisible) {
        [_currentPopover presentPopoverFromRect:self.eventButton.frame
                                         inView:self.view
                       permittedArrowDirections:UIPopoverArrowDirectionAny
                                       animated:YES];
        _isEventPopoverVisible = NO;
    }
   
    if (_isDateSelectPopoverVisible) {
        [self.calendarViewController presentPopoverAnimated:YES];
        _isDateSelectPopoverVisible = NO;
    }
}


#pragma mark - Override

- (void)showEventView:(UIButton *)sender
{
    if (!self.eventViewController) {
        self.eventViewController = [[CCEventViewController alloc] init];
        self.eventViewController.delegate = self;
    }
   
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


#pragma mark - IBAction

- (IBAction)onEvent:(UIButton *)sender {
    [self showEventView:sender];
}


#pragma mark - CCEventViewController

- (void)eventViewControllerDidDone:(CCEventViewController *)eventViewController
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
