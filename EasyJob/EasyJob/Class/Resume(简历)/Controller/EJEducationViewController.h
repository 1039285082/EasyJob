//
//  EJEducationViewController.h
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XLFormViewController.h"
#import "EJEducationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EJEducationViewController : XLFormViewController
@property (strong,nonatomic) EJEducationModel * model;
@property (assign,nonatomic) long  index;
@end

NS_ASSUME_NONNULL_END
