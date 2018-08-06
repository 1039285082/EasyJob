//
//  AppDelegate.m
//  EasyJob
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AppDelegate.h"
//#import ""
#import "BaseTabViewController.h"
#import "SplashViewController.h"
#import <UMCommon/UMCommon.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //从数据库里取值
    NSString *path=[[EJSingle sharedSingle] sandBoxPath];
    EJResumeModel *resume=[[EJResumeModel alloc]init];
    
    resume=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (resume==nil) {
        resume=[EJResumeModel new];
    }
    [EJSingle sharedSingle].resume=resume;
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    SplashViewController *BVC=[[SplashViewController alloc]init];
    self.window.rootViewController=BVC;
    [UMConfigure initWithAppkey:@"5b5acf8ca40fa349860000de" channel:@"App Store"];
    [self.window makeKeyAndVisible];
    
     [self setNavBarAppearence];
    
    return YES;
    
}
-(void)setNavBarAppearence{
    [WRNavigationBar wr_widely];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:KBackgroundColor];
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}




@end
