//
//  ZSProgressHUD.m
//
//  Created by zhangShuai on 17/8/24.
//  Copyright © 2017年 张帅. All rights reserved.
//

#import "ZSProgressHUD.h"
#import <CoreText/CoreText.h>

#define SIZE_RADIUS_WIDTH 15
#define SIZE_FONT_TIP 13
#define LINE_WIDTH 2


#define KEY_ANIMATION_ROTATE @"KEY_ANIMATION_ROTATE"
#define KEY_ANIMATION_TEXT @"KEY_ANIMATION_TEXT"
#define SCREEN [UIScreen mainScreen].bounds.size
#define RGB(r,g,b,a) ([UIColor colorWithRed:r green:g blue:b alpha:a])


@interface ZSProgressHUD()

@property (nonatomic , strong) UIView *toast;

@property (nonatomic , strong) UIView *rotateView;

@property (nonatomic , strong) CAShapeLayer *rotateLayer;

@property (nonatomic , strong) CAShapeLayer *textLayer;
@end

@implementation ZSProgressHUD

+ (instancetype)showHUDShowText:(NSString *)showText
{
    ZSProgressHUD *hud = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds showText:showText isLoading:YES successful:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [hud show:NO];
    return hud;
}
//
+ (instancetype)showSuccessfulText:(NSString *)ShowText {
    [ZSProgressHUD hideAllHUDAnimated:NO];
    ZSProgressHUD *hud = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds showText:ShowText isLoading:NO successful:YES];
    [hud show:NO];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [self performSelector:@selector(DelayHideHud) withObject:nil afterDelay:1.5];
    return hud;
}
+ (instancetype)showErrorText:(NSString *)ShowText {
    [ZSProgressHUD hideAllHUDAnimated:NO];
    ZSProgressHUD *hud = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds showText:ShowText isLoading:NO successful:NO];
    [hud show:NO];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [self performSelector:@selector(DelayHideHud) withObject:nil afterDelay:1.5];
    return hud;
}
//延迟隐藏hud
+ (void)DelayHideHud {
     [ZSProgressHUD hideAllHUDAnimated:YES];
}
#pragma mark 隐藏
+ (NSUInteger)hideAllHUDAnimated:(BOOL)animated
{
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews =[UIApplication sharedApplication].keyWindow.subviews;
    for (UIView *aView in subviews)
    {
        if ([aView isKindOfClass:[ZSProgressHUD class]])
        {
            [huds addObject:aView];
        }
    }
    
    for (ZSProgressHUD *hud in huds)
    {
        [hud hide:animated];
    }
    return [huds count];
}

- (void)dealloc
{
    
}

