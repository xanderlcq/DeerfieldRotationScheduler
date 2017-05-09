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
@property Student *student;
@property (nonatomic) int tableNumber;
@property (nonatomic) NSString *waiter;//
@property NSString *fName;
@property NSString *lName;
@property NSMutableDictionary *studentsSittingTogether;
-(NSString*)firstName;//
-(NSString*)lastName;//
-(NSString*)tableNum;//
-(NSString*)waiterStr;
-(NSString*)gender;//
-(NSString*)grade;//


@end
