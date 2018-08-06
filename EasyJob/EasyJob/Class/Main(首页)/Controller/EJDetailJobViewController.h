//
//  EJDetailJobViewController.h
//  EasyJob
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EJJobModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EJDetailJobViewController : UIViewController
@property (strong,nonatomic)EJJobModel * model;
@property (assign,nonatomic) long  index;
@end

NS_ASSUME_NONNULL_END
