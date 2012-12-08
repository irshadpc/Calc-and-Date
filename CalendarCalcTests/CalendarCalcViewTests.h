//
//  CalendarCalcViewTests.h
//  CalendarCalc
//
//  Created by Junichi Ishida on 2012/07/27.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CalendarCalcViewController.h"

@class AppDelegate;
@class CalendarCalcViewController;
@class View;

@interface CalendarCalcViewTests : SenTestCase {
 @private
   AppDelegate *delegate;
   CalendarCalcViewController *viewController;
   UIView *calendarCalcView;
}
@end
