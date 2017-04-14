//
//  DataProc.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "DataProc.h"

@implementation DataProc

-(NSMutableArray *)readNamesToStudents:(NSString *)fileName{
    NSString* filepath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    // make the file a string
    NSString* allFile = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    // break the file up by lines
    NSArray* allLines = [allFile componentsSeparatedByString:@"\n"];
    
    NSMutableArray* students = [[NSMutableArray alloc] init];
    for(int i = 0; i < [allLines count]-1; i++){
        NSArray* names = [allLines[i] componentsSeparatedByString:@","];
        NSString* lastName = names[0];
        NSString* firstName = names[1];
        firstName = [firstName stringByReplacingOccurrencesOfString:@" " withString:@""];
        Student* s = [[Student alloc] initWithFirstName:firstName andLastName:lastName];
        [students addObject:s];
    }
    //Fix format
    return students;
}

@end
