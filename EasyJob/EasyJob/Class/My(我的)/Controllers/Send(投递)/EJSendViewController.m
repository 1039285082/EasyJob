//
//  EJSendViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJSendViewController.h"
#import "EJJobModel.h"
#import "EJDetailJobViewController.h"
#import "EJSendTableViewCell.h"
#import "JKAlertDialog.h"

@interface EJSendViewController ()<UITableViewDelegate,UITableViewDataSource>
//模型数组
@property (strong,nonatomic) NSMutableArray * modelArr;
//下标数组
@property (strong,nonatomic)NSMutableArray * indexArr;

@property (strong,nonatomic)UITableView * tableView;
@property (assign,nonatomic) long  index;

@end

@implementation EJSendViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的投递";
    //设置tableview的属性
    CGFloat tableViewY = 64;
    CGFloat tableViewH = self.view.frame.size.height - tableViewY;
    CGRect tableFrame = CGRectMake(0, tableViewY, kScreenWidth, tableViewH);
    self.tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    UINib *nib=[UINib nibWithNibName:@"EJSendTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"EJSendTableViewCell"];
    // 下拉刷新
    
    self.tableView.mj_header= [MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        
        [self.tableView.mj_header  beginRefreshing];
        
        [self.tableView.mj_header   endRefreshing];
        
    }];
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];
//    self.tableView.estimatedRowHeight = 150;//估算高度
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *jobpath=[[EJSingle sharedSingle]sandBoxJobArr];
    NSMutableArray *dataArr=[NSKeyedUnarchiver unarchiveObjectWithFile:jobpath];
    self.modelArr=[NSMutableArray new];
       self.indexArr=[NSMutableArray new];
    for (int i=0; i<dataArr.count; i++) {
        EJJobModel *model=[EJJobModel new];
        model=dataArr[i];
        if (model.isSend==YES) {
            [self.modelArr addObject:model];
            [_indexArr addObject:@(i)];
            
        }
    }
    
   
    
}
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EJSendTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"EJSendTableViewCell"];
    EJJobModel * model = [EJJobModel new];
    
  
    
    model = _modelArr[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.image.url]];
    cell.titleLabel.text=model.title;
    cell.priceLabel.text=model.price;
    cell.dateLabel.text=model.date;
    [cell.cancelBtn addTarget:self action:@selector(didClickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    EJDetailJobViewController *VC=[[EJDetailJobViewController alloc]init];
    EJJobModel * model = [EJJobModel new];
    self.index=[_indexArr[indexPath.row] longValue];
    
    model = _modelArr[indexPath.row];
    
    VC.model=model;
    
    
    VC.index=self.index;
    
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)didClickCancelBtn:(UIButton *)sender{
      JKAlertDialog *alert = [[JKAlertDialog alloc]initWithTitle:@"是否确定取消申请?" message:@""];
    
     [alert addButton:Button_OTHER withTitle:@"确定" handler:^(JKAlertDialogItem *item) {
         
         UIView *contentView = [sender superview];
         
         
         EJSendTableViewCell *cell = (EJSendTableViewCell *)[contentView superview];
         NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
         long idx=indexPath.row;
           [self.modelArr removeObjectAtIndex:idx];
         //取消投递归档
         NSString *jobpath=[[EJSingle sharedSingle]sandBoxJobArr];
         NSMutableArray *dataArr=[NSKeyedUnarchiver unarchiveObjectWithFile:jobpath];
         long index=[self.indexArr[idx] longValue];
         EJJobModel *model=[EJJobModel new];
         model=dataArr[index];
         model.isSend=NO;
         [dataArr replaceObjectAtIndex:index withObject:model];
         [NSKeyedArchiver archiveRootObject:dataArr toFile:jobpath];
         [self.tableView reloadData];
         
            }];
    
     [alert addButton:Button_OTHER withTitle:@"取消" handler:^(JKAlertDialogItem *item) {
         
           }];
    
    [alert show];
    
}
@end
