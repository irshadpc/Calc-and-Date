//
//  CCFunction.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/30.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#ifndef CalendarCalc_CCFunction_h
#define CalendarCalc_CCFunction_h

typedef enum {
    CCFunctionNone,
    CCDecimal = 301,
    CCEqual,
    CCPlus,
    CCMinus,
    CCMultiply,
    CCDivide,
    CCClear,
    CCPlusMinus,
    CCDelete,

    CCFunctionMax,
} CCFunction;

#endif
