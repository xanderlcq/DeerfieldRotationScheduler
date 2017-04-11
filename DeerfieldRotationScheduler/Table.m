//
//  Table.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Table.h"

@implementation Table

-(id)init{
    self = [super init];
    if(self){
        self.students = [[NSMutableArray alloc] init];
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
    return [self numOfMale]>[self numOfFemale]?@"M":@"F";
}

//returns grade with least # of people
-(int) mostNeededGrade{
    int nine = 0;
    int ten = 0;
    int eleven = 0;
    int twelve = 0;
    
    for (Student *student in self.students) {
        if (student.grade == 9){
            nine++;
        }
        else if (student.grade == 10){
            ten++;
        }
        else if (student.grade == 11){
            eleven++;
        }
        else if (student.grade == 12){
            twelve++;
        }
    }
    int minUnder = MIN(nine, ten);
    int minUpper = MIN(eleven, twelve);
    int min = MIN(minUpper, minUnder);
    NSLog(@"9: %i, 10: %i, 11: %i, 12: %i",nine, ten, eleven, twelve);
#warning complete this method
    return -1;
}
-(NSString*) description{
    NSString* str = [self.students componentsJoinedByString:@", "];
    //str will be replaced by [self.students description]
    return [NSString stringWithFormat: @"{%@}; %@; %@; %i", str, self.firstWaiter.description, self.secondWaiter.description, self.tableNumber];
}

-(id) initFromString:(NSString*) string{
    self = [super init];
    //take in first part of string, feed into init from string for student
    if(self){
        //get all student strings into an array
        NSArray* studentStrings = [[[(NSString *)[[string componentsSeparatedByString:@";"] firstObject] stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""] componentsSeparatedByString:@", "];
        
        //add students to self.students
        for (int i = 0; i < [studentStrings count]; i++){
            NSString* studentString = [studentStrings objectAtIndex:i];
//<<<<<<< Updated upstream
////            Student *newS = [[Student alloc]initFromString:studentString]
////            [self.students addObject:newS];
//||||||| merged common ancestors
//            Student *newS = [[Student alloc]initFromString:studentString]
//            [self.students addObject:newS];
//=======
//          //  Student *newS = [[Student alloc]initFromString:studentString]
//           // [self.students addObject:newS];
//>>>>>>> Stashed changes
        }
        //create waiters - will be duplicate
        NSString* firstWaiter = (NSString *)[[string componentsSeparatedByString:@";"] objectAtIndex:1];
        //self.firstWaiter = [[Student alloc]initFromString:firstWaiter];
        
        NSString* secondWaiter = (NSString *)[[string componentsSeparatedByString:@";"] objectAtIndex:2];
        //self.secondWaiter = [[Student alloc]initFromString:secondWaiter];
        
        //table number
        self.tableNumber = [[[string componentsSeparatedByString:@";"] objectAtIndex:3]intValue];
    }
    return self;
}

@end
