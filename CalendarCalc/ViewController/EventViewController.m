//
//  CCEventViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "EventViewController.h"
#import "EventManager.h"
#import "NSArray+safe.h"
#import "NSDate+Component.h"
#import "NSDate+Style.h"
#import "NSString+Locale.h"

@interface EventViewController () <EventManagerDelegate> {
  @private
    BOOL _isInit;
}
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) EventManager *eventManager;

- (CGRect)viewFrame;
- (UIToolbar *)toolbar;
- (void)onDone:(UIBarButtonItem *)sender;
@end

@implementation EventViewController
@synthesize selectedDate = _selectedDate;

- (id)init
{
    if ((self = [super init])) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.userInteractionEnabled = NO;
        [self.view addSubview:_pickerView];
       
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:_pickerView.frame];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _indicatorView.color = [UIColor grayColor];
        [_indicatorView startAnimating];
        _indicatorView.hidden = NO;
        [self.view addSubview:_indicatorView];
        
        _eventManager = [[EventManager alloc] initWithDelegate:self];
        _isInit = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIToolbar *toolbar = [self toolbar];
        [self.view addSubview:toolbar];
        
        CGRect pickerFrame = self.pickerView.frame;
        pickerFrame.origin.y += toolbar.frame.size.height;
        self.pickerView.frame = pickerFrame;
    }

    self.view.frame = [self viewFrame];
    self.contentSizeForViewInPopover = self.view.frame.size;
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSDate *)selectedDate
{
    EKEvent *event = [self.eventManager.events safeObjectAtIndex:[self.pickerView selectedRowInComponent:0]];
    if (event) {
        _selectedDate = [[event startDate] noTime];
    }
    return _selectedDate;
}


#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.eventManager.events.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    EKEvent *event = self.eventManager.events[row];
    NSDate *date = [event.startDate noTime];
    return [NSString stringWithFormat:@"%d%@%02d%@%02d %@",
            [date year],
            [NSString dateSeparator],
            [date month],
            [NSString dateSeparator],
            [date day],
            event.title];
}


#pragma mark - EventManager

- (void)startEventLoad:(EventManager *)eventManager
{
    [self.pickerView reloadAllComponents];
    [self.indicatorView startAnimating];
    [self.indicatorView setHidden:NO];
}

- (void)completeEventLoad:(EventManager *)eventManager
                  granted:(BOOL)granted
{
    [self.pickerView reloadComponent:0];
    
    if (_isInit) {
        NSInteger index = [self.eventManager.events indexOfObject:self.eventManager.todayEvent];
        if (index != NSNotFound) {
            [self.pickerView selectRow:index inComponent:0 animated:NO];
        }
        _isInit = NO;
    }
    
    [self.indicatorView setHidden:YES];
    [self.indicatorView stopAnimating];
    [self.pickerView setUserInteractionEnabled:YES];
}

- (CGRect)viewFrame
{
    return CGRectMake(0,
                      0,
                      self.pickerView.frame.size.width,
                      self.pickerView.frame.origin.y + self.pickerView.frame.size.height);
}

- (UIToolbar *)toolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.pickerView.frame.size.width, 44.0)];
    [toolbar setItems:@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                      target:nil
                                                                      action:nil],
                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                      target:self
                                                                      action:@selector(onDone:)]]];
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    return toolbar;
}

- (void)onDone:(UIBarButtonItem *)sender
{
    [self.delegate eventViewControllerDidDone:self];
}

@end
