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
@property (weak) IBOutlet NSTableView *tableView;
@property NSMutableArray *studentList;
@property (nonatomic,weak) id<EditStudentVCDelegate>delegate;
@end
