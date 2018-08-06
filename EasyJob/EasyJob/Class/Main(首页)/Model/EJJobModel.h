//
//  EJJobModel.h
//  EasyJob
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EJJobImage.h"
NS_ASSUME_NONNULL_BEGIN

@interface EJJobModel : NSObject<NSCoding>
//标题
@property (strong,nonatomic)NSString * title;
//工资
@property (strong,nonatomic)NSString * price;
//长期/短期
@property (strong,nonatomic)NSString * style;
//日期
@property (strong,nonatomic)NSString * date;
//人数
@property (strong,nonatomic)NSString * nums;
//地址
@property (strong,nonatomic)NSString * address;

//工作内容
@property (strong,nonatomic)NSString * detail;      

//照片模型
@property (strong,nonatomic)EJJobImage * image;

//是否投递简历
@property (assign,nonatomic) BOOL  isSend;
@end

NS_ASSUME_NONNULL_END
