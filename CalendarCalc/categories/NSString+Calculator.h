//
//  NSString+Calculator.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCFunction.h"

@interface NSString (Calculator)
+ (NSString *)stringWithFunction:(CCFunction)function;
@end
