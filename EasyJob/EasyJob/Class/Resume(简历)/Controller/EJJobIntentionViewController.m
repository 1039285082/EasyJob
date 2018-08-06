//
//  EJJobIntentionViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJJobIntentionViewController.h"

@interface EJJobIntentionViewController ()

@end

@implementation EJJobIntentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"求职意向";
    // Do any additional setup after loading the view.
    
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
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"worknature" rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"工作性质"];
     row.selectorOptions = @[@"全职",@"实习",@"兼职"];
    if ([EJSingle sharedSingle].resume.workNature!=nil) {
        row.value = [EJSingle sharedSingle].resume.workNature;
    }else{
        row.noValueDisplayText = @"请选择";
    }
     [row.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
      [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    
    // 普通文本
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"workplace" rowType:XLFormRowDescriptorTypeText title:@"工作地点"];
    // 设置placeholder
    if ([EJSingle sharedSingle].resume.workPlace!=nil) {
        row.value=[EJSingle sharedSingle].resume.workPlace;
    }else{
        [row.cellConfig setObject:@"请输入工作地点" forKey:@"textField.placeholder"];
    }
    
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:@(UITextFieldViewModeNever) forKey:@"textField.clearButtonMode"];
    // 设置文本颜色
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
      [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    // 普通文本
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"jobcategory" rowType:XLFormRowDescriptorTypeText title:@"职位类别"];
    // 设置placeholder
    if ([EJSingle sharedSingle].resume.jobCategory!=nil) {
        row.value=[EJSingle sharedSingle].resume.jobCategory;
    }else{
        [row.cellConfig setObject:@"请输入职位类型" forKey:@"textField.placeholder"];
    }
    
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:@(UITextFieldViewModeNever) forKey:@"textField.clearButtonMode"];
    // 设置文本颜色
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
      [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    // 普通文本
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"sectorgroup" rowType:XLFormRowDescriptorTypeText title:@"行业类别"];
    // 设置placeholder
    if ([EJSingle sharedSingle].resume.sectorGroup!=nil) {
        row.value=[EJSingle sharedSingle].resume.sectorGroup;
    }else{
        [row.cellConfig setObject:@"请输入行业类型" forKey:@"textField.placeholder"];
    }
    
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:@(UITextFieldViewModeNever) forKey:@"textField.clearButtonMode"];
    // 设置文本颜色
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
      [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    // 选择器
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"expectsalary" rowType:XLFormRowDescriptorTypeSelectorPush];
    
    if ([EJSingle sharedSingle].resume.expectSalary!=nil) {
                row.value=[EJSingle sharedSingle].resume.expectSalary;
            }else{
                 row.noValueDisplayText = @"请选择期望薪资";
            }
    row.selectorTitle = @"期望薪资";
    row.selectorOptions = @[@"1000元/月以下",@"1000-2000元/月",@"2001-4000元/月",@"4001-6000元/月",@"6001-8000元/月",@"8001-10000元/月",@"10001-15000元/月",@"15000-25000元/月",@"250001-35000元/月",@"35001-50000元/月",@"50001-70000元/月",@"70001-100000元/月",@"100000元/月以上",@"面议"];
    row.title = @"期望薪资";
    [row.cellConfigForSelector setObject:[UIColor blackColor] forKey:@"textLabel.textColor"];
    [row.cellConfigForSelector setObject:[UIColor greenColor] forKey:@"detailTextLabel.textColor"];
      [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"workingstate" rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"工作状态"];
    row.selectorOptions = @[@"已离职,可立即上岗",@"在职,正考虑换个新环境",@"在职,暂无跳槽打算",@"在职,考虑更好机会",@"应届毕业生"];
    if ([EJSingle sharedSingle].resume.workingState!=nil) {
        row.value = [EJSingle sharedSingle].resume.workingState;
    }else{
        row.noValueDisplayText = @"请选择";
    }
    [row.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
    [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    
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
    if ([values[@"worknature"] isEqual:[NSNull null]]||[values[@"workplace"] isEqual:[NSNull null]]||[values[@"jobcategory"] isEqual:[NSNull null]]||[values[@"sectorgroup"] isEqual:[NSNull null]]||[values[@"expectsalary"] isEqual:[NSNull null]]||[values[@"workingstate"] isEqual:[NSNull null]]) {
        NSLog(@"请填完信息");
    }else{
        
        NSString *path=[[EJSingle sharedSingle] sandBoxPath];
        EJResumeModel *resume=[[EJResumeModel alloc]init];
        
        resume=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (resume==nil) {
            resume=[EJResumeModel new];
        }
        //    resume.resumeName=_resumeNameTextFiled.text;
        resume.workNature=values[@"worknature"];
        resume.workPlace=values[@"workplace"];
        resume.jobCategory=values[@"jobcategory"];
        resume.sectorGroup=values[@"sectorgroup"];
        resume.expectSalary=values[@"expectsalary"];
        resume.workingState=values[@"workingstate"];
        [EJSingle sharedSingle].resume=resume;
        [NSKeyedArchiver archiveRootObject:resume toFile:path];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
