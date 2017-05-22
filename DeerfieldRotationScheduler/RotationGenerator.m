//
//  RotationGenerator.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "RotationGenerator.h"

@implementation RotationGenerator

-(id)initWithEmptyRotation:(Rotation *) emptyRotation studentList:(NSMutableArray *) students andPastHistory:(NSMutableArray*) past{
    self = [super init];
    if(self){
        self.currentRotation = emptyRotation;
        self.students = [self shallowCopy:students];
        self.pastRotations = past;
    }
    return self;
}
-(void) generateRandomRotation{
    for(Rotation *r in self.pastRotations)
        [r updateStudentInfo];
    self.currentRotation.students = [self shallowCopy:self.students];
    [self removeLockedStudentsFromList];
    NSMutableArray *waiters = [self generateWaiters];
    [self assignRandomWaiters:waiters];
    self.students = [self eliminateDuplicateOf:waiters inList:self.students]; //delete waiters from students list of this rotation
    [self assignRandomStudents];
    //return self.currentRotation;
}
-(NSMutableArray *) eliminateDuplicateOf:(NSMutableArray *)duplicates inList:(NSMutableArray *) source{
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
    StudentsSorter *sorter = [[StudentsSorter alloc] init];
    
    self.students = [sorter sortByGrades:self.students];
    for(Table *t in self.currentRotation.tables){
        while([t.students count] < t.numerOfStudents){
            //While this table needs more students
            NSString *neededGender = [t mostNeededGender];
            
            int neededGrade = [t mostNeededGrade];
            NSLog(@"%@",t);
            for(int i = 0; i < 4;i++){
                if([self.students count] == 0){
                    NSLog(@"No more students. At table #%i",t.tableNumber);
                    return;
                }
                for(Student * s in self.students){
                    BOOL isNeededGrade = neededGrade == s.grade || i>=1;
                    BOOL isNeededGender = [neededGender caseInsensitiveCompare:s.gender] == NSOrderedSame || [s.gender containsString:neededGender] || i>=2;
                    if(s.grade == isNeededGrade && [neededGender isEqualToString:s.gender]){
   
                        NSLog(@"123");
                    }
                    BOOL isNeverSatTogether = [self neverSatBefore:s withStudents:t.students] || i>= 3;
                    if(!isNeverSatTogether)
                        NSLog(@"!@#");
                    if(isNeededGrade && isNeededGender && isNeverSatTogether){
                        [self.students removeObject:s];
                        [t.students addObject:s];
                        //Add student to the table.
                        i = 5;
                        break;
                        
                    }
                }
            }
        }
    }
    if([self.students count] > 0 ){
        
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
    NSMutableArray *sundayWaiters = [self getSundayWaiters:waiters];
    sundayWaiters = [sorter sortByGrades:sundayWaiters];
    //waiters array has an even length
    for(Table *t in self.currentRotation.tables){
        if([t.students count] > t.numerOfStudents - 2)
            continue;
        //Pop the first student
        Student *firstwaiter = [waiters objectAtIndex:0];
        [waiters removeObjectAtIndex:0];
        firstwaiter.rotationsWaited++;
        //Find the second waiter who's in a different grade and hasn't sat with 1st waiter before
        Student *secondWaiter;
        
        // 1.Never sit together before
        // 2.Grade
        // 3.Gender
        // We eliminate one constrains if nothing is qualified
        for(int i = 0; i < 4; i++){
            int j = (int)[waiters count]-1;
            while(j >= 0){
                secondWaiter = [waiters objectAtIndex:j];
                BOOL neverSatTogether = ![self satTogetherBefore:firstwaiter and:secondWaiter] || i >= 3;
                BOOL isDifferentGrade = firstwaiter.grade != secondWaiter.grade || i >= 2;
                BOOL isDifferentGender = ![firstwaiter.gender isEqualToString:secondWaiter.gender] || i>=1;
                if (neverSatTogether && isDifferentGrade && isDifferentGender) {
                    //break both loops
                    i = 5;
                    [waiters removeObjectAtIndex:j];
                    break;
                }
                j--;
            }
        }
        secondWaiter.rotationsWaited++;
        t.firstWaiter = firstwaiter;
        t.secondWaiter = secondWaiter;
        [t.students addObject:firstwaiter];
        [t.students addObject:secondWaiter];
        if(firstwaiter.dayStudent && secondWaiter.dayStudent){
            //Need two sunday waiters
            t.sundayWaiter1 = [sundayWaiters objectAtIndex:0];
            [sundayWaiters removeObjectAtIndex:0];
            t.sundayWaiter2 = [sundayWaiters objectAtIndex:0];
            [sundayWaiters removeObjectAtIndex:0];
            [t.students addObject:t.sundayWaiter1];
            [t.students addObject:t.sundayWaiter2];
        }else if(firstwaiter.dayStudent || secondWaiter.dayStudent){
            //Need one sunday waiter
            t.sundayWaiter1 = [sundayWaiters objectAtIndex:0];
            [t.students addObject:t.sundayWaiter1];
        }
    }
    
}
-(void) removeLockedStudentsFromList{
    NSMutableArray *added = [[NSMutableArray alloc] init];
    for(Student *s in self.students){
        if(s.lockTableNum != -99){
            [added addObject:s];
        }
    }
    self.students = [self eliminateDuplicateOf:added inList:self.students];
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

    int waitersNeeded = 0;
    for(Table *t in self.currentRotation.tables){
//        if([t.students count] >= t.numerOfStudents)
//            continue;
//        if([t.students count] == t.numerOfStudents - 1)
//            waitersNeeded ++;
        if([t.students count] <= t.numerOfStudents - 2)
            waitersNeeded += 2;
        else
            continue;
    }

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rotationsWaited" ascending:YES];
    [self.students sortUsingDescriptors:@[sortDescriptor]];
    //NSMutableArray* waiters = [[NSMutableArray alloc] initWithArray:[self.students subarrayWithRange:(NSMakeRange(0, waitersNeeded))]];
    NSMutableArray *selectingPool = [[NSMutableArray alloc] init];
    NSMutableArray *notSelectingPool = [[NSMutableArray alloc] init];
    for(Student *s in self.students){
        
        //Avoid day and new student from waiting
        if(!self.newStudentWaiting && !self.dayStudentWaiting){
            if(!s.newStudent && !s.dayStudent){
                [selectingPool addObject:s];
            }else{
                [notSelectingPool addObject:s];
            }
        }
        
        //Normal
        if(self.newStudentWaiting && !self.dayStudentWaiting){
            if(!s.dayStudent){
                [selectingPool addObject:s];
            }else{
                [notSelectingPool addObject:s];
            }
        }
        
        //No new student, but yes day student
        if(!self.newStudentWaiting && self.dayStudentWaiting){
            if(s.dayStudent && !s.newStudent){
                [selectingPool addObject:s];
            }else{
                [notSelectingPool addObject:s];
            }
        }
        //Allow anyone
        if(self.newStudentWaiting && self.dayStudentWaiting){
            [selectingPool addObject:s];
        }
    }
    [selectingPool sortUsingDescriptors:@[sortDescriptor]];
    [notSelectingPool sortUsingDescriptors:@[sortDescriptor]];
    NSMutableArray* waiters = [[NSMutableArray alloc] init];
    for(int i = 0; i < waitersNeeded;i++){
        Student* s;
        if(i < [selectingPool count]){
            s = [selectingPool objectAtIndex:i];
        }else{
            if(i - [selectingPool count] < [notSelectingPool count]){
                s = [notSelectingPool objectAtIndex:i - [selectingPool count]];
            }else{
                continue;
            }
        }
        [waiters addObject:s];
    }
    if([waiters count] != waitersNeeded){
        NSLog(@"something's wrong");
    }
    return waiters;
}


-(NSMutableArray *) getSundayWaiters:(NSMutableArray *) waitersWithDayStudents{
    NSMutableArray *sundayWaiters = [[NSMutableArray alloc] init];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rotationsWaited" ascending:YES];
    [self.students sortUsingDescriptors:@[sortDescriptor]];
    int index = 0;
    for(Student *s in waitersWithDayStudents){
        if(s.dayStudent){
            [sundayWaiters addObject:[self.students objectAtIndex:index]];
            index++;
        }
    }
    return sundayWaiters;
}

-(NSMutableArray *) shallowCopy:(NSMutableArray *) original{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for(int i = 0; i < [original count]; i++){
        [copy insertObject:[original objectAtIndex:i] atIndex:i];
        
    }
    return copy;
}


@end
