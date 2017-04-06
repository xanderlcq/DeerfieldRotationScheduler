//
//  RotationGenerator.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rotation.h"
#import "StudentsSorter.h"
@interface RotationGenerator : NSObject
@property Rotation *currentRotation;
//Generate random
//Record history
//Read history
-(id)init;
-(NSMutableArray *) generateWaiters:(NSMutableArray *) studentsList;
@end
