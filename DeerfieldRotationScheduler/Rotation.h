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
#import "StudentInfoUnit.h"
@interface Rotation : NSObject

@property NSMutableArray *tables;
@property int numberOfMeals;
@property NSString *nameOfRotation;
@property NSMutableArray *students;
@property NSMutableArray *studentsInfo;
//to-string
-(NSString*) description;
//init-from string
-(void)updateStudentInfo;
-(void) addEmptyTable:(int) tableSize;
-(BOOL) student:(Student*) first isSittingWith:(Student *) second;
-(int) numberOfTables;
-(id) initEmptyRotation;
-(int) getTableNumberOfStudent:(Student *) student;
-(BOOL)isFirstWaiter:(Student *)student;
-(BOOL)isSecondWaiter:(Student *)student;
@end
