//
//  SettingViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SettingViewController.h"
//#import "CKAlertViewController.h"
//#import "CYloginRegisterViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * tableView;

@property (strong,nonatomic)UIButton * button;        //
@end

@implementation SettingViewController
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
    self.title=@"设置";
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _button=[[UIButton alloc]initWithFrame:CGRectMake(20, 100, kScreenWidth-40, 40)];
    
    _button.layer.cornerRadius=5.0;
    _button.layer.masksToBounds=YES;
    
    [_button addTarget:self action:@selector(logoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [button setTintColor:[UIColor redColor]];
    _button.backgroundColor=KBackgroundColor;
    [self.tableView addSubview:_button];
    [self.view addSubview:self.tableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
 
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=@"清除缓存";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.imageView.image=[UIImage imageNamed:@"dingdan_1.png"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
}


@end
