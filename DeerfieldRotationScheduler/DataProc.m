//
//  DataProc.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "DataProc.h"

@implementation DataProc

-(NSMutableArray *)readNames:(NSString *)fileName{
    NSString* filepath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    // make the file a string
    NSString* allFile = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    // break the file up by lines
    NSArray* allLines = [allFile componentsSeparatedByString:@"\n"];
    // break the lines up by spaces
    
    NSMutableArray* students = [[NSMutableArray alloc] init];
    for(int i = 0; i < allLines.count; i++){
        Student* s = [[Student alloc] init];
        s.firstName = allLines[i];
        [students addObject:s];
    }
    for(int i = 0; i < students.count; i++){
        Student* s = students[i];
        NSLog(@"Name: %@", s.firstName);
    }
    return students;
}

@end
