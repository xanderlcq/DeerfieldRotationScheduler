//
//  DataProc.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/29/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Student.h"
#import "Rotation.h"

@interface DataProc : NSObject
//Read names list
-(NSMutableArray *)readNamesToStudents:(NSString *)fileName;

- (void) writeToFile:(NSString *) filePath withContent:(NSString *)content;
- (NSString *) readFileToStringWithPath:(NSString *) filePath;

//defaultName example: @"students.csv"
- (void)promptSaveDialogWithContent:(NSString *) content withDefaultFileName:(NSString *)defaultName;
- (NSString *) openCSVInDialogToString;
- (NSString *) convertStudentListToCSVString:(NSMutableArray *) list;

- (NSMutableArray*) makeStudentsFromString:(NSString*) str;



#warning change the name of this
- (NSString *)convertRotationToCVSString:(Rotation *)r;
- (NSMutableArray*)convertCVSStringToRotationInfoUnits:(NSString*)str;
@end
