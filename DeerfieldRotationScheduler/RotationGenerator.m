//
//  RotationGenerator.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "RotationGenerator.h"

@implementation RotationGenerator

-(id)initWithNumOfTables:(int) numOfTables numOfMeals:(int) numOfMeals andStudents:(NSMutableArray *) students{
    self = [super init];
    if(self){
        self.currentRotation = [[Rotation alloc] initEmptyRotationWithNumOfMeals:numOfMeals andNumOfTables:numOfMeals];
        self.students = students;
    }
    return self;
}
-(Rotation *) generateNewRotationFromPastHistory:(NSMutableArray *) pastRotations{
    NSMutableArray *waiters = [self generateWaiters:self.students];
    [self assignWaiters:waiters pastHistory:pastRotations];
    NSMutableArray *restOfStudents = [self eliminateDuplicateOf:waiters in:self.students];
    return nil;
}
-(NSMutableArray *) eliminateDuplicateOf:(NSMutableArray *)duplicates in:(NSMutableArray *) source{
    NSMutableArray *copy = [self shallowCopy:source];
    for(int i = 0; i < [duplicates count];i++){
        Student *dup = [duplicates objectAtIndex:i];
        int j = 0;
        while(j < [copy count]){
            
            
        }
    }
}
-(void) assignWaiters:(NSMutableArray *) waiters pastHistory:(NSMutableArray *) pastRotations{
    StudentsSorter *sorter = [[StudentsSorter alloc] init];
    waiters = [sorter sortByGrades:waiters];
    //waiters array has an even length
    while([waiters count] > 0){
        //Pop the first student
        Student *firstwaiter = [waiters objectAtIndex:0];
        [waiters removeObjectAtIndex:0];
        //Find the second waiter who's in a different grade and hasn't sat with 1st waiter before
        Student *secondWaiter;
        
        //Perform some magic
        
        Table *newTable = [[Table alloc] initWithFirstWaiter:firstwaiter SecondWaiter:secondWaiter andTableNum:0];
        [self.currentRotation.tables addObject:newTable];
    }
}

-(BOOL) satTogetherBefore:(Student *) a and:(Student *)b pathHistory:(NSMutableArray *) pastRotations{
    for(int i = 0; i < [pastRotations count];i++){
        if([(Rotation *)[pastRotations objectAtIndex:i] student:a hasSatWith:b])
            return YES;
    }
    return NO;
}

//Generate waiters from least waited
-(NSMutableArray *) generateWaiters:(NSMutableArray *) studentsList{
    StudentsSorter *sorter = [[StudentsSorter alloc] init];
    NSMutableArray *sortedByRotationsWaited = [sorter sortByRotationsWaited:studentsList];
    int waitersNeeded = self.currentRotation.numberOfTables * 2;
    NSMutableArray* waiters = [[NSMutableArray alloc] initWithArray:[sortedByRotationsWaited subarrayWithRange:(NSMakeRange(0, waitersNeeded))]];
    
    return waiters;
}
    
-(NSMutableArray *) shallowCopy:(NSMutableArray *) original{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for(int i = 0; i < [original count]; i++){
        [copy insertObject:[original objectAtIndex:i] atIndex:i];
        
    }
    return copy;
}
@end
