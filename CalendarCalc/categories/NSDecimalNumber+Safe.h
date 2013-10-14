//
//  NSDecimalNumber+Safe.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Safe)
+ (NSDecimalNumber *)addingByDecimalNumber:(NSDecimalNumber *)lOperand rOperand:(NSDecimalNumber *)rOperand;
+ (NSDecimalNumber *)subtractingByDecimalNumber:(NSDecimalNumber *)lOperand rOperand:(NSDecimalNumber *)rOperand;
+ (NSDecimalNumber *)multiplyingByDecimalNumber:(NSDecimalNumber *)lOperand rOperand:(NSDecimalNumber *)rOperand;
+ (NSDecimalNumber *)dividingByDecimalNumber:(NSDecimalNumber *)lOperand rOperand:(NSDecimalNumber *)rOperand;
@end
