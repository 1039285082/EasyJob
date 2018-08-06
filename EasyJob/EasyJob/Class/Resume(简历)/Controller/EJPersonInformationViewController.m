//
//  EJPersonInformationViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//
//# define ALIGN_CENTER NSTextAlignmentCenter
#import "EJPersonInformationViewController.h"

@interface EJPersonInformationViewController ()

@end

@implementation EJPersonInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人信息";
    //返回按钮自定义
    
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"fanhui_icon"]];
    
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"fanhui_icon"]];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;

    UIBarButtonItem * analyseItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCommitBtn)];
    
    self.navigationItem.rightBarButtonItems=@[analyseItem];
    
    self.tableView.scrollEnabled =NO; //设置tableview 不能滚动
   self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,self.view.bounds.size.width,0.01f)];
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    
    tableViewGesture.cancelsTouchesInView = NO;
    
    [self.tableView addGestureRecognizer:tableViewGesture];
    
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.hidesBottomBarWhenPushed=YES;
        [self initializeForm];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    return self;
}
- (void)initializeForm {
    
    // 设置是否显示Cell之间分界线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置Section的高度
//    self.tableView.sectionHeaderHeight = 30;
    
    XLFormDescriptor * form;//form，一个表单只有一个
    XLFormSectionDescriptor * section;//section，一个表单可能有多个
    XLFormRowDescriptor * row; //row，每个section可能有多个row
    
    // Form
    form = [XLFormDescriptor formDescriptor];
    
    
    // First section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    // 普通文本
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"username" rowType:XLFormRowDescriptorTypeText title:@"姓名"];
    // 设置placeholder
    if ([EJSingle sharedSingle].resume.userName!=nil) {
        row.value=[EJSingle sharedSingle].resume.userName;
    }else{
       [row.cellConfig setObject:@"请输入用户名" forKey:@"textField.placeholder"];
    }
   
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:@(UITextFieldViewModeNever) forKey:@"textField.clearButtonMode"];
    // 设置文本颜色
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
     [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"sex" rowType:XLFormRowDescriptorTypeSelectorActionSheet];
  
    row.selectorOptions = @[@"男",@"女"];
    row.title = @"性别";
    if ([EJSingle sharedSingle].resume.userSex!=nil) {
        row.value=[EJSingle sharedSingle].resume.userSex;
    }else{
          row.noValueDisplayText = @"暂无";
    }
    [row.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
    [row.cellConfigForSelector setObject:[UIColor redColor] forKey:@"textLabel.textColor"];
    [row.cellConfigForSelector setObject:[UIColor greenColor] forKey:@"detailTextLabel.textColor"];
      [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"birthday" rowType:XLFormRowDescriptorTypeDate title:@"出生日期"];

      [row.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
    
    if ([EJSingle sharedSingle].resume.userBirthday!=nil) {
        row.value=[EJSingle sharedSingle].resume.userBirthday;
    }else{

      row.noValueDisplayText = @"请选择时间";
    }
      [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"worktime" rowType:XLFormRowDescriptorTypeDate title:@"参加工作时间"];
       [row.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];

    if ([EJSingle sharedSingle].resume.workTime!=nil) {
        row.value=[EJSingle sharedSingle].resume.workTime;
    }else{
        row.noValueDisplayText = @"请选择时间";
    }
    [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
     [section addFormRow:row];
//
    
    // 普通文本
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"usercity" rowType:XLFormRowDescriptorTypeText title:@"现居住城市"];
    // 设置placeholder
    // 设置placeholder
    if ([EJSingle sharedSingle].resume.nowCity!=nil) {
        row.value=[EJSingle sharedSingle].resume.nowCity;
    }else{
       [row.cellConfig setObject:@"请输入现居住城市" forKey:@"textField.placeholder"];
    }
    
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:@(UITextFieldViewModeNever) forKey:@"textField.clearButtonMode"];
    // 设置文本颜色
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
      [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    // 普通文本
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"birthplace" rowType:XLFormRowDescriptorTypeText title:@"户口所在地"];
    // 设置placeholder
    // 设置placeholder
    if ([EJSingle sharedSingle].resume.birthPlace!=nil) {
        row.value=[EJSingle sharedSingle].resume.birthPlace;
    }else{
       [row.cellConfig setObject:@"请输入户口所在地" forKey:@"textField.placeholder"];
    }
    
    
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:@(UITextFieldViewModeNever) forKey:@"textField.clearButtonMode"];
    // 设置文本颜色
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
      [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];

   
    self.form = form;
}

-(void)didSelectFormRow:(XLFormRowDescriptor *)formRow{

    
    [super didSelectFormRow:formRow];
    
}
//收起键盘
- (void)commentTableViewTouchInSide{
    
    [self.view endEditing:YES];
    
}
-(void)didClickCommitBtn{
    NSDictionary *values =  [self formValues];
    
    NSLog(@"%@", values);
    if ([values[@"username"] isEqual:[NSNull null]]||[values[@"sex"] isEqual:[NSNull null]]||[values[@"birthday"] isEqual:[NSNull null]]||[values[@"worktime"] isEqual:[NSNull null]]||[values[@"usercity"] isEqual:[NSNull null]]||[values[@"birthplace"] isEqual:[NSNull null]]) {
        NSLog(@"请填完信息");
    }else{
        
        NSString *path=[[EJSingle sharedSingle] sandBoxPath];
        EJResumeModel *resume=[[EJResumeModel alloc]init];
        
        resume=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (resume==nil) {
            resume=[EJResumeModel new];
        }
        //    resume.resumeName=_resumeNameTextFiled.text;
        resume.userName=values[@"username"];
        resume.userSex=values[@"sex"];
        resume.userBirthday=values[@"birthday"];
        resume.workTime=values[@"worktime"];
        resume.nowCity=values[@"usercity"];
        resume.birthPlace=values[@"birthplace"];
        [EJSingle sharedSingle].resume=resume;
        [NSKeyedArchiver archiveRootObject:resume toFile:path];
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}
@end
