//
//  Rotation.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Rotation.h"

@implementation Rotation

-(NSString*) description{
    NSString* tablesStr = [self.tables componentsJoinedByString:@", "];
    //taableStr will be replaced by [self.students description]
    return [NSString stringWithFormat: @"Tables: {%@}; Number of tables: %i", tablesStr, self.numberOfTables];
}
-(void)updateStudentInfo{
    self.studentsInfo = [[NSMutableArray alloc] init];
    for(Student *s in self.students){
        StudentInfoUnit *info = [[StudentInfoUnit alloc] init];
        info.student = s;
        info.fName = s.firstName;
        info.lName = s.lastName;
        info.tableNumber = [self getTableNumberOfStudent:s];
        info.waiter = [NSString stringWithFormat:@""];
        if([self isFirstWaiter:s])
            info.waiter = [NSString stringWithFormat:@"1"];
        else if([self isSecondWaiter:s])
            info.waiter = [NSString stringWithFormat:@"2"];
        [self.studentsInfo addObject:info];
    }
}
-(id) initFromCVSStringWithStudentsList:(NSMutableArray *) studentsList infoUnits:(NSMutableArray *) infoUnit andNameOfRotation:(NSString *) name{
    self = [super init];
    if(self){
        self.nameOfRotation = name;
        self.studentsInfo = infoUnit;
        self.students = studentsList;
        self.tables = [[NSMutableArray alloc] init];
        [self restoreFromStudentsAndInfos];
    }
    return self;
}
-(void)restoreFromStudentsAndInfos{
    for(StudentInfoUnit *infoUnit in self.studentsInfo){
        //Find the actual student from students list
        Student *stud = [self getStudentWithFirstName:infoUnit.fName andLastName:infoUnit.lName];
        if(!stud){
            stud = [[Student alloc] initWithFirstName:infoUnit.fName andLastName:infoUnit.lName grade:-1 gender:@""];
        }
        //Find the table if exists
        Table *table = [self getTableWithNumber:infoUnit.tableNumber];
        if(!table){
            table = [[Table alloc] initWithTableNumber:infoUnit.tableNumber];
            [self.tables addObject:table];
        }
        //Add to the table
        [table.students addObject:stud];
        //Assign as waiter if the student is
        if([infoUnit.waiter isEqualToString:@"1"])
            table.firstWaiter = stud;
        if([infoUnit.waiter isEqualToString:@"2"])
            table.secondWaiter = stud;
        
            
    }
    //Re calculate table size
    for(Table *t in self.tables){
        t.numerOfStudents = (int)[t.students count];
    }
}
-(Student *) getStudentWithFirstName:(NSString *) f andLastName:(NSString *)l{
    Student *temp = [[Student alloc] initWithFirstName:f andLastName:l];
    for(Student *s in self.students){
        if([s isEqualTo:temp])
            return s;
    }
    return nil;
}
-(Table *) getTableWithNumber:(int) num{
    for(Table *t in self.tables){
        if(t.tableNumber == num)
            return t;
    }
    return nil;
}
-(int) getTableNumberOfStudent:(Student *) student{
    for(Table *t in self.tables){
        if([t contains:student])
            return t.tableNumber;
    }
    return -1;
}
-(BOOL)isFirstWaiter:(Student *)student{
    for(Table *t in self.tables){
        if([t.firstWaiter isEqualTo:student])
            return YES;
    }
    return NO;
}
-(BOOL)isSecondWaiter:(Student *)student{
    for(Table *t in self.tables){
        if([t.secondWaiter isEqualTo:student])
            return YES;
    }
    return NO;
}

-(id) initEmptyRotation{
    
    self = [super init];
    if (self){
        self.tables = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void) addEmptyTable:(int) tableSize{
    Table *t =[[Table alloc] initWithSize:tableSize];
    t.tableNumber = (int)[self.tables count]+1;
    [self.tables addObject:t];
}
//-(id) initFromString:(NSString*) string{
//    self = [super init];
//    if(self){
//        NSArray* tableStrings = [[[(NSString *)[[string componentsSeparatedByString:@";"] firstObject] stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""] componentsSeparatedByString:@", "];
//        
//        //add students to self.students
//        for (int i = 0; i < [tableStrings count]; i++){
//            NSString* tableString = [tableStrings objectAtIndex:i];
//            //            Table *newT = [[Table alloc]initFromString:tableString]
//            //            [self.tables addObject:newT];
//        }
//        self.numberOfMeals = [[[string componentsSeparatedByString:@";"] objectAtIndex:1]intValue];
//        self.numberOfTables =  [[[string componentsSeparatedByString:@";"] objectAtIndex:2]intValue];
//    }
//    return self;
//}
-(int) numberOfTables{
    return (int)[self.tables count];
}
//check if at same table - assuming each student has already been assigned to a table. Will be true if bothunassigned to a table
-(BOOL) student:(Student*) a isSittingWith:(Student *) b{
    for (Table *table in self.tables) {
        if([table student:a isSittingWith:b])
            return YES;
    }
    return NO;
}

//write to text file?? 

@end
