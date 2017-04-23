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
        self.cocurric = @"Undefined Cocurric";
        self.grade = 0;
        self.frees = [[NSMutableArray alloc]initWithObjects:[[NSNumber alloc] initWithInt:0], nil];
        self.birthday = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:0];
        self.linkedStudents = [[NSMutableArray alloc] init];
        self.dayStudent = NO;
    }
    return self;
}

-(id)initWithFirstName:(NSString*)first andLastName:(NSString*)last grade:(int) grade gender:(NSString*) gender{
    self = [super init];
    if (self) {
        self.firstName = first;
        self.lastName = last;
        self.rotationsWaited = 0;
        self.mealsWaited = 0;
        self.gender = gender;
        self.cocurric = @"Undefined Cocurric";
        self.grade = grade;
        self.frees = [[NSMutableArray alloc]initWithObjects:[[NSNumber alloc] initWithInt:0], nil];
        self.birthday = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:0];
        self.linkedStudents = [[NSMutableArray alloc] init];
        self.dayStudent = NO;
    }
    return self;

}

//for testing
-(id)initWithFirstName:(NSString*)first andLastName:(NSString*)last grade:(int) grade{
    self = [super init];
    if (self) {
        self.firstName = first;
        self.lastName = last;
        self.rotationsWaited = 0;
        self.mealsWaited = 0;
        self.cocurric = @"Undefined Cocurric";
        self.grade = grade;
        self.frees = [[NSMutableArray alloc]initWithObjects:[[NSNumber alloc] initWithInt:0], nil];
        self.birthday = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:0];
        self.linkedStudents = [[NSMutableArray alloc] init];
        self.dayStudent = NO;
    }
    return self;
}

//for testing
-(id)initWithFirstName:(NSString*)first andLastName:(NSString*)last gender:(NSString*) gender{
    self = [super init];
    if (self) {
        self.firstName = first;
        self.lastName = last;
        self.gender = gender;
        self.rotationsWaited = 0;
        self.mealsWaited = 0;
        self.cocurric = @"Undefined Cocurric";
        self.grade = 0;
        self.frees = [[NSMutableArray alloc]initWithObjects:[[NSNumber alloc] initWithInt:0], nil];
        self.birthday = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:0];
        self.linkedStudents = [[NSMutableArray alloc] init];
        self.dayStudent = NO;
    }
    return self;
}


-(NSString*)description{
    NSString* str = @"";
    str = [NSString stringWithFormat:@"{%@,%@,%i,%@,%i}", self.firstName, self.lastName, self.rotationsWaited,self.gender,self.grade];
    
    
    return str;
    
}
//This should be done in one line
//-(NSString*)description{
//    NSString* str = @"";
//    str = [NSString stringWithFormat:@"{%@,%@,%i,%i,%@,%i,%@,%hhd,frees: %@,linked: %@}", self.firstName, self.lastName, self.rotationsWaited,
//           self.mealsWaited, self.cocurric, self.grade, self.birthday,self.dayStudent,self.frees,self.linkedStudents];
//
//    
//    return str;
//    
//}
//{Xander,Li,1,13,manager,12,DATE,NO,{1,2,3},{Name1,Name2}}

//-(Student*)initFromString:(NSString*)str{
//    NSArray* parts = [str componentsSeparatedByString:@","];
//    self.firstName = [parts objectAtIndex:0];
//    self.lastName = [parts objectAtIndex:1];
//    self.rotationsWaited = [[parts objectAtIndex:2] intValue];
//    self.mealsWaited = [[parts objectAtIndex:3] intValue];
//    self.cocurric = [parts objectAtIndex:4];
//    self.grade = [[parts objectAtIndex:5] intValue];
//    self.birthday = [parts objectAtIndex:6];
//    if([[parts objectAtIndex:7] isEqualToString:@"n"])
//        self.dayStudent = NO;
//    else
//        self.dayStudent = YES;
//    
//    NSString* allFrees = [parts objectAtIndex:8];
//    NSArray* numFrees = [allFrees componentsSeparatedByString:@","];
//    for(int i = 0; i < numFrees.count; i++){
//        [self.frees addObject: [NSNumber numberWithInt:[[numFrees objectAtIndex:i] intValue]]];
//    }
//    
//    NSString* y = [parts objectAtIndex:9];
//    NSArray* linkedStuds = [y componentsSeparatedByString:@","];
//    for(int i = 0; i < numFrees.count; i++){
//        [self.linkedStudents addObject:[numFrees objectAtIndex:i]];
//    }
//
//    return self;
//}
-(BOOL) isEqualTo:(Student *) target{
    return [[self.firstName lowercaseString] isEqualToString:[target.firstName lowercaseString]] && [[self.lastName lowercaseString] isEqualToString:[target.lastName lowercaseString]];
}
@end
