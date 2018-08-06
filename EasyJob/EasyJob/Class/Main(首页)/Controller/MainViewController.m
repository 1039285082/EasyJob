//
//  MainViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainViewController.h"
#import "EJCollectionViewCell.h"
#import "EJCollectionReusableView.h"
#import "EJJobModel.h"
#import "EJDetailJobViewController.h"
#import "EJNewViewController.h"
#import "EJNearbyViewController.h"
#import "EJShakeViewController.h"
@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic)UICollectionView * collectionView;

//模型数组
@property (strong,nonatomic) NSMutableArray * modelArr;

@end

@implementation MainViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    CGFloat tableViewY = 64;
    CGFloat tableViewH = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - tableViewY;
    CGRect tableFrame = CGRectMake(0, tableViewY, kScreenWidth, tableViewH);
    
    _collectionView=[[UICollectionView alloc]initWithFrame:tableFrame collectionViewLayout:layout];

    
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [self.view addSubview:self.collectionView];
    
     UINib *nib1=[UINib nibWithNibName:@"EJCollectionViewCell" bundle:nil];
    UINib *nib2=[UINib nibWithNibName:@"EJCollectionReusableView" bundle:nil];
    
     [self.collectionView registerNib:nib1 forCellWithReuseIdentifier:@"EJCollectionViewCell"];
     [self.collectionView registerNib:nib2 forCellWithReuseIdentifier:@"EJCollectionReusableView"];
     [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EJCollectionReusableView"];
    // 下拉刷新
    
    self.collectionView.mj_header= [MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        
    // 增加数据
        
    [self.collectionView.mj_header  beginRefreshing];
        
//    self.collectionView.mj_header 
  
    
    [self.collectionView.mj_header   endRefreshing];
        
        
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
//    self.modelArr=[NSMutableArray new];
//    NSString *path=[[NSBundle mainBundle]pathForResource:@"jobs.json" ofType:nil];
//    NSData *data=[NSData dataWithContentsOfFile:path];
//
//    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//
//    NSArray *arr=dic[@"results"];
//
//    for (int i=0; i<arr.count; i++) {
//        EJJobModel *model=[EJJobModel mj_objectWithKeyValues:arr[i]];
//        [_modelArr addObject:model];
//    }
//    NSString *jobpath=[[EJSingle sharedSingle]sandBoxJobArr];
//
//    NSMutableArray *dataArr=[NSKeyedUnarchiver unarchiveObjectWithFile:jobpath];
//    if (dataArr==nil) {
//        dataArr = [NSMutableArray new];
//    }
//    dataArr=_modelArr;
//    [NSKeyedArchiver archiveRootObject:dataArr toFile:jobpath];
     NSString *jobpath=[[EJSingle sharedSingle]sandBoxJobArr];
    NSMutableArray *dataArr=[NSKeyedUnarchiver unarchiveObjectWithFile:jobpath];
    if (dataArr==nil) {
                dataArr = [NSMutableArray new];
            NSString *path=[[NSBundle mainBundle]pathForResource:@"jobs.json" ofType:nil];
            NSData *data=[NSData dataWithContentsOfFile:path];
        
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
            NSArray *arr=dic[@"results"];
        
            for (int i=0; i<arr.count; i++) {
                EJJobModel *model=[EJJobModel mj_objectWithKeyValues:arr[i]];
                [dataArr addObject:model];
            }
         self.modelArr=dataArr;
        [NSKeyedArchiver archiveRootObject:dataArr toFile:jobpath];
    }else{
        self.modelArr=dataArr;
    }
    
}
#pragma mark - collectionView代理方法
- ( UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    long index=indexPath.row;
    
    EJCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"EJCollectionViewCell" forIndexPath:indexPath];
    EJJobModel * model = [EJJobModel new];
    model = _modelArr[indexPath.row];
    
    cell.salaryLabel.text=model.price;
    
//    cell.salaryLabel.text=@"300/天";
//    cell.titleLabel.text=model.title;
    cell.titleLabel.font=[UIFont systemFontOfSize:14];
    cell.titleLabel.numberOfLines=0;
//    cell.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell.titleLabel.lineBreakMode = NSLineBreakByClipping;
    cell.titleLabel.text = [model.title stringByAppendingString:@"\n\n\n\n"];
    
    cell.timeLabel.text=model.style;
    //添加约束
    [cell.imageVIew  sd_setImageWithURL:[NSURL URLWithString:model.image.url]];
    
    [cell.imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView.mas_top);
        make.height.mas_equalTo(kScreenWidth/2);
        make.left.equalTo(cell.contentView.mas_left);
        make.right.equalTo(cell.contentView.mas_right);
    }];
    [cell.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.imageVIew.mas_bottom);
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.equalTo(@50);
        make.left.equalTo(cell.contentView.mas_left).offset(5);
    }];
    [cell.salaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.titleLabel.mas_bottom);
        make.width.equalTo(@100);
        make.left.equalTo(cell.contentView.mas_left).offset(5);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        
    }];
    
    cell.timeLabel.textAlignment=NSTextAlignmentRight;
    [cell.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.salaryLabel.mas_top);
        make.width.equalTo(@100);
        make.right.equalTo(cell.contentView.mas_right).offset(-5);
        make.bottom.equalTo(cell.contentView.mas_bottom);
    }];
    
    return cell;
    
    
    
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _modelArr.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EJDetailJobViewController *VC=[[EJDetailJobViewController alloc]init];
    EJJobModel * model = [EJJobModel new];
    model = _modelArr[indexPath.row];
    VC.model=model;
    long index = indexPath.row;
    
    VC.index=index;
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
}
#pragma mark - collection的flowlayout方法 设置cell大小和间距
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth/2-1, 300);
    
    
}
//两行cell之间间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
    
    
}

