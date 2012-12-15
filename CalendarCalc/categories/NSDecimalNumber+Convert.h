//
//  NSNumber+Convert.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Convert)
+ (NSDecimalNumber *)negate:(NSDecimalNumber *)number;
NSDecimalNumber *DecimalNumber(NSString *const string);
@end
