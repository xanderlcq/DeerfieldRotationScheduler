
//
//  DataProc.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "DataProc.h"

@implementation DataProc

//Info unites - CSV
-(NSString *)convertRotationToCVSString:(Rotation *)r{
    NSString *result = [NSString stringWithFormat:@"%@,,,\nTable Number,First Name,Last Name,Waiter\n",r.nameOfRotation];
    [r updateStudentInfo];
    for(StudentInfoUnit *i in r.studentsInfo){
        result = [NSString stringWithFormat:@"%@%d,%@,%@,%@\n",result,i.tableNumber,i.firstName,i.lastName,i.waiter];
    }
    
    return result;
}

-(NSMutableArray*)convertCVSStringToRotationInfoUnits:(NSString*)str{
    NSArray *lines = [str componentsSeparatedByString:@"\n"];
    NSMutableArray *infoUnits = [[NSMutableArray alloc] init];
    for(int i = 2; i < [lines count];i++){
        NSArray *components = [[lines objectAtIndex:i] componentsSeparatedByString:@","];
        if([components count]!=4 )
            continue;
        StudentInfoUnit *u = [[StudentInfoUnit alloc] init];
        u.firstName = [components objectAtIndex:1];
        u.lastName = [components objectAtIndex:2];
        u.tableNumber = [[components objectAtIndex:0] intValue];
        u.waiter = [components objectAtIndex:3];
        [infoUnits addObject:u];
    }
    return infoUnits;
}

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


-(NSString *) convertStudentListToCSVString:(NSMutableArray *) list{
    NSString* cvsString = @"First Name,Last Name,Gender,Grade,Locked Table #,Rotations Waited,New Student,Day Student\n";
    for(Student* stud in list){
        cvsString = [NSString stringWithFormat:@"%@%@,%@,%@,%i,%i,%f,%hhd,%hhd\n", cvsString, stud.firstName, stud.lastName, stud.gender, stud.grade,stud.lockTableNum,stud.rotationsWaited,stud.newStudent,stud.dayStudent];
    }
    return cvsString;
}

-(NSMutableArray*)makeStudentsFromString:(NSString*)str{
    NSArray* allStudentStrings = [str componentsSeparatedByString:@"\n"];
    NSMutableArray* allStudents = [[NSMutableArray alloc] init];
    for(int i = 1; i < allStudentStrings.count; i++){
        NSString* individualStudentString = [allStudentStrings objectAtIndex:i];
        NSArray* a = [individualStudentString componentsSeparatedByString:@","];
        if([a count]!=8)
            continue;
        NSString* firstName = [a objectAtIndex:0];
        NSString* lastName = [a objectAtIndex:1];
        NSString* gender = [[a objectAtIndex:2] stringByReplacingOccurrencesOfString:@" " withString:@""];
        int grade = [[a objectAtIndex:3] intValue];
        int lockedTableNum = [[a objectAtIndex:4] intValue];
        Student* s = [[Student alloc] initWithFirstName:firstName andLastName:lastName grade:grade gender:gender];
        s.lockTableNum = lockedTableNum;
        float rotationWaited = [[a objectAtIndex:5] floatValue];
        s.rotationsWaited = rotationWaited;
        s.newStudent = [@"1" isEqualToString:[a objectAtIndex:6]];
        s.dayStudent = [((NSString *)[a objectAtIndex:7]) containsString:@"1"];

        [allStudents addObject: s];
    }
    return allStudents;
}


@end
