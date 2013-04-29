//
//  EventCell.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/29.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell
@property(strong, nonatomic, readonly) UILabel *dateLabel;
@property(strong, nonatomic, readonly) UILabel *titleLabel;
@end
