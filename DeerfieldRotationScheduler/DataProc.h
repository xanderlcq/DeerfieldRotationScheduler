//
//  DataProc.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface DataProc : NSObject
//Read names list
-(NSMutableArray*)readNames:(NSString*)fileName;
@end
