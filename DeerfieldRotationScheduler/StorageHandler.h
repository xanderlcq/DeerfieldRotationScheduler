//
//  StorageHandler.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/23/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArrayCoreDataHandler.h"
#import "Rotation.h"
#import "DataProc.h"
@interface StorageHandler : NSObject
@property ArrayCoreDataHandler *cdHandler;
-(void)storeAllRotations:(NSMutableArray*)allRotations;
-(NSMutableArray *) loadMasterStudentListFromCoreData;
-(void)storeMasterStudentList:(NSMutableArray *)studentList;
-(id) initWithShareApplicationDelegate:(id) del;
@end
