//
//  CCCalendarCalcResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCNumberResult;
@class CCDateResult;

@interface CCCalendarCalcResult : NSObject {
  @private
    NSString *_displayResult;
    CCNumberResult *_numberResult;
    CCDateResult *_dateResult;
    BOOL _isNumberResult;
    BOOL _isEmpty;
}

- (void)clear;
- (void)updateDisplayResult;
- (NSString *)displayResult;
@end
