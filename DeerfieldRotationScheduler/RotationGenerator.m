//
//  RotationGenerator.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "RotationGenerator.h"

@implementation RotationGenerator
-(id)init{
    self = [super init];
    return self;
}

-(NSMutableArray *) generateWaiters:(NSMutableArray *) studentsList{
    StudentsSorter *sorter = [[StudentsSorter alloc] init];
    NSMutableArray *sortedByRotationsWaited = [sorter sortByRotationsWaited:studentsList];
    int waitersNeeded = self.currentRotation.numberOfTables * 2;
    NSMutableArray* waiters = [[NSMutableArray alloc] initWithArray:[sortedByRotationsWaited subarrayWithRange:(NSMakeRange(0, waitersNeeded))]];
    
    return waiters;
}
@end
