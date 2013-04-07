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
#import "UIBarButtonItem+AdditionalConvenienceConstructor.h"
#import "UIView+MutableFrame.h"

@interface EventViewController ()<EventManagerDelegate>
@property(strong, nonatomic) UIToolbar *toolbar;
@property(strong, nonatomic) UIPickerView *pickerView;
@property(strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property(strong, nonatomic) EventManager *eventManager;

- (void)onDone:(UIBarButtonItem *)sender;
- (void)onCancel:(UIBarButtonItem *)sender;
- (CGRect)viewFrame;
@end

@implementation EventViewController {
    BOOL _isInit;
}

- (id)init
{
    if ((self = [super init])) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        [_toolbar setBarStyle:UIBarStyleBlackOpaque];
        [_toolbar setItems:@[[UIBarButtonItem cancelButtonItemWithTarget:self action:@selector(onCancel:)],
                             [UIBarButtonItem flexibleSpaceItem],
                             [UIBarButtonItem doneButtonItemWithTarget:self action:@selector(onDone:)]]];
        [_toolbar sizeToFit];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        [_pickerView setFrameOriginY:_toolbar.bounds.size.height];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.userInteractionEnabled = NO;
       
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:_pickerView.frame];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _indicatorView.color = [UIColor grayColor];
        [_indicatorView startAnimating];
        _indicatorView.hidden = NO;
        
        _eventManager = [[EventManager alloc] initWithDelegate:self];
        _isInit = YES;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.toolbar];
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.indicatorView];
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


#pragma mark - Action

- (void)onCancel:(UIBarButtonItem *)sender
{
    [self.delegate eventViewControllerDidCancel:self];
}

- (void)onDone:(UIBarButtonItem *)sender
{
    [self.delegate eventViewControllerDidDone:self];
}


#pragma mark - Private

- (CGRect)viewFrame
{
    return CGRectMake(0,
                      0,
                      self.pickerView.frame.size.width,
                      self.pickerView.frame.origin.y + self.pickerView.frame.size.height);
}
@end
