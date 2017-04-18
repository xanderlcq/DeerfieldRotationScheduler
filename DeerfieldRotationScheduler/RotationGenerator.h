//
//  RotationGenerator.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rotation.h"
#import "StudentsSorter.h"
@interface RotationGenerator : NSObject
@property Rotation *currentRotation;
@property NSMutableArray *students;
@property NSMutableArray *pastRotations;
//Generate random
//Record history
//Read history

-(id)initWithNumOfTables:(Rotation *) emptyRotation studentList:(NSMutableArray *) students andPastHistory:(NSMutableArray*) past;
-(NSMutableArray *) generateWaiters;
-(void) assignRandomWaiters:(NSMutableArray *) waiters;
-(NSMutableArray *) eliminateDuplicateOf:(NSMutableArray *)duplicates inList:(NSMutableArray *) source;
-(void) assignRandomStudents;
-(Rotation *) generateRandomRotation;

//sarah testing lock
-(void) lockStudent:(Student*) student atTable:(int)tableNum;

@end
