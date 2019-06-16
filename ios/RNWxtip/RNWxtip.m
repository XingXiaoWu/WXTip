
#import "RNWxtip.h"
#import "MBProgressHUD.h"
#import "ZHBPopTipView.h"

@interface RNWxtip()

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIImageView *loadingImageView;

@end


@implementation RNWxtip

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE(wxtip)

#pragma mark -- loading
//普通loading
RCT_EXPORT_METHOD(showLoading){
    dispatch_async(dispatch_get_main_queue(), ^{
         UIWindow *window = [UIApplication sharedApplication].delegate.window;
        //        非移除状态init
        if(self.hud){
            [self.hud hideAnimated:YES];
        }
        self.hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        //        loading背景透明
        self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        self.hud.bezelView.color = [UIColor clearColor];
        //        整个背景蒙版
        self.hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        self.hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    });
}
//
RCT_EXPORT_METHOD(dismissLoading){
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
    });
}

#pragma mark -- Toast展示
RCT_EXPORT_METHOD(showToast:(NSString*)message){
    dispatch_async(dispatch_get_main_queue(), ^{
        [ZHBPopTipView showText:message position:ZHBPopTipViewPositionCenter duration:2];
    });
}

#pragma mark -- 带图片的Loading
RCT_EXPORT_METHOD(showLoadingWithImage){
    dispatch_async(dispatch_get_main_queue(), ^{
         UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (!self.loadingImageView) {
            NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"WxtipBundle" ofType:@"bundle"]];
            // 找到对应images夹下的图片
            NSString *loadingImagePath = [bundle pathForResource:@"loading" ofType:@"png"];
            UIImage *loadingImage = [UIImage imageWithContentsOfFile:loadingImagePath];
            self.loadingImageView = [[UIImageView alloc] initWithImage:loadingImage];
        }
        //        非移除状态init
        if(self.hud){
            [self.hud hideAnimated:YES];
        }
        self.hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
//        loading背景透明
        self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        self.hud.bezelView.color = [UIColor clearColor];
//        整个背景蒙版
        self.hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        self.hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
        
        self.hud.customView = self.loadingImageView;
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
        animation.duration  = 1;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [self.loadingImageView.layer addAnimation:animation forKey:nil];
//         再设置模式
        self.hud.mode = MBProgressHUDModeCustomView;
        
//         隐藏时候从父控件中移除
        self.hud.removeFromSuperViewOnHide = YES;
        
        // 1秒之后再消失
//        [hud hide:YES afterDelay:0.7];

    });
}

@end

