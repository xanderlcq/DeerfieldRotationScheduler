//
//  Student.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Student.h"

@implementation Student

-(id)initWithName:(NSString*) name{
    self = [super init];
    if (self) {
        self.name = name;
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


@end
