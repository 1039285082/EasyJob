//
//  EJEducationModel.m
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJEducationModel.h"

@implementation EJEducationModel
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
      self.schoolName=[aDecoder decodeObjectForKey:@"schoolName"];
    self.degree=[aDecoder decodeObjectForKey:@"degree"];
    self.joinSchoolTime=[aDecoder decodeObjectForKey:@"joinSchoolTime"];
    self.graduationDate=[aDecoder decodeObjectForKey:@"graduationDate"];
    self.majorName=[aDecoder decodeObjectForKey:@"majorName"];
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
     [aCoder encodeObject:self.schoolName forKey:@"schoolName"];
    [aCoder encodeObject:self.degree forKey:@"degree"];
    [aCoder encodeObject:self.joinSchoolTime forKey:@"joinSchoolTime"];
    [aCoder encodeObject:self.graduationDate forKey:@"graduationDate"];
    [aCoder encodeObject:self.majorName forKey:@"majorName"];
}
@end
