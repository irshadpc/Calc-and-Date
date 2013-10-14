
//
//  ASCSwitchButton.m
//  CalendarCalc
//
//  Created by Junichi Ishida on 2012/08/01.
//
//

#import "SwitchButton.h"
#import "UIColor+CalendarCalc.h"
#import "UIImage+CalendarCalc.h"

@implementation SwitchButton

- (void)setOn:(BOOL)on
{
    if (_on != on) {
        _on = on;
    }

    if (_on) {
        [self setBackgroundImage:[UIImage stateOnImage] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor titleColorForStateOn] forState:UIControlStateNormal];
        [self setTitleShadowColor:[UIColor titleShadowColorForStateOn] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage stateOffImage] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor titleColorForStateOff] forState:UIControlStateNormal];
        [self setTitleShadowColor:[UIColor titleShadowColorForStateOff] forState:UIControlStateNormal];
    }
}

@end