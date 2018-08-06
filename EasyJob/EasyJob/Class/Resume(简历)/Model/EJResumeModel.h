//
//  EJResumeModel.h
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJResumeModel : NSObject<NSCoding>
/** =================================== 简历名称 =================================== */
/** 简历名称 */
@property (copy,nonatomic)NSString  * resumeName;      

/** =================================== 个人信息 =================================== */
/** 姓名 */
@property (copy,nonatomic)NSString  * userName;
/** 性别 */
@property (copy,nonatomic)NSString  * userSex;
/** 出生日期 */
@property (copy,nonatomic)NSDate  * userBirthday;
/** 参加工作时间 */
@property (copy,nonatomic)NSDate  * workTime;
/** 现居住城市 */
@property (copy,nonatomic)NSString  * nowCity;
/** 户口所在地 */
@property (copy,nonatomic)NSString  * birthPlace;

/** =================================== 求职意向 =================================== */
/** 工作性质 */
@property (copy,nonatomic)NSString  * workNature;
/** 工作地点 */
@property (copy,nonatomic)NSString  * workPlace;
/** 职位类别 */
@property (copy,nonatomic)NSDate  * jobCategory;
/** 行业类别 */
@property (copy,nonatomic)NSDate  * sectorGroup;
/** 期望薪资 */
@property (copy,nonatomic)NSString  * expectSalary;
/** 工作状态 */
@property (copy,nonatomic)NSString  * workingState;


/** =================================== 教育背景 =================================== */

@end
