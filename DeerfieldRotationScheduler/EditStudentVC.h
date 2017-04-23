//
//  EditStudentVC.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/18/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Student.h"
#import "DataProc.h"
@class EditStudentVC;
@protocol EditStudentVCDelegate <NSObject>

-(void) closeEditStudentVCWithStudentsList:(NSMutableArray *)studentsList vc:(EditStudentVC *)controller;
-(void) closeEditStudentVCWithoutSaving:(EditStudentVC *)controller;

@end

@interface EditStudentVC : NSViewController <NSTableViewDataSource,NSTableViewDelegate>

@property (weak) IBOutlet NSTextField *genderInput;
@property (weak) IBOutlet NSTextField *gradeInput;
@property (weak) IBOutlet NSTextField *lastNameInput;
@property (weak) IBOutlet NSTextField *firstNameInput;
- (IBAction)exportTemplateButton:(id)sender;
- (IBAction)importListButton:(id)sender;
- (IBAction)exportListButton:(id)sender;

@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)addStudentButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

@property NSMutableArray *studentList;

@property (nonatomic,weak) id<EditStudentVCDelegate>delegate;

@end
