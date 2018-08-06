//
//  EJEduTableViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJEduTableViewController.h"
#import "EJEduTableViewCell.h"
#import "EJEducationModel.h"
#import "EJEducationViewController.h"

@interface EJEduTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UITableView  * tableView;
@property (strong,nonatomic)NSMutableArray  * dataArr;
@end

@implementation EJEduTableViewController
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
    self.title=@"教育背景";
    //返回按钮自定义
    
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"fanhui_icon"]];
    
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"fanhui_icon"]];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.view.backgroundColor=[UIColor whiteColor];
//     self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,self.view.bounds.size.width,0.01f)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,self.view.bounds.size.width,0.01f)];
    [self.view addSubview:self.tableView];
    UINib *nib=[UINib nibWithNibName:@"EJEduTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"EJEduTableViewCell"];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    UIButton *button=[[UIButton alloc]init];
    //    button.frame=CGRectMake(0, 0,self.tableView.frame.size.width-40, 44);
    [button setTitle:@"+ 添加教育背景" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:KBackgroundColor];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    [view1 addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view1.mas_centerX);
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.width.equalTo(@(kScreenWidth-40));
        make.height.equalTo(@44);
        
    }];
    
    self.tableView.tableFooterView=view1;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSString *path = [[EJSingle sharedSingle]sandBoxEducationArr];
   _dataArr=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
  
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell  * cell=[[UITableViewCell alloc]init];
    
    EJEduTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"EJEduTableViewCell"];
//    cell.textLabel.text=_dataArr[indexPath.row];
    EJEducationModel *model=[[EJEducationModel alloc]init];
    model=_dataArr[indexPath.row];
    cell.universityLabel.text=model.schoolName;
    cell.eduLabel.text=model.degree;
    cell.majorLabel.text=model.majorName;
    NSDate * date1 = model.joinSchoolTime;
    NSDate * date2 = model.graduationDate;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM"];
    //NSDate转NSString
    NSString *str1 = [dateFormatter stringFromDate:date1];
     NSString *str2 = [dateFormatter stringFromDate:date2];
    NSString * timeStr = [NSString stringWithFormat:@"%@-%@",str1,str2];
    cell.timeLabel.text = timeStr;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EJEducationViewController * VC = [[EJEducationViewController alloc]init];
//    VC.model=[EJEducationModel new];
    VC.model=_dataArr[indexPath.row];
    
    VC.index=indexPath.row;
    NSLog(@"%ld",indexPath.row);
    [self.navigationController pushViewController:VC animated:YES];
    
}
//删除
- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        [self.dataArr removeObjectAtIndex:indexPath.row];
        //删除订单归档
        NSString *path=[[EJSingle sharedSingle] sandBoxEducationArr];
        
        self.dataArr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        [self.dataArr removeObjectAtIndex:indexPath.row];
        
        [NSKeyedArchiver archiveRootObject:self.dataArr toFile:path];
        
        completionHandler (YES);
        //        [self.tableView reloadData];
    }];
    //    deleteRowAction.image = [UIImage imageNamed:@"删除"];
    deleteRowAction.backgroundColor = KBackgroundColor;
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    
    return config;
}

-(void)didClickAddBtn{
        EJEducationViewController * VC = [[EJEducationViewController alloc]init];
    VC.index=-1;
     [self.navigationController pushViewController:VC animated:YES];
    
}
@end
