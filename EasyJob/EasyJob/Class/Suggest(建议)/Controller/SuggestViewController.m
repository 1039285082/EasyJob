//
//  SuggestViewController.m
//  EasyJob
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SuggestViewController.h"
#import "EJCollectionViewCell.h"
#import "EJJobModel.h"
#import "EJDetailJobViewController.h"
@interface SuggestViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic)UICollectionView * collectionView;

//模型数组
@property (strong,nonatomic) NSMutableArray * modelArr;


@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"推荐";
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
    self.modelArr=[NSMutableArray new];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"jobs.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *arr=dic[@"results"];
    
    for (int i=0; i<arr.count; i++) {
        EJJobModel *model=[EJJobModel mj_objectWithKeyValues:arr[i]];
        [_modelArr addObject:model];
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


@end
