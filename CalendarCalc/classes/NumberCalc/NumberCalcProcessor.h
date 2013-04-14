//
//  NumberCalcProcessor.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Function.h"

@interface NumberCalcProcessor : NSObject
- (NSDecimalNumber *)calculateWithFunction:(Function)function
                                  lOperand:(NSDecimalNumber *)lOperand
                                  rOperand:(NSDecimalNumber *)rOperand;
@end
