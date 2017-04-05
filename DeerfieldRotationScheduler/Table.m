//
//  Table.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Table.h"

@implementation Table

-(id)initWithStudents:(NSMutableArray*) students first:(Student*)firstW andSecond:(Student*)secondW wTable:(int) tableNum{
    self = [super init];
    if(self){
        self.students = students;
        self.firstWaiter = firstW;
        self.secondWaiter = secondW;
        self.tableNumber = tableNum;
    }
    return self;
}

-(NSString*) description{
    NSString* str = [self.students componentsJoinedByString:@", "];
    //str will be replaced by [self.students description]
    return [NSString stringWithFormat: @"{%@}; %@ %@; %@ %@; %i", str, self.firstWaiter.firstName, self.firstWaiter.lastName, self.secondWaiter.firstName, self.secondWaiter.lastName, self.tableNumber];
}

-(id) initFromString:(NSString*) string{
    self = [super init];
    //take in first part of string, feed into init from string for student
    if(self){
        NSArray* studentStrings = [[[(NSString *)[[string componentsSeparatedByString:@";"] firstObject] stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""] componentsSeparatedByString:@", "];
        for (int i = 0; i < [studentStrings count]; i++){
<<<<<<< Updated upstream
            [self.students addObject:[studentStrings objectAtIndex:i]];
||||||| merged common ancestors
            self.students addObject:[studentStrings objectAtIndex:i]
=======
            //init
            self.students addObject:[studentStrings objectAtIndex:i]
>>>>>>> Stashed changes
        }
        //next part of string find student to assign waiters
        //last part for table number
        /*self.students = students;
        self.firstWaiter = firstW;
        self.secondWaiter = secondW;
        self.tableNumber = tableNum;*/
    }
    return self;
}

@end
