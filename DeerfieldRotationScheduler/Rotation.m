//
//  Rotation.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Rotation.h"

@implementation Rotation

-(NSString*) description{
    NSString* tablesStr = [self.tables componentsJoinedByString:@", "];
    //taableStr will be replaced by [self.students description]
    return [NSString stringWithFormat: @"{%@}; %i; %i", tablesStr, self.numberOfMeals, self.numberOfTables];
}

-(id) initFromString:(NSString*) string{
    self = [super init];
    if(self){
    }
    return self;
}


@end
