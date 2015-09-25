//
//  ESTimePicker.h
//  DateTimePickerDemo
//
//  Created by 沈永聪 on 15/9/24.
//  Copyright (c) 2015年 沈永聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimePickerDelegate <NSObject>
@optional
- (void)timePickerDidChooseTime:(NSString *)time;
@end

@interface ESTimePicker : UIView
/**
 *  显示时间选择器
 */
- (void)showTimePicker;
/**
 *  显示时间选择器并提供建议时间
 *
 *  @param time 建议时间
 */
- (void)showTimePickerWithSuggestedTime:(NSString *)time;
@property(nonatomic, weak) id<TimePickerDelegate> delegate;
@end
