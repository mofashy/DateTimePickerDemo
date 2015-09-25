//
//  ESDatePicker.m
//  DateTimePickerDemo
//
//  Created by 沈永聪 on 15/9/24.
//  Copyright (c) 2015年 沈永聪. All rights reserved.
//

#import "ESDatePicker.h"

#define screenSize [UIScreen mainScreen].bounds.size

@interface ESDatePicker ()
@property(nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation ESDatePicker

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, screenSize.height, screenSize.width, 216+44);
        self.backgroundColor = [UIColor whiteColor];
        [self createDatePicker];
        [self createToolBar];
    }
    
    return self;
}

- (void)createDatePicker
{
    self.datePicker=[[UIDatePicker alloc]init];
    [self.datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    self.datePicker.datePickerMode=UIDatePickerModeDate;
    self.datePicker.frame = CGRectMake(0, 44, self.datePicker.bounds.size.width, self.datePicker.bounds.size.height);
    [self addSubview:self.datePicker];
}

- (void)createToolBar
{
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 44)];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(hideDatePicker)];
    UIBarButtonItem *centerItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                             target:nil
                                                                             action:nil];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(doneButtonDidClicked)];
    toolbar.items = @[leftItem, centerItem, rightItem];
    [self addSubview:toolbar];
}

- (void)showDatePicker
{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.center = CGPointMake(screenSize.width/2, screenSize.height-260/2);
    } completion:nil];
}

- (void)hideDatePicker
{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.center = CGPointMake(screenSize.width/2, screenSize.height+260/2);
    } completion:nil];
}

- (void)doneButtonDidClicked
{
    if ([self.delegate respondsToSelector:@selector(datePickerDidChooseDate:)]) {
        [self.delegate datePickerDidChooseDate:self.datePicker.date];
    }
    [self hideDatePicker];
}
@end
