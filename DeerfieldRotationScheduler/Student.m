//
//  Student.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Student.h"

@implementation Student

-(id)initWithFirstName:(NSString*)first andLastName:(NSString*)last{
    self = [super init];
    if (self) {
        self.firstName = first;
        self.lastName = last;
        self.rotationsWaited = 0;
        self.mealsWaited = 0;
        self.cocurric = @"";
        self.grade = 0;
        self.frees = [[NSMutableArray alloc]init];
        self.birthday = nil;
        self.linkedStudents = [[NSMutableArray alloc] init];
    }
    return self;
}
//{Xander,Li,1,Manager,120,{1,2,3},99,{Name1,Name2}}

-(NSString*)toString{
    NSString* str = @"";
    str = [NSString stringWithFormat:@"{%@,%@,%i,%i,%@,%i,%@{", self.firstName, self.lastName, self.rotationsWaited,
                                                    self.mealsWaited, self.cocurric, self.grade, self.birthday];
    for(int i = 0; i < self.frees.count; i++){
        str = [NSString stringWithFormat:@"%@,%i", str, (int)self.frees[i]];
    }
    
    str = [NSString stringWithFormat:@"%@},{", str];
    
    for(int i = 0; i < self.frees.count; i++){
        Student* s = self.linkedStudents[i];
        str = [NSString stringWithFormat:@"%@,%@-%@", str, s.firstName, s.lastName];
    }
    
    str = [NSString stringWithFormat:@"%@}}", str];
    
    return str;
    
}


@end
