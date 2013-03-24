//
//  CCFunction.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/30.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#ifndef CalendarCalc_Function_h
#define CalendarCalc_Function_h

typedef enum {
    FunctionNone,
    FunctionDecimal = 301,
    FunctionEqual,
    FunctionPlus,
    FunctionMinus,
    FunctionMultiply,
    FunctionDivide,
    FunctionClear,
    FunctionPlusMinus,
    FunctionDelete,

    FunctionMax,
} Function;

#endif
