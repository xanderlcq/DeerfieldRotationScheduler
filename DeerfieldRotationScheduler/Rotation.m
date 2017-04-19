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
    return [NSString stringWithFormat: @"Tables: {%@}; Number of tables: %i", tablesStr, self.numberOfTables];
}

//for testing purposes/init without string
//-(id) initWithTables:(NSMutableArray*)tables andMeals:(int)numMeals andTables:(int)numTables{
//    self = [super init];
//    if (self){
//        self.tables = tables;
//        self.numberOfMeals = numMeals;
//    }
//    return self;
//}
-(id) initEmptyRotation{
    
    self = [super init];
    if (self){
        self.tables = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void) addEmptyTable:(int) tableSize{
    Table *t =[[Table alloc] initWithSize:tableSize];
    t.tableNumber = (int)[self.tables count];
    [self.tables addObject:t];
}
//-(id) initFromString:(NSString*) string{
//    self = [super init];
//    if(self){
//        NSArray* tableStrings = [[[(NSString *)[[string componentsSeparatedByString:@";"] firstObject] stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""] componentsSeparatedByString:@", "];
//        
//        //add students to self.students
//        for (int i = 0; i < [tableStrings count]; i++){
//            NSString* tableString = [tableStrings objectAtIndex:i];
//            //            Table *newT = [[Table alloc]initFromString:tableString]
//            //            [self.tables addObject:newT];
//        }
//        self.numberOfMeals = [[[string componentsSeparatedByString:@";"] objectAtIndex:1]intValue];
//        self.numberOfTables =  [[[string componentsSeparatedByString:@";"] objectAtIndex:2]intValue];
//    }
//    return self;
//}
-(int) numberOfTables{
    return (int)[self.tables count];
}
//check if at same table - assuming each student has already been assigned to a table. Will be true if bothunassigned to a table
-(BOOL) student:(Student*) first isSittingWith:(Student *) second{
    for (Table *table in self.tables) {
        if([table student:first isSittingWith:second])
            return YES;
    }
    return NO;
}

//write to text file?? 

@end
