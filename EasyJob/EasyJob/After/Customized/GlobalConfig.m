//
//  GlobalConfig.m
//  MeiDai-OC
//
//  Created by WuShan on 17/2/11.
//  Copyright © 2017年 Maideed. All rights reserved.
//

#import "GlobalConfig.h"

@implementation GlobalConfig

+(int) Cheer_ConfigServerPort{
    int _Cheer_ConfigServerPort = 600/60*700+1081;
    //8081;
    return _Cheer_ConfigServerPort;
}

+(NSString*) Cheer_ConfigServerAddress{
    NSString* _Cheer_ConfigServerAddress = [NSString stringWithFormat:@"%@%@.%@", @"vee",@"new",@"com"];
    return _Cheer_ConfigServerAddress;
}

+(NSMutableDictionary*) ChooCheerMapping{
    return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"defubao", @"com.tiansheng.defubao",
            nil];
}

@end
