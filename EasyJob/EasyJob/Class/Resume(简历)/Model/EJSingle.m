//
//  EJSingle.m
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJSingle.h"
static EJSingle*single=nil;
@implementation EJSingle
+(EJSingle *)sharedSingle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single=[[EJSingle alloc]init];
    });
    return single;
}
-(NSString *)sandBoxPath{
    
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"resume.plist"];
    return path;
}
-(NSString*)sandBoxEducationArr{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"arr.plist"];
    return path;
    
}
-(NSString*)sandBoxJobArr{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"jobarr.plist"];
    return path;
}
@end
