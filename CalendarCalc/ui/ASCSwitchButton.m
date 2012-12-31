
//
//  ASCSwitchButton.m
//  CalendarCalc
//
//  Created by Junichi Ishida on 2012/08/01.
//
//

#import "ASCSwitchButton.h"
#import "UIColor+SwitchButton.h"
#import "UIImage+SwitchButton.h"

@implementation ASCSwitchButton

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