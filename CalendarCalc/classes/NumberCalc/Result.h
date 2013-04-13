//
//  Result.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/12.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject
@property(strong, nonatomic) NSDate *date;

+ (Result *)resultWithNumberString:(NSString *)number decimalString:(NSString *)decimal;
+ (Result *)resultWithDecimalNumber:(NSDecimalNumber *)decimalNumber;

- (NSString *)stringNumberValue;
- (NSDecimalNumber *)decimalNumberValue;
@end
