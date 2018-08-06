//
//  EJNewViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJNewViewController.h"
#import "EJNewTableViewCell.h"
#import "EJJobModel.h"
#import "EJDetailJobViewController.h"
@interface EJNewViewController ()<UITableViewDelegate,UITableViewDataSource>
//模型数组
@property (strong,nonatomic) NSMutableArray * modelArr;

@property (strong,nonatomic)UITableView * tableView;

@property (strong,nonatomic)EJJobModel * model;
@end

@implementation EJNewViewController
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
    self.title=@"最新";
    //设置tableview的属性
    CGFloat tableViewY = 64;
    CGFloat tableViewH = self.view.frame.size.height - tableViewY;
    CGRect tableFrame = CGRectMake(0, tableViewY, kScreenWidth, tableViewH);
    self.tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    UINib *nib=[UINib nibWithNibName:@"EJNewTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"EJNewTableViewCell"];
    // 下拉刷新
    
    self.tableView.mj_header= [MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        
        [self.tableView.mj_header  beginRefreshing];
        
        [self.tableView.mj_header   endRefreshing];
        
    }];
     _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];

}

-(void)viewWillAppear:(BOOL)animated{
    NSString *jobpath=[[EJSingle sharedSingle]sandBoxJobArr];
    NSMutableArray *dataArr=[NSKeyedUnarchiver unarchiveObjectWithFile:jobpath];
    self.modelArr=dataArr;
    
}
#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EJNewTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"EJNewTableViewCell"];
    EJJobModel * model = [EJJobModel new];
    model = _modelArr[indexPath.row];
     [cell.img  sd_setImageWithURL:[NSURL URLWithString:model.image.url]];
    cell.titleLabel.text=model.title;
    cell.styleLabel.text=model.style;
    cell.addressLabel.text=model.address;
    cell.dateLabel.text=model.date;
    cell.priceLabel.text=model.price;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    EJDetailJobViewController *VC=[[EJDetailJobViewController alloc]init];
    EJJobModel * model = [EJJobModel new];
    model = _modelArr[indexPath.row];
    VC.model=model;
    long index = indexPath.row;
    
    VC.index=index;
    
    [self.navigationController pushViewController:VC animated:YES];
}

@end
