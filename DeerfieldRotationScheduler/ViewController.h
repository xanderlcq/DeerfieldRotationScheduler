//
//  ViewController.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/28/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DataProc.h"
#import "EditStudentVC.h"


@interface ViewController : NSViewController <EditStudentVCDelegate>

@property NSMutableArray *studentsList;

@end

