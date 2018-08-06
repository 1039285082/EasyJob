//
//  EJJobImage.m
//  EasyJob
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJJobImage.h"

@implementation EJJobImage
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.url=[aDecoder decodeObjectForKey:@"url"];
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
     [aCoder encodeObject:self.url forKey:@"url"];
}
@end
