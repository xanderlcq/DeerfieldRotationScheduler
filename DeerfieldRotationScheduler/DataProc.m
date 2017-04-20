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
        NSString* gender = names[2];
        //NSString* grade = names[3];
        firstName = [firstName stringByReplacingOccurrencesOfString:@" " withString:@""];
        Student* s = [[Student alloc] initWithFirstName:firstName andLastName:lastName gender:gender];
        [students addObject:s];
    }
    //Fix format
    return students;
}
-(void) writeToFile:(NSString *) filePath withContent:(NSString *)content{
    NSLog(@"%@",filePath);
    NSLog(@"%@",content);
    [content writeToFile:filePath atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
}
-(NSString *) readFileToStringWithPath:(NSString *) filePath{
    return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
}

//defaultName example: @"students.csv"
- (void)promptSaveDialogWithContent:(NSString *) content withDefaultFileName:(NSString *)defaultName{
    
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:defaultName];
    
    if([panel runModal] == NSModalResponseOK){
        [self writeToFile:[[panel URL] path] withContent:content];
    }
}
- (NSString *) openCSVInDialogToString{
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    
    [panel setCanChooseFiles:YES];
    [panel setFloatingPanel:YES];
    [panel setAllowsMultipleSelection:NO];
    NSArray* fileTypes = [NSArray arrayWithObjects:@"csv", @"CSV", nil];
    [panel setAllowedFileTypes:fileTypes];
    [panel setCanChooseDirectories:NO];
    
    if ( [panel runModal] == NSModalResponseOK )
    {
        NSString *path = [[panel URL] path];
        return [self readFileToStringWithPath:path];
    }
    return nil;
}
@end