//两个cell之间间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
//collection头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, kScreenHeight/2-80);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    EJCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EJCollectionReusableView" forIndexPath:indexPath];
    
    SDCycleScrollView*cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height-120) imageNamesGroup:@[@"banner_1",@"banner_2"]];
    
    [headView addSubview:cycleScrollView];
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height-120, headView.frame.size.width, 120)];
    /**--------------------------------view布局--------------------------------*/
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, 50, 50)];
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-40-150)/2+50, 10, 50, 50)];
    UIButton *btn3=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-20-50, 10, 50, 50)];

    [btn1 setImage:[UIImage imageNamed:@"zuixin"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"fujin"] forState:UIControlStateNormal];
        [btn3 setImage:[UIImage imageNamed:@"yaoyiyao"] forState:UIControlStateNormal];
    [btn2 setTitle:@"附近" forState:UIControlStateNormal];
    [btn3 setTitle:@"摇一摇" forState:UIControlStateNormal];
    
    btn1.layer.cornerRadius=25;
    btn1.layer.masksToBounds=YES;
    btn2.layer.cornerRadius=25;
    btn2.layer.masksToBounds=YES;
    btn3.layer.cornerRadius=25;
    btn3.layer.masksToBounds=YES;
    
    [btn1 addTarget:self action:@selector(didCLickNewBtn) forControlEvents:UIControlEventTouchUpInside];
  [btn2 addTarget:self action:@selector(didCLickNearbyBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(didClickShakeBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    [view addSubview:btn2];
    [view addSubview:btn3];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@20);
        make.top.mas_equalTo(@10);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.top.mas_equalTo(@10);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@-20);
        make.top.mas_equalTo(@10);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];
    
    UILabel *label1=[[UILabel alloc]init];
    UILabel *label2=[[UILabel alloc]init];
    UILabel *label3=[[UILabel alloc]init];
    label1.text=@"最新";
    label1.font=[UIFont systemFontOfSize:14];
    label1.textAlignment=NSTextAlignmentCenter;
    label2.text=@"附近";
    label2.font=[UIFont systemFontOfSize:14];
    label2.textAlignment=NSTextAlignmentCenter;
    label3.text=@"摇一摇";
    label3.font=[UIFont systemFontOfSize:14];
    label3.textAlignment=NSTextAlignmentCenter;
    
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:label3];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(5);
        make.centerX.equalTo(btn1.mas_centerX);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@50);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2.mas_bottom).offset(5);
        make.centerX.equalTo(btn2.mas_centerX);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@50);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn3.mas_bottom).offset(5);
        make.centerX.equalTo(btn3.mas_centerX);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@50);
    }];
    UILabel *lineLabel=[[UILabel alloc]init];
    [view addSubview:lineLabel];
    lineLabel.backgroundColor=[UIColor lightGrayColor];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.equalTo(view.mas_left);
        make.right.equalTo(view.mas_right);
        make.top.equalTo(label1.mas_bottom);
    }];
    UILabel * recommendLabel=[[UILabel alloc]init];
    recommendLabel.text=@"推荐";
    [view addSubview:recommendLabel];
    [recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
           make.centerY.equalTo(view.mas_top).offset(100);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
    
    [headView addSubview:view];
    return headView;
}
-(void)didCLickNewBtn{
    EJNewViewController * VC1=[[EJNewViewController alloc]init];
    [self.navigationController pushViewController:VC1 animated:YES];
    
}
-(void)didCLickNearbyBtn{
    
    EJNearbyViewController * VC2=[[EJNearbyViewController alloc]init];
    [self.navigationController pushViewController:VC2 animated:YES];
}
-(void)didClickShakeBtn{
    EJShakeViewController *VC3=[[EJShakeViewController alloc]init];
    [self.navigationController pushViewController:VC3 animated:YES];
    
}
@end
