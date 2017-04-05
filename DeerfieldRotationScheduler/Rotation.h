//
//  Rotation.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rotation : NSObject

@property NSMutableArray *tables;
@property int numberOfMeals;
@property int numberOfTables;

//to-string
-(NSString*) description;
//init-from string
-(id) initWithTables:(NSMutableArray*)tables andMeals:(int)numMeals andTables:(int)numTables;
@end
