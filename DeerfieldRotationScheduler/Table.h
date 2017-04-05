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

-(NSString*) description;
-(id)initWithStudents:(NSMutableArray*) students first:(Student*)firstW andSecond:(Student*)secondW wTable:(int) tableNum;
-(id) initFromString:(NSString*) string;

//to-string
//init from string
@end
