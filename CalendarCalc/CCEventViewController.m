//
//  CCEventViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCEventViewController.h"
#import "ASCEventManager.h"
#import "NSArray+safe.h"
#import "NSDate+Component.h"
#import "NSDate+Style.h"

@interface CCEventViewController ()
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) ASCEventManager *eventManager;

- (void)eventLoadCompletion;
@end

@implementation CCEventViewController
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
        
        _eventManager = [[ASCEventManager alloc] init];
        [_eventManager eventLoadWithCompletion:^(BOOL granted) {
            [self eventLoadCompletion];            
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = self.pickerView.frame;
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDate *)selectedDate
{
    EKEvent *event = [self.eventManager.events safeObjectAtIndex:[self.pickerView selectedRowInComponent:0]];
    if (event) {
        _selectedDate = [[event startDate] noTime];
    }
    return _selectedDate;
}

#pragma UIPickerView

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
            NSLocalizedString(@"SEPARATOR", nil),
            [date month],
            NSLocalizedString(@"SEPARATOR", nil),
            [date day],
            event.title];
}


#pragma mark - Private

- (void)eventLoadCompletion
{
    NSInteger index = [self.eventManager.events indexOfObject:self.eventManager.todayEvent];
    [self.pickerView reloadAllComponents];
    if (index != NSNotFound) {
        [self.pickerView selectRow:index inComponent:0 animated:NO];
    }
    self.indicatorView.hidden = YES;
    [self.indicatorView stopAnimating];

    self.pickerView.userInteractionEnabled = YES;
}

@end
