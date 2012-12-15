//
//  CCCalendarCalcResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCCalendarCalcResult : NSObject {
  @private
    NSMutableString *_string;
    
    NSInteger _number;
    NSInteger _decimal;
    BOOL _isDecimal;

    NSDate *_date;
}

@end
