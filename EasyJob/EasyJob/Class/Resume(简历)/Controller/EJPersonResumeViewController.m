//
//  EJPersonResumeViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJPersonResumeViewController.h"

@interface EJPersonResumeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UITableView * tableView;
@property (strong,nonatomic)UITextField * resumeNameTextFiled;
@end

@implementation EJPersonResumeViewController
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
    // Do any additional setup after loading the view.
    
    self.title = @"简历名称";
    
  
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];
}
-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem * analyseItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCommitBtn)];
    
    self.navigationItem.rightBarButtonItems=@[analyseItem];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
//    cell.textLabel.text=@"简历名称";
    _resumeNameTextFiled=[[UITextField alloc]init];
  
    if ([EJSingle sharedSingle].resume.resumeName.length>0) {
        _resumeNameTextFiled.text=[EJSingle sharedSingle].resume.resumeName;
    }else{
          _resumeNameTextFiled.placeholder=@"请输入简历名称";
        NSLog(@"%@",[EJSingle sharedSingle].resume.resumeName);
    }
    
    [cell.contentView addSubview:_resumeNameTextFiled];
    [_resumeNameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(20);
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.right.equalTo(cell.contentView.mas_right);
        make.height.equalTo(@40);
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)didClickCommitBtn{
    NSString *path=[[EJSingle sharedSingle] sandBoxPath];
    EJResumeModel *resume=[[EJResumeModel alloc]init];

    resume=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (resume==nil) {
        resume=[EJResumeModel new];
    }
    resume.resumeName=_resumeNameTextFiled.text;
    [EJSingle sharedSingle].resume=resume;
    [NSKeyedArchiver archiveRootObject:resume toFile:path];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
