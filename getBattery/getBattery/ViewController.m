//
//  ViewController.m
//  getBattery
//
//  Created by bigtree on 2017/5/30.
//  Copyright © 2017年 bigtree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getBatteryFirst];
   //[self getBatterySecond];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)getBatteryFirst{
    /*
     第一种方法获取电量
     */
    CGFloat batteryQuantity = [self getBatteryQuantity];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 300, 50)];
    label.text = [NSString stringWithFormat:@"一:手机剩余电量:%.2f",batteryQuantity];
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
}


-(CGFloat)getBatteryQuantity
{
    //通过UIDevice类，可以取得电池剩余量以及充电状态的信息，首先需要设置batteryMonitoringEnabled为YES
    UIDevice * device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    
    NSLog(@"%f", device.batteryLevel);
    
    NSLog(@"%ld", (long)device.batteryState);
    return device.batteryLevel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
