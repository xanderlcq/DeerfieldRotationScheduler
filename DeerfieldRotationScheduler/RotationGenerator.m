//
//  RotationGenerator.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "RotationGenerator.h"

@implementation RotationGenerator

-(id)initWithNumOfTables:(int)numOfTables numOfMeals:(int) numOfMeals studentList:(NSMutableArray *) students andPastHistory:(NSMutableArray*) past{
    self = [super init];
    if(self){
        self.currentRotation = [[Rotation alloc] initEmptyRotationWithNumOfMeals:numOfMeals andNumOfTables:numOfMeals];
        self.students = [self shallowCopy:students];
        self.pastRotations = past;
    }
    return self;
}
-(Rotation *) generateRandomRotation{
    NSMutableArray *waiters = [self generateWaiters];
    [self assignRandomWaiters:waiters];
    self.students = [self eliminateDuplicateOf:waiters in:self.students]; //delete waiters from students list of this rotation
    return self.currentRotation;
}
-(NSMutableArray *) eliminateDuplicateOf:(NSMutableArray *)duplicates in:(NSMutableArray *) source{
    NSMutableArray *copy = [self shallowCopy:source];
    for(int i = 0; i < [duplicates count];i++){
        Student *dup = [duplicates objectAtIndex:i];
        int j = 0;
        while(j < [copy count]){
            if(dup == [copy objectAtIndex:j]){
                [copy removeObjectAtIndex:j];
            }else{
                j++;
            }
        }
    }
    return copy;
}
-(void) assignRandomStudents{
    for(Table *t in self.currentRotation.tables){
        while([t.students count] < t.numerOfStudents){
            //While this table needs more students
            NSString *neededGender = [t mostNeededGender];
            int neededGrade = [t mostNeededGrade];
            for(int i = 0; i < 4;i++){
                for(Student * s in self.students){
                    BOOL isNeededGrade = neededGrade == s.grade || i>=1;
                    BOOL isNeededGender = [neededGender isEqualToString:s.gender] || i>=2;
                    BOOL isNeverSatTogether = [self neverSatBefore:s withStudents:t.students] || i>= 3;
                    if(isNeededGrade && isNeededGender &&isNeverSatTogether){
                        [self.students removeObject:s];
                        [t.students addObject:s];
                        i = 4;
                        break;
                    }
                }
            }
        }
    }
}
-(BOOL)neverSatBefore:(Student *) key withStudents:(NSMutableArray *) targetStudents{
    for(Student *s in targetStudents){
        if([self satTogetherBefore:key and:s]){
            return NO;
        }
    }
    return YES;
}
-(void) assignRandomWaiters:(NSMutableArray *) waiters{
    StudentsSorter *sorter = [[StudentsSorter alloc] init];
    waiters = [sorter sortByGrades:waiters];
    //waiters array has an even length
    while([waiters count] > 0){
        //Pop the first student
        Student *firstwaiter = [waiters objectAtIndex:0];
        [waiters removeObjectAtIndex:0];
        //Find the second waiter who's in a different grade and hasn't sat with 1st waiter before
        Student *secondWaiter;
        
        // 1.Never sit together before
        // 2.Grade
        // 3.Gender
        // We eliminate one constrains if nothing is quelified
        for(int i = 0; i < 4; i++){
            int j = (int)[waiters count];
            while(j >= 0){
                secondWaiter = [waiters objectAtIndex:j];
                BOOL neverSatTogether = ![self satTogetherBefore:firstwaiter and:secondWaiter] || i >= 3;
                BOOL isDifferentGrade = firstwaiter.grade != secondWaiter.grade || i >= 2;
                BOOL isDifferentGender = ![firstwaiter.gender isEqualToString:secondWaiter.gender] || i>=1;
                if (neverSatTogether && isDifferentGrade && isDifferentGender) {
                    //break both loops
                    i = 5;
                    break;
                }
                j--;
            }
        }
        
        Table *newTable = [[Table alloc] initWithFirstWaiter:firstwaiter SecondWaiter:secondWaiter andTableNum:0];
        [self.currentRotation.tables addObject:newTable];
    }
}

-(BOOL) satTogetherBefore:(Student *) a and:(Student *)b{
    for(Rotation *r in self.pastRotations){
        if([r student:a isSittingWith:b])
            return YES;
    }
    return NO;
}

//Generate waiters from least waited
-(NSMutableArray *) generateWaiters{
    StudentsSorter *sorter = [[StudentsSorter alloc] init];
    self.students = [sorter sortByRotationsWaited:self.students];
    int waitersNeeded = self.currentRotation.numberOfTables * 2;
    NSMutableArray* waiters = [[NSMutableArray alloc] initWithArray:[self.students subarrayWithRange:(NSMakeRange(0, waitersNeeded))]];
    
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
