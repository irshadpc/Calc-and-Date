//
//  NumberCalc.m
//  CalendarCalc
//
//  Created by 純一 石田 on 12/07/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NumberCalc.h"
#import "NSDecimalNumber+util.h"

@implementation NumberCalc

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)equal:(NSDecimalNumber *)rOperand {
    if (!rOperand) {
        return nil;
    }

    result = rOperand;
    return result;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)result {
    if (!result) {
        return nil;
    }
    return result;
}

////////////////////////////////////////////////////////////////////////////////
- (void)clear {
    result = nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)plus:(NSDecimalNumber *)rOperand {
    if (!rOperand) {
        return nil;
    }

    result = [NSDecimalNumber addingByDecimalNumber:result rOperand:rOperand];
    return result;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)minus:(NSDecimalNumber *)rOperand {
    if (!rOperand) {
        return nil;
    }
    
    result = [NSDecimalNumber subtractingByDecimalNumber:result rOperand:rOperand];   
    return result;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)multiply:(NSDecimalNumber *)rOperand {
    if (!rOperand) {
        return nil;
    }

    result = [NSDecimalNumber multiplyingByDecimalNumber:result rOperand:rOperand];
    return result;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)divide:(NSDecimalNumber *)rOperand {
    if (!rOperand) {
        return nil;
    }

    result = [NSDecimalNumber dividingByDecimalNumber:result rOperand:rOperand];
    return result;
}
@end
