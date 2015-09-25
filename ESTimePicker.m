//
//  ESTimePicker.m
//  DateTimePickerDemo
//
//  Created by 沈永聪 on 15/9/24.
//  Copyright (c) 2015年 沈永聪. All rights reserved.
//

#import "ESTimePicker.h"

#define screenSize [UIScreen mainScreen].bounds.size

@interface ESTimePicker () <UIPickerViewDelegate, UIPickerViewDataSource>
@property(nonatomic, strong) NSMutableArray *hourArrayM;
@property(nonatomic, strong) NSMutableArray *minuteArrayM;
@property(nonatomic, strong) UIPickerView *pickerView;
@end

@implementation ESTimePicker

- (NSMutableArray *)hourArrayM
{
    if (!_hourArrayM) {
        _hourArrayM = [NSMutableArray array];
        for (int i=0; i<=23; i++) {
            [_hourArrayM addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
    return _hourArrayM;
}

- (NSMutableArray *)minuteArrayM
{
    if (!_minuteArrayM) {
        _minuteArrayM = [NSMutableArray array];
        for (int i=0; i<=59; i++) {
            [_minuteArrayM addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }
    
    return _minuteArrayM;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, screenSize.height, screenSize.width, 216+44);
        self.backgroundColor = [UIColor whiteColor];
        [self createDatePicker];
        [self createToolBar];
        
        // 默认选中当前时间
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger time = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
        NSDateComponents *components = [calendar components:time fromDate:now];
        [self setDefaultTimeWithHour:components.hour minute:components.minute];
    }
    
    return self;
}

- (void)setDefaultTimeWithHour:(NSUInteger)hour minute:(NSUInteger)minute
{
    [self.pickerView selectRow:hour inComponent:0 animated:NO];
    [self.pickerView selectRow:minute inComponent:1 animated:NO];
}

- (void)createDatePicker
{
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.frame = CGRectMake(0, 44, screenSize.width, 216);
    [self addSubview:self.pickerView];
}

- (void)createToolBar
{
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 44)];
    /*
        Toolbar背景颜色和按钮颜色，有需要则修改下面两行代码
     */
//    toolbar.barTintColor = [UIColor colorWithRed:60/255.0f green:197/255.0f blue:188/255.0f alpha:1.0f];
//    toolbar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(hideTimePicker)];
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

#pragma mark - Picker view datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return component==0 ? self.hourArrayM.count : self.minuteArrayM.count;
}

#pragma mark - Picker view delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 80;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20];
    if (component==0) {
        label.text = self.hourArrayM[row];
    } else {
        label.text = self.minuteArrayM[row];
    }
    
    return label;
}

- (void)showTimePicker
{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.center = CGPointMake(screenSize.width/2, screenSize.height-260/2);
    } completion:nil];
}

- (void)showTimePickerWithSuggestedTime:(NSString *)time
{
    if ([time rangeOfString:@":"].location != NSNotFound) {
        NSArray *components = [time componentsSeparatedByString:@":"];
        [self setDefaultTimeWithHour:[components[0] integerValue] minute:[components[1] integerValue]];
    }
    
    [self showTimePicker];
}

- (void)hideTimePicker
{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.center = CGPointMake(screenSize.width/2, screenSize.height+260/2);
    } completion:nil];
}

- (void)doneButtonDidClicked
{
    NSInteger hour = [self.pickerView selectedRowInComponent:0];
    NSInteger minute = [self.pickerView selectedRowInComponent:1];
    
    NSString *time = [NSString stringWithFormat:@"%ld:%02ld", hour, minute];
    
    if ([self.delegate respondsToSelector:@selector(timePickerDidChooseTime:)]) {
        [self.delegate timePickerDidChooseTime:time];
    }
    [self hideTimePicker];
}
@end
