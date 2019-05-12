//
//  UIView+Layer.m
//  guoziyuan
//
//  Created by aibaimm on 2017/8/22.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)
-(void) setLayerCornerRadius:(CGFloat)radius withWidth:(CGFloat)width color:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}



@end
