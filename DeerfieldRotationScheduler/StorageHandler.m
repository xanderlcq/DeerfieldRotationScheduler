//
//  StorageHandler.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/23/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "StorageHandler.h"

@implementation StorageHandler

-(id) initWithShareApplicationDelegate:(id) del{
    self = [super init];
    if(self){
        self.cdHandler =[[ArrayCoreDataHandler alloc] init];
        self.cdHandler.delegate = del;
    }
    return self;
}

-(void)storeAllRotations:(NSMutableArray*)allRotations{
    NSLog(@"Storing Master Student List, size: %lu",(unsigned long)[allRotations count]);
    NSMutableArray *storingArray = [[NSMutableArray alloc] init];
    for(Rotation *r in allRotations){
        [r updateStudentInfo];
        DataProc *proc = [[DataProc alloc] init];
        NSString *infoCSV = [proc convertRotationToCVSString:r];
        NSString *studentCSV = [proc convertStudentListToCSVString:r.students];
        [storingArray addObject:infoCSV];
        [storingArray addObject:studentCSV];
    }
    
    [self.cdHandler deleteAllEntities:@"AllRotations"];
    [self.cdHandler saveArray:storingArray entity:@"AllRotations" key:@"array"];
}
-(NSMutableArray *) loadAllRotationsFromCoreData{
    NSArray *rotationStoringArray = [self.cdHandler loadArray:@"AllRotations" key:@"array"];
    NSMutableArray *allRotations = [[NSMutableArray alloc] init];
    for(int i = 0; i < [rotationStoringArray count];i+=2){
        DataProc *proc = [[DataProc alloc] init];
        NSString *infoUnitsCSV =[rotationStoringArray objectAtIndex:i];
        NSString *studentListCSV =[rotationStoringArray objectAtIndex:i+1];
        NSMutableArray *infoUnits = [proc convertCVSStringToRotationInfoUnits:infoUnitsCSV];
        NSMutableArray *studentList = [proc makeStudentsFromString:studentListCSV];
        NSString *nameOfRotation = [[infoUnitsCSV componentsSeparatedByString:@","] objectAtIndex:0];
        Rotation *new = [[Rotation alloc]initWithStudentsList:studentList infoUnits:infoUnits andNameOfRotation:nameOfRotation];
        [allRotations addObject:new];
    }
    NSLog(@"Loading all rotations, size: %lu",(unsigned long)[allRotations count]);
    return allRotations;
}

-(void)storeMasterStudentList:(NSMutableArray *)studentList{
    NSLog(@"Storing Master Student List, size: %lu",(unsigned long)[studentList count]);
    NSMutableArray *storingArray = [[NSMutableArray alloc] init];
    DataProc *proc = [[DataProc alloc] init];
    NSString *studentCSV = [proc convertStudentListToCSVString:studentList];
    [storingArray addObject:studentCSV];

    [self.cdHandler deleteAllEntities:@"MasterStudentList"];
    [self.cdHandler saveArray:storingArray entity:@"MasterStudentList" key:@"array"];
}
-(NSMutableArray *) loadMasterStudentListFromCoreData{

    NSArray *array = [self.cdHandler loadArray:@"MasterStudentList" key:@"array"];
    if([array count] == 0)
        return [[NSMutableArray alloc]init];
    NSString *studentCSV = [array objectAtIndex:0];
    DataProc *proc = [[DataProc alloc] init];
    NSMutableArray *studentList =[proc makeStudentsFromString:studentCSV];
    NSLog(@"Loading Master Student List, size: %lu",(unsigned long)[studentList count]);
    return studentList;
}

@end
