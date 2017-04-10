//
//  StudentsSorter.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/30/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "StudentsSorter.h"
#import "Student.h"
@implementation StudentsSorter

-(NSMutableArray *) sortByGrades:(NSMutableArray *)originalList{
    NSMutableArray *sorted = [self shallowCopy:originalList];
    for(int i = 1;i <[sorted count];i++){
        int j = i;
        while(j > 0 && (((Student *)[sorted objectAtIndex:j]).grade < ((Student *)[sorted objectAtIndex:j-1]).grade)){
            //While current is greater than previous
            [self swap:sorted  swap:j and:j-1];
            //bubble it up
            j--;
        }
    }
    return sorted;
}

-(NSMutableArray *) sortByLastName:(NSMutableArray *)originalList{
    NSMutableArray *sorted = [self shallowCopy:originalList];
    for(int i = 1;i <[sorted count];i++){
        int j = i;
        while(j > 0 && [((Student *)[sorted objectAtIndex:j]).lastName isLessThan:((Student *)[sorted objectAtIndex:j-1]).lastName]){
            //While current is greater than previous
            [self swap:sorted  swap:j and:j-1];
            //bubble it up
            j--;
        }
    }
    return sorted;
}
-(NSMutableArray *) sortByFirstName:(NSMutableArray *)originalList{
    NSMutableArray *sorted = [self shallowCopy:originalList];
    for(int i = 1;i <[sorted count];i++){
        int j = i;
        
        while(j > 0 && [((Student *)[sorted objectAtIndex:j]).firstName isLessThan:((Student *)[sorted objectAtIndex:j-1]).firstName]){
            //While current is greater than previous
            [self swap:sorted  swap:j and:j-1];
            //bubble it up
            j--;
        }
    }
    return sorted;
}
-(NSMutableArray *) sortByRotationsWaited:(NSMutableArray *)originalList{
    NSMutableArray *sorted = [self shallowCopy:originalList];
    for(int i = 1;i <[sorted count];i++){
        int j = i;
        while(j > 0 && (((Student *)[sorted objectAtIndex:j]).rotationsWaited < ((Student *)[sorted objectAtIndex:j-1]).rotationsWaited)){
            //While current is greater than previous
            [self swap:sorted  swap:j and:j-1];
            //bubble it up
            j--;
        }
    }
    return sorted;
}
-(void) swap:(NSMutableArray *)arr swap:(int)a and:(int)b{
    id temp = [arr objectAtIndex:a];
    [arr replaceObjectAtIndex:a withObject:[arr objectAtIndex:b]];
    [arr replaceObjectAtIndex:b withObject:temp];
}
-(NSMutableArray *) shallowCopy:(NSMutableArray *) original{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for(int i = 0; i < [original count]; i++){
        [copy insertObject:[original objectAtIndex:i] atIndex:i];
        
    }
    return copy;
}
@end
