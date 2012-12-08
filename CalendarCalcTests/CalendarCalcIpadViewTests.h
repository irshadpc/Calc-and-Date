//
//  CalendarCalcIpadViewTests.h
//  CalendarCalc
//
//  Created by Junichi Ishida on 2012/08/06.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "AppDelegate.h"
#import "IpadViewController.h"

@class IpadViewController;

@interface CalendarCalcIpadViewTests : SenTestCase {
@private
    AppDelegate *delegate;
    IpadViewController *viewController;
    UIView *calendarCalcView;
}

@end
