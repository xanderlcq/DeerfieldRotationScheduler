//
//  RotationGenerator.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "RotationGenerator.h"

@implementation RotationGenerator

-(id)initWithNumOfTables:(int) numOfTables numOfMeals:(int) numOfMeals{
    self = [super init];
    if(self){
        self.currentRotation = [[Rotation alloc] initEmptyRotationWithNumOfMeals:numOfMeals andNumOfTables:numOfMeals];
        
    }
    return self;
}
-(Rotation *) generateNewRotationFromPastHistory:(NSMutableArray *) pastRotations{
    return nil;
}


//Generate waiters from least waited
-(NSMutableArray *) generateWaiters:(NSMutableArray *) studentsList{
    StudentsSorter *sorter = [[StudentsSorter alloc] init];
    NSMutableArray *sortedByRotationsWaited = [sorter sortByRotationsWaited:studentsList];
    int waitersNeeded = self.currentRotation.numberOfTables * 2;
    NSMutableArray* waiters = [[NSMutableArray alloc] initWithArray:[sortedByRotationsWaited subarrayWithRange:(NSMakeRange(0, waitersNeeded))]];
    
    return waiters;
}
@end