static CGFloat toastWidth = 70;
- (instancetype)initWithFrame:(CGRect)frame showText:(NSString *)showText isLoading:(BOOL)isLoading successful:(BOOL)successful
{
    self = [super initWithFrame:frame];
    if (self)
    {
       
        _toast = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - toastWidth) / 2, (self.frame.size.height - toastWidth) / 2 , toastWidth, toastWidth)];
        _toast.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _toast.layer.cornerRadius = 10;
        _toast.hidden = YES;
        [self addSubview:_toast];
        
        //绘制文字
        _textLayer = [CAShapeLayer layer];
        _textLayer.fillColor   = [UIColor clearColor].CGColor;
        _textLayer.strokeColor = [UIColor whiteColor].CGColor;
        _textLayer.lineWidth   = 1;
        _textLayer.lineCap = kCALineCapButt;
        [_toast.layer addSublayer:_textLayer];
        
        self.tipText = showText;
        
        if (isLoading) {
            //加载
            [self loadingAnimated];
        } else {
            if (successful) {
                //成功
                [self pictureCorrect];
            } else {
                //失败效果
                [self picturError];
            }
        }

    }
    return self;
}
#pragma mark 成功效果
- (void)pictureCorrect {
    CGFloat height =_toast.frame.size.height-30;
    UIView * successfulView = [[UIView alloc] initWithFrame:CGRectMake((_toast.frame.size.width/2)-height/2, 5, height, height)];
    
    successfulView.backgroundColor=[UIColor clearColor];
    [_toast addSubview:successfulView];
    CGFloat x = 2;
    CGFloat y = 2;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, successfulView.frame.size.width, successfulView.frame.size.height) cornerRadius:successfulView.frame.size.height/2];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    //开始点
    [path moveToPoint:CGPointMake(11, y+22)];
    //
    CGPoint P1 = CGPointMake(successfulView.frame.size.width/2, successfulView.frame.size.height-8);
    [path addLineToPoint:P1];
    CGPoint P2 = CGPointMake(successfulView.frame.size.width-5, 13);
    [path addLineToPoint:P2];
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.strokeColor = [[UIColor whiteColor] CGColor];
    layer.lineWidth = LINE_WIDTH;
    layer.path = path.CGPath;
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 1;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [successfulView.layer addSublayer:layer];
    
   
    
    ///文字动画
    CABasicAnimation *textAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    textAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    textAnimation.fromValue = @(0);
    textAnimation.toValue = @1;
    textAnimation.duration = 1;
    textAnimation.repeatCount = 1;
    textAnimation.removedOnCompletion = NO;
    [_textLayer addAnimation:textAnimation forKey:nil];
}
#pragma mark 错误效果
- (void)picturError {
    CGFloat height =_toast.frame.size.height-30;
    UIView * errorView = [[UIView alloc] initWithFrame:CGRectMake((_toast.frame.size.width/2)-height/2, 5, height, height)];
    errorView.backgroundColor=[UIColor clearColor];
    [_toast addSubview:errorView];
    CGFloat x = 2;
    CGFloat y = 2;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, errorView.frame.size.width, errorView.frame.size.height) cornerRadius:errorView.frame.size.height/2];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    //开始点
    [path moveToPoint:CGPointMake(12, 13)];
    CGPoint P1 =  CGPointMake(errorView.frame.size.width-8, errorView.frame.size.height-8);
    //第二个点
    [path addLineToPoint:P1];
    
    [path moveToPoint:CGPointMake(errorView.frame.size.width-8, 13)];
    CGPoint P2 = CGPointMake(12, errorView.frame.size.height-8);
    [path addLineToPoint:P2];
    
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.strokeColor = [[UIColor whiteColor] CGColor];
    layer.lineWidth = LINE_WIDTH;
    layer.path = path.CGPath;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [errorView.layer addSublayer:layer];
    
    
    ///文字动画
    CABasicAnimation *textAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    textAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    textAnimation.fromValue = @(0);
    textAnimation.toValue = @1;
    textAnimation.duration = 1;
    textAnimation.repeatCount = 1;
    textAnimation.removedOnCompletion = NO;
    [_textLayer addAnimation:textAnimation forKey:nil];
}

#pragma mark 加载动画
- (void)loadingAnimated {
    _rotateView = [[UIView alloc] initWithFrame:CGRectMake((_toast.frame.size.width - 2 * SIZE_RADIUS_WIDTH) / 2, (_toast.frame.size.height - 2 * SIZE_RADIUS_WIDTH) / 2 - 5, 2 * SIZE_RADIUS_WIDTH, 2 * SIZE_RADIUS_WIDTH)];
    _rotateView.backgroundColor = [UIColor clearColor];
    [_toast addSubview:_rotateView];
    
    UIBezierPath *pathRotate= [UIBezierPath bezierPathWithArcCenter:CGPointMake(SIZE_RADIUS_WIDTH, SIZE_RADIUS_WIDTH) radius:SIZE_RADIUS_WIDTH startAngle:- M_PI_2 endAngle:(M_PI * 2) * .5 - M_PI_2 clockwise:YES];
    _rotateLayer = [CAShapeLayer layer];
    _rotateLayer.path = pathRotate.CGPath;
    _rotateLayer.fillColor = [UIColor clearColor].CGColor;
    _rotateLayer.strokeColor = [UIColor whiteColor].CGColor;
    _rotateLayer.lineWidth = LINE_WIDTH;
    _rotateLayer.lineCap = kCALineCapRound;
    [_rotateView.layer addSublayer:_rotateLayer];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimation.fromValue = @(2*M_PI);
    rotateAnimation.toValue = @0;
    rotateAnimation.duration = .8;
    rotateAnimation.repeatCount = HUGE;
    rotateAnimation.removedOnCompletion = NO;
    [_rotateView.layer addAnimation:rotateAnimation forKey:KEY_ANIMATION_ROTATE];
    
    
    ///文字动画
    CABasicAnimation *textAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    textAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    textAnimation.fromValue = @(0);
    textAnimation.toValue = @1;
    textAnimation.duration = 2;
    textAnimation.repeatCount = HUGE;
    textAnimation.removedOnCompletion = NO;
    [_textLayer addAnimation:textAnimation forKey:nil];
    
}
- (instancetype)initWithView:(UIView *)view
{
    return [self initWithFrame:view.bounds];
}

