//
//  Table.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Table.h"

@implementation Table

-(id)initWithSize:(int) size{
    self = [super init];
    if(self){
        self.students = [[NSMutableArray alloc] init];
        self.numerOfStudents = size;
    }
    return self;
}
-(id)initEmptyTableWithNum:(int) tableNumber{
    self = [super init];
    if(self){
        self.tableNumber = tableNumber;
        self.students = [[NSMutableArray alloc] init];
    }
    return self;
}
-(id)initWithFirstWaiter:(Student*)firstW SecondWaiter:(Student*)secondW andTableNum:(int) tableNum{
    self = [super init];
    if(self){
        self.tableNumber = tableNum;
        self.students = [[NSMutableArray alloc] init];
        self.firstWaiter = firstW;
        self.secondWaiter = secondW;
    }
    return self;
}
-(id)initWithStudents:(NSMutableArray*) students first:(Student*)firstW andSecond:(Student*)secondW wTable:(int) tableNum{
    self = [super init];
    if(self){
        self.students = students;
        self.firstWaiter = firstW;
        self.secondWaiter = secondW;
        self.tableNumber = tableNum;
    }
    return self;
}
-(int) numOfMale{
    int counter = 0;
    for(Student *a in self.students){
        if([a.gender isEqualToString:@"M"])
            counter++;
    }
    return counter;
}
-(int) numOfFemale{
    int counter = 0;
    for(Student *a in self.students){
        if([a.gender isEqualToString:@"F"])
            counter++;
    }
    return counter;
}
-(NSString *)mostNeededGender{
    return [self numOfMale]<[self numOfFemale]?@"M":@"F";
}
-(BOOL)contains:(Student *)s{
    for(Student *stud in self.students){
        if([stud isEqualTo:s]){
            return YES;
        }
    }
    return NO;
}

//returns grade with least # of people
-(int) mostNeededGrade{
    int nine = 0;
    int ten = 0;
    int eleven = 0;
    int twelve = 0;
    
    for (Student *student in self.students) {
        if (student.grade == 9)
            nine++;
        else if (student.grade == 10)
            ten++;
        else if (student.grade == 11)
            eleven++;
        else if (student.grade == 12)
            twelve++;
    }
    int minUnder = MIN(nine, ten);
    int minUpper = MIN(eleven, twelve);
    int min = MIN(minUpper, minUnder);
    
    //NSLog(@"9: %i, 10: %i, 11: %i, 12: %i",nine, ten, eleven, twelve);
    
    if (min == twelve)
        return 12;
    
    if (min == eleven)
        return 11;
    
    if (min == ten)
        return 10;
    
    if (min == nine)
        return 9;
    
    return -1;
}
-(NSString*) description{
    NSString* str = [self.students componentsJoinedByString:@", "];
    //str will be replaced by [self.students description]
    return [NSString stringWithFormat: @"{%@}; FirstW:%@; SecondW:%@; #:%i", str, self.firstWaiter.description, self.secondWaiter.description, self.tableNumber];
}
-(BOOL) student:(Student *) a isSittingWith:(Student *)b{
    BOOL aIsHere = NO;
    BOOL bIsHere = NO;
    for(Student * s in self.students){
        if([s isEqualTo:a])
            aIsHere = YES;
        if([s isEqualTo:b])
            bIsHere = YES;
    }
    return aIsHere && bIsHere;
}

-(NSString*)namePresentably{
    NSString* table = [NSString stringWithFormat:@"%i\n1ST %@, %@\n2ND %@, %@\n", self.tableNumber, self.firstWaiter.lastName, self.firstWaiter.firstName, self.secondWaiter.lastName, self.secondWaiter.firstName];
    for(int i = 0; i < self.students.count; i++){
        Student* s = [self.students objectAtIndex:i];
        if(s != self.firstWaiter && s!= self.secondWaiter)
            table = [NSString stringWithFormat:@"%@\n%@, %@", table, s.lastName, s.firstName];
    }
    return table;
}

@end
