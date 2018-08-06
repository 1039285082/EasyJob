//
//  EJSingle.h
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EJResumeModel.h"
@interface EJSingle : NSObject
@property (strong,nonatomic)EJResumeModel  * resume;
@property (strong,nonatomic)NSMutableArray * eduArr;
@property (strong,nonatomic)NSMutableArray * jobArr;
+(EJSingle *)sharedSingle;
-(NSString*)sandBoxPath;
-(NSString*)sandBoxEducationArr;
-(NSString*)sandBoxJobArr;
@end
