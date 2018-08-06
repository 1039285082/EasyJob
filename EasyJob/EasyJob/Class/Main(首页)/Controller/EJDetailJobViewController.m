
//
//  EJDetailJobViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJDetailJobViewController.h"
#import "EJDetailViewTableViewCell.h"
@interface EJDetailJobViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView  * tableView;
@end

@implementation EJDetailJobViewController
//隐藏底部tabbbar
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"工作详情";
    //设置tableview的属性
    CGFloat tableViewY = 64;
    CGFloat tableViewH = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - tableViewY;
    CGRect tableFrame = CGRectMake(0, tableViewY, kScreenWidth, tableViewH);
    self.tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 150;//估算高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
    [self headView];
    UINib *nib = [UINib nibWithNibName:@"EJDetailViewTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"EJDetailViewTableViewCell"];
    //添加投递简历按钮
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 44)];
    button.layer.cornerRadius=5.0;
    button.layer.masksToBounds=YES;
   
    [button setBackgroundColor:KBackgroundColor];
    if (_model.isSend==YES) {
        [button setTitle:@"已投递" forState:UIControlStateNormal];
        button.userInteractionEnabled=NO;//交互关闭
        button.alpha=0.4;//透明度
        
       
    }else{
         [button setTitle:@"投递简历" forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(didClickCommitResumeBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=10001;
    
    [view addSubview:button];
    
    
    
    [self.view addSubview:view];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  
    if (section==0) {
        return 4;
    }else if (section==1){
        return 1;
    }else{
        return 1;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[UITableViewCell new];
//    cell.textLabel.text=@"3";
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"薪资:";
            
            cell.textLabel.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, kScreenWidth-80, cell.contentView.frame.size.height)];
            label.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
            label.text=_model.price;
            [cell.contentView addSubview:label];
        }else if(indexPath.row==1){
            cell.textLabel.text=@"日期:";
            cell.textLabel.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, kScreenWidth-50, cell.contentView.frame.size.height)];
            label.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
            label.text=_model.date;
            [cell.contentView addSubview:label];
            
        }else if(indexPath.row==2){
            cell.textLabel.text=@"人数:";
            cell.textLabel.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, kScreenWidth-80, cell.contentView.frame.size.height)];
            label.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
            label.text=_model.nums;
            [cell.contentView addSubview:label];
            
        }else{
            cell.textLabel.text=@"其他:";
            cell.textLabel.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, kScreenWidth-80, cell.contentView.frame.size.height)];
            label.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
            label.text=_model.style;
            [cell.contentView addSubview:label];
        }
        
        
    }else if (indexPath.section==1) {
        cell.textLabel.text=@"地址:";
        cell.textLabel.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, kScreenWidth-80, cell.contentView.frame.size.height)];
        label.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        label.text=_model.address;
        [cell.contentView addSubview:label];
    }else{
        EJDetailViewTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"EJDetailViewTableViewCell"];
        
        cell.detailLabel.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        
        
        
//        UILabel *label=[[UILabel alloc]init];
//        label.font=[UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        cell.detailLabel.numberOfLines=0;
        cell.detailLabel.lineBreakMode=NSLineBreakByWordWrapping;
        cell.detailLabel.text=_model.detail;
        [cell.detailLabel sizeToFit];
//        [cell.contentView addSubview:label];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
       cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)headView{
    UILabel *lablel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    
    UILabel *titleLabel=[[UILabel alloc]init];
    
//    titleLabel.font=[UIFont ]
    titleLabel.text=_model.title;
    
    [lablel addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(lablel.mas_top);
        make.right.equalTo(lablel.mas_right);
        make.bottom.equalTo(lablel.mas_bottom);
    }];
    
    self.tableView.tableHeaderView=lablel;
    
}
-(void)didClickCommitResumeBtn:(UIButton *)button{
    if (button.tag==10001) {
        if (button.selected==NO) {
            button.selected=YES;
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        [button setTitle:@"已投递" forState:UIControlStateNormal];
            hud.label.text=@"投递成功";
            [hud hideAnimated:YES afterDelay:0.3];
          button.userInteractionEnabled=NO;//交互关闭
        button.alpha=0.4;//透明度

            NSString *jobpath=[[EJSingle sharedSingle]sandBoxJobArr];
            NSMutableArray *dataArr=[NSKeyedUnarchiver unarchiveObjectWithFile:jobpath];
            if (dataArr==nil) {
                dataArr = [NSMutableArray new];
            }
            
            for (int i=0; i<dataArr.count; i++) {
                if (i==self.index) {
                    self.model.isSend=YES;
                    [dataArr replaceObjectAtIndex:self.index withObject:self.model];
                }
            }
            
            [NSKeyedArchiver archiveRootObject:dataArr toFile:jobpath];
            
        }else{
            
        }
    }
    
}
@end
