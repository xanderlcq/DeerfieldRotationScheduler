//
//  Student.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Student.h"

@implementation Student

-(instancetype)initWithName:(NSString*) name{
    self = [super init];
    if (self) {
        self.name = name;
        self.timesWaited = 0;
        self.cocurric = @"";
        self.grade = 0;
        self.frees = [[NSMutableArray alloc]init];
        self.birthday = 0;
    }
    return self;
}


@end
