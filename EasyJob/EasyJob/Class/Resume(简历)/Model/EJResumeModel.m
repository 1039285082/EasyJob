//
//  EJResumeModel.m
//  EasyJob
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EJResumeModel.h"

@implementation EJResumeModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.resumeName=[aDecoder decodeObjectForKey:@"resumeName"];
       self.userName=[aDecoder decodeObjectForKey:@"userName"];
    self.userSex=[aDecoder decodeObjectForKey:@"userSex"];
     self.userBirthday=[aDecoder decodeObjectForKey:@"userBirthday"];
     self.workTime=[aDecoder decodeObjectForKey:@"workTime"];
     self.nowCity=[aDecoder decodeObjectForKey:@"nowCity"];
     self.birthPlace=[aDecoder decodeObjectForKey:@"birthPlace"];
    self.workNature=[aDecoder decodeObjectForKey:@"workNature"];
    self.workPlace=[aDecoder decodeObjectForKey:@"workPlace"];
    self.jobCategory=[aDecoder decodeObjectForKey:@"jobCategory"];
    self.sectorGroup=[aDecoder decodeObjectForKey:@"sectorGroup"];
    self.expectSalary=[aDecoder decodeObjectForKey:@"expectSalary"];
    self.workingState=[aDecoder decodeObjectForKey:@"workingState"];
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.resumeName forKey:@"resumeName"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userSex forKey:@"userSex"];
    [aCoder encodeObject:self.userBirthday forKey:@"userBirthday"];
    [aCoder encodeObject:self.workTime forKey:@"workTime"];
    [aCoder encodeObject:self.nowCity forKey:@"nowCity"];
     [aCoder encodeObject:self.birthPlace forKey:@"birthPlace"];
     [aCoder encodeObject:self.workNature forKey:@"workNature"];
     [aCoder encodeObject:self.workPlace forKey:@"workPlace"];
     [aCoder encodeObject:self.jobCategory forKey:@"jobCategory"];
     [aCoder encodeObject:self.sectorGroup forKey:@"sectorGroup"];
     [aCoder encodeObject:self.expectSalary forKey:@"expectSalary"];
     [aCoder encodeObject:self.workingState forKey:@"workingState"];
    
}
@end
