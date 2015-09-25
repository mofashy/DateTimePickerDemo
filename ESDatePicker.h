//
//  ESDatePicker.h
//  DateTimePickerDemo
//
//  Created by 沈永聪 on 15/9/24.
//  Copyright (c) 2015年 沈永聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerDelegate <NSObject>
@optional
- (void)datePickerDidChooseDate:(NSDate *)date;
@end

@interface ESDatePicker : UIView
/**
 *  显示日期选择器
 */
- (void)showDatePicker;
@property(nonatomic, weak) id<DatePickerDelegate> delegate;
@end
