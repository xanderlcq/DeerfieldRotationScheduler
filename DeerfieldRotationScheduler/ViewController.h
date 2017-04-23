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
#import "Rotation.h"
#import "GenerateRotationVC.h"


@interface ViewController : NSViewController <EditStudentVCDelegate,NSTableViewDataSource,NSTableViewDelegate,GenerateRotationVCDelegate>

@property NSMutableArray *studentsList;
@property NSMutableArray *allRotations;
@property Rotation *currentDisplayedRotation;
@property (weak) IBOutlet NSTableView *studentsListTableView;
- (IBAction)rotationDropDown:(id)sender;
@property (weak) IBOutlet NSPopUpButton *rotationDropDownOutlet;
@property (weak) IBOutlet NSTableView *rotationTableView;
- (IBAction)exportRotationButton:(id)sender;

@end

