//
//  Rotation.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Table.h"
@interface Rotation : NSObject

@property NSMutableArray *tables;
@property int numberOfMeals;
@property int numberOfTables;
@property NSMutableArray *students;
//to-string
-(NSString*) description;
//init-from string

//Collision check
-(BOOL) student:(Student*) first hasSatWith:(Student *) second;

//WHO NAME THIS???????????? with tables and tables???
-(id) initWithTables:(NSMutableArray*)tables andMeals:(int)numMeals andTables:(int)numTables;
-(id) initEmptyRotationWithNumOfMeals:(int) numOfMeals andNumOfTables:(int) numOfTables;
@end
