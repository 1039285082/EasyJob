//
//  BWWMyViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BWWMyViewController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "BWWMyTableViewCell.h"
#import "EJSendViewController.h"
#import <StoreKit/StoreKit.h>


@interface BWWMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * tableView;        //
@property (strong,nonatomic)NSMutableArray * textLabelArr;        //
@property (strong,nonatomic)NSMutableArray * imageArr;        //        //

@property (strong,nonatomic)UILabel * accountLabel;
@end

@implementation BWWMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"我的";
    [self wr_setNavBarBackgroundAlpha:1];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tabBarController.tabBarItem.title=@"精品推荐";

        NSArray *type2=@[@"当前版本"];
    NSArray *type1=@[@"关于我们"];
    NSArray *type3=@[@"我的投递"];
    NSArray *type4=@[@"评分及鼓励"];
    
    _textLabelArr=[NSMutableArray new];
    
    [_textLabelArr addObject:type2];
    [_textLabelArr addObject:type3];
    [_textLabelArr addObject:type4];
    [_textLabelArr addObject:type1];
    NSArray* image1=@[@"xitongbanben"];

     NSArray* image2=@[@"tucao"];
    NSArray* image3=@[@"haoping"];
     NSArray* image4=@[@"shezhi"];
    _imageArr = [NSMutableArray new];
    [_imageArr addObject:image1];
    [_imageArr addObject:image2];
     [_imageArr addObject:image3];
    [_imageArr addObject:image4];

    
    
    

    _tableView.sectionHeaderHeight = 0.01;
    _tableView.sectionFooterHeight = 0.01;

    
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{

    
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _textLabelArr.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_textLabelArr[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    cell.selectionStyle=NO;
    
    
    long index=indexPath.row;
    cell.textLabel.text=_textLabelArr[indexPath.section][index];
    cell.imageView.image=[UIImage imageNamed:_imageArr[indexPath.section][index]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([cell.textLabel.text isEqualToString:@"当前版本"]) {
        cell.accessoryType=UITableViewCellAccessoryNone;
        
        UILabel *label1=[[UILabel alloc]init];
         NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        CFShow(infoDictionary);
         NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        label1.text=appCurVersion;
//        label1.font=[UIFont systemFontOfSize:14];
        label1.textAlignment=NSTextAlignmentCenter;
        
        NSLog(@"%@",appCurVersion);
        [cell.contentView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@50);
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.right.equalTo(cell.contentView.mas_right).offset(20);
        }];
    }
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self regestCenter:indexPath];
    
}
-(void)regestCenter:(NSIndexPath*)indexPath{
    long index=indexPath.row;
    if([_textLabelArr[indexPath.section][index] isEqualToString:@"评分及鼓励"]){
        NSString *appID=@"1418454088";
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appID];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
        
//        if (__IPHONE_10_3)
//            //一句话实现在App内直接评论了。然而需要注意的是：打开次数一年不能多于3次。（当然开发期间可以无限制弹出，方便测试）
//            [SKStoreReviewController requestReview];
//        else
        
//            [JDMessageView showMessage:@"版本不支持此方法"];
        
        
    }
    
 if ([_textLabelArr[indexPath.section][index] isEqualToString:@"其他"]){
        
        SettingViewController *vc=[[SettingViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        

        
    }

    if ([_textLabelArr[indexPath.section][index] isEqualToString:@"关于我们"]){
        AboutUsViewController *vc=[[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([_textLabelArr[indexPath.section][index] isEqualToString:@"我的投递"]){
        EJSendViewController *vc=[[EJSendViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
    
}

@end
