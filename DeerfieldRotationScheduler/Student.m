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
    str = [NSString stringWithFormat:@"{%@,%@,%i,%@,%i,{", self.firstName, self.lastName, self.rotationsWaited, self.cocurric, self.grade];
    for(int i = 0; i < self.frees.count; i++){
//      str = str stringByAppendingString:frees[i];
    }



    return str;
    
}


@end
