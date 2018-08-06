//
//  AboutUsViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation AboutUsViewController
//隐藏底部bottombar
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title=@"关于我们";
//    UIButton *button=[[UIButton alloc]init];
//    //    button.frame=CGRectMake(0, KScreenHeight-44, KScreenWidth, 44);
//    [button setTitle:@"返回" forState:UIControlStateNormal];
//    [button setBackgroundColor:KBackgroundColor];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    [self.view bringSubviewToFront:button];
//    
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.height.equalTo(@44);
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectUsClick:(id)sender {
//    NSString *str = [NSString stringWithFormat:@"www.baidu.com"];
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}

-(void)dissMiss{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
