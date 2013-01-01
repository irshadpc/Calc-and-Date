//
//  NumberCalc.h
//  CalendarCalc
//
//  Created by 純一 石田 on 12/07/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberCalc : NSObject {
@private
    NSDecimalNumber *result;
}
- (NSDecimalNumber *)equal:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)result;
- (void)clear;

- (NSDecimalNumber *)plus:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)minus:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)multiply:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)divide:(NSDecimalNumber *)rOperand;
@end
