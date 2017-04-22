//
//  StudentInfoUnit.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/21/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "StudentInfoUnit.h"

@implementation StudentInfoUnit
-(NSString*)firstName{
    return self.student.firstName;
}
-(NSString*)lastName{
    return self.student.lastName;
}
-(NSString*)tableNum{
    return [NSString stringWithFormat:@"%i",self.tableNumber];
}
-(NSString*)waiterStr{
    return self.waiter;
}
-(NSString*)gender{
    return self.student.gender;
}
-(NSString*)grade{
    return [NSString stringWithFormat:@"%i",self.student.grade];
}
@end
