//
//  Table.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface Table : NSObject

@property NSMutableArray<Student *>* students;
@property int tableNumber;
@property Student* firstWaiter;
@property Student* secondWaiter;
@property int numerOfStudents;

-(NSString*) description;

-(id)initWithSize:(int) size;
-(id)initWithFirstWaiter:(Student*)firstW SecondWaiter:(Student*)secondW andTableNum:(int) tableNum;
//-(id)initEmptyTableWithNum:(int) tableNumber;
-(id)initWithStudents:(NSMutableArray*) students first:(Student*)firstW andSecond:(Student*)secondW wTable:(int) tableNum;
//-(id) initFromString:(NSString*) string;
-(int) numOfMale;
-(int) numOfFemale;
-(int) mostNeededGrade;
-(NSString *)mostNeededGender;
-(BOOL) student:(Student *) a isSittingWith:(Student *)b;
//to-string
//init from string
-(BOOL)contains:(Student *)s;
-(NSString*)namePresentably;
@end
