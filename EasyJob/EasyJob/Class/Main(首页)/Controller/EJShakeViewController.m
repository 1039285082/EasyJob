//
//  EJShakeViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJShakeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

#import "EJShakeShakeView.h"
#import "EJJobModel.h"
@interface EJShakeViewController ()
@property (strong,nonatomic)UIImageView  * upImg;
//@property (strong,nonatomic)UIImageView  * downImg;
//模型数组
@property (strong,nonatomic) NSMutableArray * modelArr;

@property (strong,nonatomic)EJJobModel * model;
@end

@implementation EJShakeViewController
//隐藏底部tabbar
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    self.title=@"摇一摇";
    [self wr_setNavBarBackgroundAlpha:0];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image=[UIImage imageNamed:@"bj"];

    self.upImg=[[UIImageView alloc]init];
    self.upImg.image=[UIImage imageNamed:@"shake_shake"];
    self.upImg.backgroundColor=[UIColor whiteColor];
    
    [imageView addSubview:self.upImg];
    [self.upImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView.mas_centerX);
        make.centerY.equalTo(imageView.mas_centerY)
        ;
        make.height.equalTo(@100);
        make.width.equalTo(@100);
    }];
    self.upImg.layer.cornerRadius=50;
    self.upImg.layer.masksToBounds=YES;
    
    
//    self.upImg=[[UIImageView alloc]init];
//   self.upImg.image=[UIImage imageNamed:@"up"];
//    self.upImg.backgroundColor=[UIColor whiteColor];
//
//    [imageView addSubview:self.upImg];
//    [self.upImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(imageView.mas_centerX);
//        make.bottom.equalTo(imageView.mas_centerY).offset(0);
//        make.height.equalTo(@100);
//        make.width.equalTo(@100);
//    }];
//
//
//
//    self.downImg=[[UIImageView alloc]init];
//    self.downImg.image=[UIImage imageNamed:@"down"];
//    self.downImg.backgroundColor=[UIColor whiteColor];
//
//    [imageView addSubview:self.downImg];
//    [self.downImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(imageView.mas_centerX);
//        make.top.equalTo(imageView.mas_centerY).offset(0);
//        make.height.equalTo(@100);
//        make.width.equalTo(@100);
//    }];
//

    [self.view addSubview:imageView];
    //摇一摇功能
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];

    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}
#pragma mark - ShakeToEdit 摇动手机之后的回调方法

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake)
    {
        // your code
        NSLog(@"检测到摇动开始");
        NSString *jobpath=[[EJSingle sharedSingle]sandBoxJobArr];
        NSMutableArray *dataArr=[NSKeyedUnarchiver unarchiveObjectWithFile:jobpath];
        self.modelArr=dataArr;
        self.model=dataArr[arc4random()%dataArr.count];
        
        
   
    }
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动取消
    NSLog(@"摇动取消");
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动结束
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        // your code
        NSLog(@"摇动结束");
     
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果 需要#import <AudioToolbox/AudioToolbox.h>
        
        
//        [self addAnimations];
        
        EJShakeShakeView *view = [[NSBundle mainBundle] loadNibNamed:@"EJShakeShakeView" owner:self options:nil][0];
        [view.image sd_setImageWithURL:[NSURL URLWithString:self.model.image.url]];
        view.title.text=self.model.title;
        view.price.text=self.model.price;
        
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
            make.width.mas_equalTo(kScreenWidth-40);
            make.height.equalTo(@100);
        }];
        
        view.backgroundColor= [UIColor whiteColor];
        [self.view bringSubviewToFront:view];
        
    }
    
}
////添加动画效果
//- (void)addAnimations {
//
//    // 让imgup上下移动
//    CABasicAnimation *translation2 = [CABasicAnimation animationWithKeyPath:@"position"];
//    translation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    translation2.fromValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
//    translation2.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, kScreenHeight/2-75)];
//    translation2.duration = 0.5;
//    translation2.repeatCount = 1;
//    translation2.autoreverses = YES;
//
//    // 让imagdown上下移动
//    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
//    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
//    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, kScreenHeight/2+75)];
//    translation.duration = 0.5;
//    translation.repeatCount = 1;
//    translation.autoreverses = YES;
//
//    [self.downImg.layer addAnimation:translation forKey:@"translation"];
//    [self.upImg.layer addAnimation:translation2 forKey:@"translation2"];
//}
//
//

@end
