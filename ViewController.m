//
//  ViewController.m
//  DateTimePickerDemo
//
//  Created by 沈永聪 on 15/9/24.
//  Copyright (c) 2015年 沈永聪. All rights reserved.
//

#import "ViewController.h"
#import "ESDatePicker.h"
#import "ESTimePicker.h"

@interface ViewController () <DatePickerDelegate, TimePickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) ESDatePicker *datePicker;
@property (strong, nonatomic) ESTimePicker *timePicker;
@end

@implementation ViewController

- (ESDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[ESDatePicker alloc] init];
        _datePicker.delegate = self;
    }
    
    return _datePicker;
}

- (ESTimePicker *)timePicker
{
    if (!_timePicker) {
        _timePicker = [[ESTimePicker alloc] init];
        _timePicker.delegate = self;
    }
    
    return _timePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textField.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)DateBtnClicked:(id)sender {
    if (!_datePicker) {
        [self.view addSubview:self.datePicker];
    }
    [self.datePicker showDatePicker];
}

- (IBAction)TimeBtnClicked:(id)sender {
    if (!_timePicker) {
        [self.view addSubview:self.timePicker];
    }
    //    [self.timePicker showTimePicker];
    [self.timePicker showTimePickerWithSuggestedTime:@"7:00"];
}

- (void)datePickerDidChooseDate:(NSDate *)date
{
    self.textField.text = [NSString stringWithFormat:@"%@", date];
}

- (void)timePickerDidChooseTime:(NSString *)time
{
    self.textField.text = time;
}
@end
