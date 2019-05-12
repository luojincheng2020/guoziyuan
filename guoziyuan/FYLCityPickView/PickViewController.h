//
//  ViewController.h
//  FYLCityPicker
//
//  Created by FuYunLei on 2017/4/14.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickViewController : UIViewController
@property (strong, nonatomic) NSString *labelCity;
@property (copy, nonatomic)void(^click)(NSArray*arr);
- (void)chooseCity;

@end

