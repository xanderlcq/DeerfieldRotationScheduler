//
//  StudentInfoUnit.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/21/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
@interface StudentInfoUnit : NSObject
@property int tableNumber;
@property NSString *waiter;
@property NSString *firstName;
@property NSString *lastName;

@property NSMutableDictionary *studentsSittingTogether;

@property NSString *gender;
@property int grade;

@end
