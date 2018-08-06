//
//  BaseTabViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseTabViewController.h"
#import "SuggestViewController.h"
#import "BWWMyViewController.h"
#import "MainViewController.h"
//#import "EJResumeViewController.h"
#import "EJBiographicalNotesViewController.h"
@interface BaseTabViewController ()

@end

@implementation BaseTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainViewController *mVC=[[MainViewController alloc]init];
    UINavigationController *nv1=[[UINavigationController alloc]initWithRootViewController:mVC];
    nv1.title=@"首页";
    
    SuggestViewController *sVC=[[SuggestViewController alloc]init];
    UINavigationController *nv2=[[UINavigationController alloc]initWithRootViewController:sVC];
      nv2.title=@"推荐";
    
    
    BWWMyViewController *myVC=[[BWWMyViewController alloc]init];
    UINavigationController * nv3 = [[UINavigationController alloc]initWithRootViewController:myVC];
      nv3.title=@"我的";
    
    EJBiographicalNotesViewController *rVC=[[EJBiographicalNotesViewController alloc]init];
    UINavigationController *nv4=[[UINavigationController alloc]initWithRootViewController:rVC];
    nv4.title=@"简历";
    
    nv1.tabBarItem.image=[[UIImage imageNamed:@"shouye"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    nv1.tabBarItem.selectedImage=[[UIImage imageNamed:@"shouye_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nv2.tabBarItem.image=[[UIImage imageNamed:@"tuijian"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    nv2.tabBarItem.selectedImage=[[UIImage imageNamed:@"tuijian_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nv3.tabBarItem.image=[[UIImage imageNamed:@"wode"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    nv3.tabBarItem.selectedImage=[[UIImage imageNamed:@"wode_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nv4.tabBarItem.image=[[UIImage imageNamed:@"jianli"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    nv4.tabBarItem.selectedImage=[[UIImage imageNamed:@"jianli_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers=@[nv1,nv2,nv4,nv3];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
