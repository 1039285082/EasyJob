//
//  EJEducationViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJEducationViewController.h"

@interface EJEducationViewController ()

@end

@implementation EJEducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"教育背景";
    // Do any additional setup after loading the view.
   
    UIBarButtonItem * analyseItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCommitBtn)];
    
    self.navigationItem.rightBarButtonItems=@[analyseItem];
    
    self.tableView.scrollEnabled =NO; //设置tableview 不能滚动
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,self.view.bounds.size.width,0.01f)];
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    
    tableViewGesture.cancelsTouchesInView = NO;
    
    [self.tableView addGestureRecognizer:tableViewGesture];
     [self initializeForm];
}

- (void)initializeForm {
    
    // 设置是否显示Cell之间分界线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置Section的高度
    //    self.tableView.sectionHeaderHeight = 30;
    
    NSLog(@"%@",self.model);
    XLFormDescriptor * form;//form，一个表单只有一个
    XLFormSectionDescriptor * section;//section，一个表单可能有多个
    XLFormRowDescriptor * row; //row，每个section可能有多个row
    
    // Form
    form = [XLFormDescriptor formDescriptor];
    
    
    // First section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"schoolname" rowType:XLFormRowDescriptorTypeText title:@"学校名称"];
    if (_model.schoolName!=nil) {
        row.value=_model.schoolName;
    }else{
        [row.cellConfig setObject:@"请输入学校名称" forKey:@"textField.placeholder"];
    }
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"degree" rowType:XLFormRowDescriptorTypeSelectorActionSheet];

    if (_model.degree!=nil) {
        row.value=_model.degree;
    }else{
    row.noValueDisplayText = @"请选择学历/学位";
    }

    row.selectorTitle = @"学历/学位";
    row.selectorOptions = @[@"初中",@"中技",@"高中",@"中专",@"大专",@"本科",@"硕士",@"MBA",@"EMBA",@"博士",@"其他"];
    row.title = @"学历/学位";
    [row.cellConfigForSelector setObject:[UIColor blackColor] forKey:@"textLabel.textColor"];
    [row.cellConfigForSelector setObject:[UIColor greenColor] forKey:@"detailTextLabel.textColor"];
    [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
//
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"joinSchoolTime" rowType:XLFormRowDescriptorTypeDate title:@"入学时间"];
    
    [row.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
    
    if (_model.joinSchoolTime!=nil) {
        row.value=_model.joinSchoolTime;
    }else{
        
        row.noValueDisplayText = @"请选择时间";
    }
    [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"graduationDate" rowType:XLFormRowDescriptorTypeDate title:@"毕业时间"];
    
    [row.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
    
    if (_model.graduationDate!=nil) {
        row.value=_model.graduationDate;
    }else{
        
        row.noValueDisplayText = @"请选择时间";
    }
    [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
    [section addFormRow:row];
    
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"majorName" rowType:XLFormRowDescriptorTypeText title:@"专业名称"];

    if (_model.majorName!=nil) {
        row.value=_model.majorName;
    }else{
        
         [row.cellConfig setObject:@"请输入专业名称" forKey:@"textField.placeholder"];
    }
   
    //    [row.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:@(UITableViewCellSelectionStyleNone) forKey:@"selectionStyle"];
     [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
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
    if ([values[@"degree"] isEqual:[NSNull null]]||[values[@"graduationDate"] isEqual:[NSNull null]]||[values[@"joinSchoolTime"] isEqual:[NSNull null]]||[values[@"majorName"] isEqual:[NSNull null]]||[values[@"schoolname"] isEqual:[NSNull null]]) {
        NSLog(@"请填完信息");
    }else{
        NSString *path = [[EJSingle sharedSingle]sandBoxEducationArr];
        NSMutableArray *dataArr=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (dataArr==nil) {
            dataArr = [NSMutableArray new];
        }
        EJEducationModel *model=[EJEducationModel new];
        
        model.schoolName=values[@"schoolname"];
         model.degree=values[@"degree"];
        model.joinSchoolTime=values[@"joinSchoolTime"];
        model.graduationDate=values[@"graduationDate"];
        model.majorName=values[@"majorName"];
        if (dataArr.count>0) {
            if (self.index>=0) {
                
                
                [dataArr replaceObjectAtIndex:self.index withObject:model];
                [NSKeyedArchiver archiveRootObject:dataArr toFile:path];
                
                
            }else{
                
                
                [dataArr addObject:model];
                [NSKeyedArchiver archiveRootObject:dataArr toFile:path];
            }
            
        }else{
            [dataArr addObject:model];
            [NSKeyedArchiver archiveRootObject:dataArr toFile:path];
        }
      
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
