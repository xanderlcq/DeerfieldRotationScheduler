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
        self.grade = 0;
        self.dayStudent = NO;
        self.lockTableNum = -99;
    }
    return self;
}

-(id)initWithFirstName:(NSString*)first andLastName:(NSString*)last grade:(int) grade gender:(NSString*) gender{
    self = [super init];
    if (self) {
        self.firstName = first;
        self.lastName = last;
        self.rotationsWaited = 0;
        self.gender = gender;
        self.grade = grade;
        self.dayStudent = NO;
        self.lockTableNum = -99;

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
        self.grade = grade;
        self.dayStudent = NO;
        self.lockTableNum = -99;

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
        self.grade = 0;
        self.dayStudent = NO;
        self.lockTableNum = -99;

    }
    return self;
}


-(NSString*)description{
    NSString* str = @"";
    str = [NSString stringWithFormat:@"{%@,%@,%i,%@,%i}", self.firstName, self.lastName, self.rotationsWaited,self.gender,self.grade];
    
    
    return str;
    
}
-(BOOL) isEqualTo:(Student *) target{
    return [[self.firstName lowercaseString] isEqualToString:[target.firstName lowercaseString]] && [[self.lastName lowercaseString] isEqualToString:[target.lastName lowercaseString]];
}
@end
