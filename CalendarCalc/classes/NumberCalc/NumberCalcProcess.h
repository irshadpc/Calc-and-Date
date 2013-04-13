//
//  NumberCalcProcess.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Function.h"

@interface NumberCalcProcess : NSObject
- (NSDecimalNumber *)calculateWithFunction:(Function)function operand:(NSDecimalNumber *)operand;
@end