- (instancetype)initWithWindow:(UIWindow *)window
{
    return [self initWithView:window];
}

#pragma mark SETORGET
- (void)setTipText:(NSString *)tipText
{
    _tipText = tipText;
    
    [self textLayerPath:tipText];
}

- (void)setToastColor:(UIColor *)toastColor
{
    _toastColor = toastColor;
    _toast.backgroundColor = toastColor;
}

- (void)setContentColor:(UIColor *)contentColor
{
    _rotateLayer.strokeColor = contentColor.CGColor;
    _textLayer.strokeColor = contentColor.CGColor;
}

- (void)setShowMask:(BOOL)showMask
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:showMask - .5];
}

- (void)show:(BOOL)animated
{
    self.toast.hidden = NO;
    if (animated)
    {
        self.toast.transform = CGAffineTransformScale(self.transform,0.2,0.2);
        
        [UIView animateWithDuration:.3 animations:^{
            self.toast.transform = CGAffineTransformScale(self.transform,1.2,1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                self.toast.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)hide:(BOOL)animated
{
    [UIView animateWithDuration:animated ? .3 : 0 animations:^{
        self.toast.transform = CGAffineTransformScale(self.transform,1.2,1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animated ? .3 : 0 animations:^{
            self.toast.transform = CGAffineTransformScale(self.transform,0.2,0.2);
        } completion:^(BOOL finished) {
            [self.rotateView.layer removeAnimationForKey:KEY_ANIMATION_ROTATE];
            [self.textLayer removeAnimationForKey:KEY_ANIMATION_TEXT];
            [self removeFromSuperview];
        }];
    }];
}

#pragma mark Methods
- (UIBezierPath *)textPath:(NSMutableAttributedString *)text
{
    CGMutablePathRef letters = CGPathCreateMutable();
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)text);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
            CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
            CGPathAddPath(letters, &t, letter);
            CGPathRelease(letter);
        }
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:letters];
    CGRect boundingBox = CGPathGetBoundingBox(letters);
    CGPathRelease(letters);
    CFRelease(line);
    
    [path applyTransform:CGAffineTransformMakeScale(1.0, -1.0)];
    [path applyTransform:CGAffineTransformMakeTranslation(0.0, boundingBox.size.height)];
    
    return path;
}

- (void)textLayerPath:(NSString *)text
{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:text];
    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:SIZE_FONT_TIP] range:NSMakeRange(0, attributed.length)];
    _textLayer.path = [self textPath:attributed].CGPath;
    
    CGFloat width = attributed.size.width + 10;
    CGFloat maxWidth = self.frame.size.width - 100;
    if (width >= _toast.frame.size.width)
    {
        CGRect frame = _toast.frame;
        if (width <= maxWidth)
        {
            frame.size.width = width;
        }
        else
        {
            frame.size.width = maxWidth;
        }
        _toast.frame = frame;
    }
    else
    {
        CGRect frame = _toast.frame;
        frame.size.width = toastWidth;
        _toast.frame = frame;
    }
    _toast.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _rotateView.center = CGPointMake(_toast.frame.size.width / 2, _rotateView.center.y);
    _textLayer.position = CGPointMake((_toast.frame.size.width - attributed.size.width) / 2, toastWidth - 20);
}


@end
