//
//  EJEducationModel.h
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EJEducationModel : NSObject<NSCoding>

/** 学校名称 */
@property (copy,nonatomic)NSString  * schoolName;
/** 学历/学位 */
@property (copy,nonatomic)NSString  * degree;
/** 入学时间 */
@property (copy,nonatomic)NSDate  * joinSchoolTime;
/** 毕业时间 */
@property (copy,nonatomic)NSDate  * graduationDate;
/** 专业名称 */
@property (copy,nonatomic)NSString  * majorName;


@end

NS_ASSUME_NONNULL_END
