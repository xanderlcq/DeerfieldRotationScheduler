//
//  EditStudentVC.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/18/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Student.h"

@class EditStudentVC;
@protocol EditStudentVCDelegate <NSObject>

-(void) closeWithStudentsList:(NSMutableArray *)studentsList vc:(EditStudentVC *)controller;

@end


@interface EditStudentVC : NSViewController <NSTableViewDataSource,NSTableViewDelegate>
@property (weak) IBOutlet NSTextField *genderInput;
@property (weak) IBOutlet NSTextField *gradeInput;
@property (weak) IBOutlet NSTextField *lastNameInput;
@property (weak) IBOutlet NSTextField *firstNameInput;
- (IBAction)returnButton:(id)sender;
@property (weak) IBOutlet NSTableView *tableView;
- (IBAction)addStudentButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

@property NSMutableArray *studentList;
@property (nonatomic,weak) id<EditStudentVCDelegate>delegate;
@end
