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

@property NSMutableArray* students;
@property int tableNumber;
@property Student* firstWaiter;
@property Student* secondWaiter;

-(Table*)initWithStudents:(NSMutableArray*) students first:(Student*)first andSecond:(Student*)second;

@end
