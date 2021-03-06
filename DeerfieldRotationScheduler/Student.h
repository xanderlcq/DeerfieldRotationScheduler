//
//  Student.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
//{Xander,Li,1,Manager,12,{1,2,3},99,{Name1,Name2}}
@property NSString *firstName;
@property NSString *lastName;
@property float rotationsWaited;
@property NSString *gender;
@property int grade;
@property BOOL dayStudent;
@property BOOL newStudent;
@property int lockTableNum;
//init with name, grade and birthday initialized to 0 
-(id)initWithFirstName:(NSString*)first andLastName:(NSString*)last;
//for testing
-(id)initWithFirstName:(NSString*)first andLastName:(NSString*)last grade:(int) grade;
-(id)initWithFirstName:(NSString*)first andLastName:(NSString*)last gender:(NSString*) gender;
-(id)initWithFirstName:(NSString*)first andLastName:(NSString*)last grade:(int) grade gender:(NSString*) gender;
-(NSString*)description;
//-(Student*)initFromString:(NSString*)str;
//to-string
//init from string
-(BOOL) isEqualTo:(Student *) target;
@end
