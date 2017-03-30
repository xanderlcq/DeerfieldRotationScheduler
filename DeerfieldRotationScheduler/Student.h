//
//  Student.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property NSString *name;
@property int rotationsWaited;
@property NSString *cocurric;
@property int grade;
@property NSMutableArray *frees;
@property NSData *birthday;
@property int mealsWaited;
@property NSMutableArray *linkedStudents;
@property BOOL locked;

//init with name, grade and birthday initialized to 0 
-(id)initWithName:(NSString*) name;

//to-string
//init from string

@end
