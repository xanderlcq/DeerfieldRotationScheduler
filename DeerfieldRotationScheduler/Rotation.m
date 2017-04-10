//
//  Rotation.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Rotation.h"
#import "Table.h"

@implementation Rotation

-(NSString*) description{
    NSString* tablesStr = [self.tables componentsJoinedByString:@", "];
    //taableStr will be replaced by [self.students description]
    return [NSString stringWithFormat: @"{%@}; %i; %i", tablesStr, self.numberOfMeals, self.numberOfTables];
}

//for testing purposes/init without string
-(id) initWithTables:(NSMutableArray*)tables andMeals:(int)numMeals andTables:(int)numTables{
    self = [super init];
    if (self){
        self.tables = tables;
        self.numberOfMeals = numMeals;
        self.numberOfTables = numTables;
    }
    return self;
}
-(id) initEmptyRotationWithNumOfMeals:(int) numOfMeals andNumOfTables:(int) numOfTables{
    
    self = [super init];
    if (self){
        self.tables = [[NSMutableArray alloc] init];
        self.numberOfMeals = numOfMeals;
        self.numberOfTables = numOfTables;
    }
    return self;
    
}
-(id) initFromString:(NSString*) string{
    self = [super init];
    if(self){
        NSArray* tableStrings = [[[(NSString *)[[string componentsSeparatedByString:@";"] firstObject] stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""] componentsSeparatedByString:@", "];
        
        //add students to self.students
        for (int i = 0; i < [tableStrings count]; i++){
            NSString* tableString = [tableStrings objectAtIndex:i];
            //            Table *newT = [[Table alloc]initFromString:tableString]
            //            [self.tables addObject:newT];
        }
        self.numberOfMeals = [[[string componentsSeparatedByString:@";"] objectAtIndex:1]intValue];
        self.numberOfTables =  [[[string componentsSeparatedByString:@";"] objectAtIndex:2]intValue];
    }
    return self;
}

//check if at same table - assuming each student has already been assigned to a table. Will be true if bothunassigned to a table
-(BOOL) student:(Student*) first isSittingWith:(Student *) second{
    int firstTableNum = 0;
    int secTableNum = 0;
    for (Table *table in self.tables) {
        for (Student *student in self.students) {
            if ([student isEqual:first]){
                firstTableNum = table.tableNumber;
            }
            if ([student isEqual:second]){
                secTableNum = table.tableNumber;
            }
        }
    }
    if (firstTableNum == secTableNum){
        return YES;
    }
    return NO;
}

@end
