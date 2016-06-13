//
//  HudViewController.m
//  BaoluoGamePlatform
//
//  Created by 张齐朴 on 16/3/4.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "HudViewController.h"
#import <objc/runtime.h>

@interface HudViewController ()

@property (strong, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView; // 创建等待视图
@property (weak, nonatomic) IBOutlet UIImageView *loadingImageView; // 加载视图
@property (strong, nonatomic) InfoView *infoView; //操作提示
@property (strong, nonatomic) UIToolbar *finishInputTooBar; // 隐藏键盘按钮
@property (assign, nonatomic) CGFloat inputViewHeight; // 文字表情输入框高度，没有则为零

@end

@implementation HudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addTooBar];
    
    _inputViewHeight = [self isClass:[self class]
                 containTheAttribute:@"InputView"] == YES ? 50:0;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addKeyboardNotification];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self removeKeyboardNotification];
    
    UIWindow *keyWnd = [UIApplication sharedApplication].keyWindow;

    _finishInputTooBar.top = keyWnd.height;
}

#pragma mark - Finish ToolBar

- (void)addTooBar
{
    UIWindow *keyWnd = [UIApplication sharedApplication].keyWindow;
    
    _finishInputTooBar = [keyWnd viewWithTag:100];
    
        if (_finishInputTooBar == nil) {
        
        _finishInputTooBar = [[UIToolbar alloc] initWithFrame:
        CGRectMake(0, keyWnd.height, keyWnd.width + 300, 44.f)];
        _finishInputTooBar.tag = 100;
        

        [keyWnd addSubview:_finishInputTooBar];
    }
    
    // 这里每次都要给当前控制器添加键盘隐藏按钮事件
    UIBarButtonItem *finish = [[UIBarButtonItem alloc]
                               initWithImage:[UIImage imageNamed:@"comment_arrow_down"]
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(endAllEditing)];
    finish.width = 44.f;
    
    _finishInputTooBar.items = @[finish];

}

- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];

}

- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame   = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration  = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = (UIViewAnimationCurve)[userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    void(^animations)() = ^{
        if (CGRectGetMinY(endFrame) == self.view.height)
            _finishInputTooBar.top = CGRectGetMinY(endFrame) + _finishInputTooBar.height ;
        else
            _finishInputTooBar.top = CGRectGetMinY(endFrame) - _finishInputTooBar.height - _inputViewHeight;

    };
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState)
                     animations:animations
                     completion:nil];
}

- (void)endAllEditing
{
    [self.view endEditing:YES];
}

#pragma mark - Show View

- (void)showLoadingView
{
    if (_loadingImageView) return ;
    
    _loadingView = LOADNibName(@"HudView");
    
    [self.view addSubview:_loadingView];
    
    _loadingView.width = self.view.width;
    _loadingView.height = self.view.height;
    
    [self addRotationAnimation];
}

- (void)addRotationAnimation
{
    CABasicAnimation *rotationAnimation   =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.fromValue           = @0;
    rotationAnimation.toValue             = @(2 * M_PI);
    rotationAnimation.duration            = 1;
    rotationAnimation.repeatCount         = CGFLOAT_MAX;
    rotationAnimation.removedOnCompletion = NO;
    
    [_loadingImageView.layer addAnimation:rotationAnimation forKey:@"rotation"];
}

- (void)hideLoadingView
{
    [_loadingImageView.layer removeAnimationForKey:@"rotation"];
    [_loadingView removeFromSuperview];
}

- (void)showIndicatorView
{
    if (_loadingImageView) return ;
    
    _loadingView = LOADNibName(@"IndicatorView");
    _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    [self.view addSubview:_loadingView];
    
    _loadingView.width = self.view.width;
    _loadingView.height = self.view.height;
    

    [_indicatorView startAnimating];
}

- (void)hideIndicatorView
{
    [_indicatorView stopAnimating];
    [_loadingView removeFromSuperview];
}

- (void)showLoadingViewOnWindow
{
    
}

- (void)hideLoadingViewFromWindow
{
    
}

- (void)showInfoView:(NSString *)info infoType:(InfoType)type
{
    if (_infoView == nil) {
        _infoView = LOADNibName(@"InfoView");
        [self.view addSubview:_infoView];
        
        _infoView.frame = CGRectMake(0, 64, _infoView.width, _infoView.height);
        
    }
    _infoView.infoLabel.text = info;
    _infoView.type = type;
    _infoView.hidden = NO;
    
    [self addScaleAnimation];
}


- (void)addScaleAnimation
{
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    keyFrameAnimation.duration = 1.2;
    keyFrameAnimation.keyTimes = @[@0, @(0.3 / 1.2), @(0.9 / 1.2), @(1.2 / 1.2)];
    keyFrameAnimation.values   = @[@0, @1, @1, @0];
    keyFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [_infoView.layer addAnimation:keyFrameAnimation forKey:@"scale"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_infoView.layer removeAllAnimations];
        _infoView.hidden = YES;
    });
}

// 检测是否包含输入框InputView
- (BOOL)isClass:(Class)aClass containTheAttribute:(NSString *)attrName
{
    // 获取某类所有属性列表
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(aClass, &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        // T@"NSArray",&,N,V_itemsArr
        NSString *propertyAttrStr =
        [NSString stringWithUTF8String:property_getAttributes(property)];
        
        if ([propertyAttrStr containsString:@"@\""]) {
            NSString *classStr = [propertyAttrStr componentsSeparatedByString:@"@\""][1];
            classStr           = [classStr componentsSeparatedByString:@"\""][0];
            if ([classStr isEqualToString:attrName]) {
                return YES;
            }
        }
        
    }
    
    return NO;
}

@end
