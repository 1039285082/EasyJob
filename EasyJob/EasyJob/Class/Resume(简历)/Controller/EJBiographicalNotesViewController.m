//
//  EJBiographicalNotesViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJBiographicalNotesViewController.h"
#import "HeaderView.h"
#import "EJPersonResumeViewController.h"
#import "EJPersonInformationViewController.h"
#import "EJJobIntentionViewController.h"
#import "EJEducationViewController.h"
#import "EJEduTableViewController.h"
@interface EJBiographicalNotesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView * tableView;
@property(nonatomic,strong)HeaderView *headerView;
@property (strong,nonatomic)NSArray * dataArr;
@end

@implementation EJBiographicalNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮自定义
    
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"fanhui_icon"]];
    
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"fanhui_icon"]];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    self.title=@"简历";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
   
    
    _dataArr=@[@"简历名称",@"个人信息",@"求职意向",@"教育背景"];
    [self.view addSubview:self.tableView];
  
    // 下拉刷新
    
    self.tableView.mj_header= [MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        
        // 增加数据
        
        [self.tableView.mj_header  beginRefreshing];
        
        //    self.collectionView.mj_header
        
        //网络请求
        
        NSLog(@"下拉刷新");
        
        [self.tableView.mj_header   endRefreshing];
        
        
        
    }];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}
-(void)viewWillAppear:(BOOL)animated{
    [self layoutHeadView];
//    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell  * cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=_dataArr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    long index=indexPath.row;
    if (index==0) {
        EJPersonResumeViewController *VC1 = [[EJPersonResumeViewController alloc]init];
        [self.navigationController pushViewController:VC1 animated:YES];
        
    }else if(index==1){
        EJPersonInformationViewController *VC2=[[EJPersonInformationViewController alloc]init];
        [self.navigationController pushViewController:VC2 animated:YES];
    }else if (index==2){
        EJJobIntentionViewController *VC3=[[EJJobIntentionViewController alloc]init];
        [self.navigationController pushViewController:VC3 animated:YES];
    }else{
        NSString *path=[[EJSingle sharedSingle] sandBoxEducationArr];
        NSMutableArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (arr.count==0) {
            EJEducationViewController *VC4=[[EJEducationViewController alloc]init];
            [self.navigationController pushViewController:VC4 animated:YES];
        }else{
            EJEduTableViewController *VC5=[[EJEduTableViewController alloc]init];
            [self.navigationController pushViewController:VC5 animated:YES];
        }
    }
    
}
//headview重新布局
-(void)layoutHeadView{
    
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
//    headView.backgroundColor=KBackgroundColor;
//
//    self.tableView.tableHeaderView=headView;
    _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)];
    if ([EJSingle sharedSingle].resume.userName!=nil) {
    _headerView.nameLabel.text = [EJSingle sharedSingle].resume.userName;
    }else{
       _headerView.nameLabel.text = @"请先完善简历";
    }
    _tableView.tableHeaderView = _headerView;
    
}
@end
