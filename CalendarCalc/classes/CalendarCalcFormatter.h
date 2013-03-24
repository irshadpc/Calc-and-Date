//
//  CCCalendarCalcFormatter.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalendarCalc;

@interface CalendarCalcFormatter : NSObject {
  @private
    NSString *_cachedIndicator;
}
@property (strong, nonatomic) CalendarCalc *calendarCalc;

- (id)initWithCalendarCalc:(CalendarCalc *)calendarCalc;
- (NSString *)displayResult;
- (NSString *)displayIndicator;
- (NSString *)displayClearButtonTitle;
@end
