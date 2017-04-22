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
        info.tableNumber = [self getTableNumberOfStudent:s];
        info.waiter = [NSString stringWithFormat:@""];
        if([self isFirstWaiter:s])
            info.waiter = [NSString stringWithFormat:@"1"];
        else if([self isSecondWaiter:s])
            info.waiter = [NSString stringWithFormat:@"2"];
        [self.studentsInfo addObject:info];
    }
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
