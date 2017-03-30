//
//  Table.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Table.h"

@implementation Table
-(id)initWithStudents:(NSMutableArray*) students first:(Student*)first andSecond:(Student*)second{
    self = [super init];
    if(self){
        self.students = students;
        self.firstWaiter = first;
        self.secondWaiter = second;
    }
        return self;
}
@end
