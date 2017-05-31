//
//  ViewController.m
//  getBattery
//
//  Created by bigtree on 2017/5/30.
//  Copyright © 2017年 bigtree. All rights reserved.
//

#import "ViewController.h"
#import "IOPSKeys.h"
#import "IOPowerSources.h"
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

- (void)getBatterySecond{
 
    /*
     第二种方法获取电量
     */
    CGFloat batteryQuantity = [self getBatteryQuantity];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 300, 50)];
    label.text = [NSString stringWithFormat:@"二:手机剩余电量:%.2f",batteryQuantity];
    label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];
}

-(double)getCurrentBatteryLevel
{
    
    //Returns a blob of Power Source information in an opaque CFTypeRef.
    CFTypeRef blob = IOPSCopyPowerSourcesInfo();
    
    //Returns a CFArray of Power Source handles, each of type CFTypeRef.
    CFArrayRef sources = IOPSCopyPowerSourcesList(blob);
    
    CFDictionaryRef pSource = NULL;
    const void *psValue;
    
    //Returns the number of values currently in an array.
    int numOfSources = CFArrayGetCount(sources);
    
    //Error in CFArrayGetCount
    if (numOfSources == 0)
    {
        NSLog(@"Error in CFArrayGetCount");
        return -1.0f;
    }
    
    //Calculating the remaining energy
    for (int i = 0 ; i < numOfSources ; i++)
    {
        //Returns a CFDictionary with readable information about the specific power source.
        pSource = IOPSGetPowerSourceDescription(blob, CFArrayGetValueAtIndex(sources, i));
        if (!pSource)
        {
            NSLog(@"Error in IOPSGetPowerSourceDescription");
            return -1.0f;
        }
        psValue = (CFStringRef)CFDictionaryGetValue(pSource, CFSTR(kIOPSNameKey));
        
        int curCapacity = 0;
        int maxCapacity = 0;
        double percent;
        
        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSCurrentCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &curCapacity);
        
        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSMaxCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &maxCapacity);
        
        percent = ((double)curCapacity/(double)maxCapacity * 100.0f);
        
        return percent;
    }
    return -1.0f;
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
