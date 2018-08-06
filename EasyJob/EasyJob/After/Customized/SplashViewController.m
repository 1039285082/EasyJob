//
//  SplashViewController.m
//  白卡回收
//
//  Created by WuShan on 2018/4/3.
//  Copyright © 2018年 Maideed. All rights reserved.
//

#import "SplashViewController.h"
#import "SessionData.h"
#import "ViewControllerAnchorSet.h"
#import "BaseTabViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setNavigationBarHidden:YES];
    
    [self setupMainViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) setupMainViewControllers {
    SessionData* session = [SessionData getInstance];
    if(session.config.isNewsMode) {
        BaseTabViewController *vc=[[BaseTabViewController alloc]init];
        [self setViewControllers:@[vc]];
    } else {
        AXWebViewController* axWebVc = [ViewControllerAnchorSet rootWebVcAfterLoad];
        [self setViewControllers:@[axWebVc]];
    }
}


@end
