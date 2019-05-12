//
//  ViewController.m
//  FYLCityPicker
//
//  Created by FuYunLei on 2017/4/14.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "PickViewController.h"
#import "FYLCityPickView.h"

@interface PickViewController ()



@end

@implementation PickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)chooseCity{
    
    /*
     
     1.FYLCityPickView.m 中 给model 赋值用到了YYModel
     2.FYLCityPickView 每次显示都会滚动到相应的数据,若不想每次都滚动,可自己改为单例
     3.
     
     */
    __weak PickViewController *weskSelf = self;
//    [FYLCityPickView showPickViewWithComplete:^(NSArray *arr) {
//        weskSelf.labelCity = [NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]];
//    }];
    [[FYLCityPickView new] showPickViewWithDefaultProvince:@"河南" complete:^(NSArray *arr) {
//        weskSelf.click(arr);
        NSLog(@"22222====%@",[NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]]);
    }];
    
   
}


@end
