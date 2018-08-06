//
//  EJJobModel.m
//  EasyJob
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJJobModel.h"

@implementation EJJobModel
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.title=[aDecoder decodeObjectForKey:@"title"];
    self.price=[aDecoder decodeObjectForKey:@"price"];
    self.style=[aDecoder decodeObjectForKey:@"style"];
    self.date=[aDecoder decodeObjectForKey:@"date"];
    self.nums=[aDecoder decodeObjectForKey:@"nums"];
    self.address=[aDecoder decodeObjectForKey:@"address"];
    self.detail=[aDecoder decodeObjectForKey:@"detail"];
    self.image=[aDecoder decodeObjectForKey:@"image"];
    self.isSend=[aDecoder decodeBoolForKey:@"isSend"];


    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.style forKey:@"style"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.nums forKey:@"nums"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.detail forKey:@"detail"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeBool:self.isSend forKey:@"isSend"];


    
}
@end
