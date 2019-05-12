//  ZSProgressHUD.m
//  LuckyBuy
//
//  Created by zhangShuai on 17/8/24.
//  Copyright © 2017年 张帅. All rights reserved.

#import <UIKit/UIKit.h>

@interface ZSProgressHUD : UIView

@property (nonatomic , copy) NSString *tipText;

@property (nonatomic , strong) UIColor *toastColor;

@property (nonatomic , strong) UIColor *contentColor;

@property (nonatomic , assign) BOOL showMask;

- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;

- (instancetype)initWithFrame:(CGRect)frame showText:(NSString *)showText isLoading:(BOOL)isLoading successful:(BOOL)successful;
///加载类型
+ (instancetype)showHUDShowText:(NSString *)showText;
//加载成功提示
+ (instancetype)showSuccessfulText:(NSString *)ShowText;
//错误提示
+ (instancetype)showErrorText:(NSString *)ShowText;
+ (NSUInteger)hideAllHUDAnimated:(BOOL)animated;


@end
