//
//  NumberCalc.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Function.h"

@class Result;

@interface NumberCalc : NSObject
- (Result *)inputInteger:(NSInteger)integer;
- (Result *)inputFunction:(Function)function;
@end
