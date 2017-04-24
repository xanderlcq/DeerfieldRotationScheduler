//
//  GenerateRotationVC.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/23/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Rotation.h"
#import "RotationGenerator.h"
@class GenerateRotationVC;

@protocol GenerateRotationVCDelegate <NSObject>

-(void)closeGenRotationVCWithNewRotation:(Rotation*) r students:(NSMutableArray *)studentList andVC:(GenerateRotationVC *)controller;
-(void)closeGenRotationVCWithoutSaving:(GenerateRotationVC *)controller;

@end

@interface GenerateRotationVC : NSViewController <NSTableViewDataSource,NSTableViewDelegate>

@property (nonatomic,weak) id<GenerateRotationVCDelegate>delegate;
@property (weak) IBOutlet NSTableView *studentsListTableView;
@property (weak) IBOutlet NSTableView *rotationTableView;
@property (weak) IBOutlet NSTableView *rotationSelectionTableView;
- (IBAction)addTableButton:(id)sender;
@property (weak) IBOutlet NSTextField *tableSize;
@property (weak) IBOutlet NSTextField *tableQuatity;
@property (weak) IBOutlet NSTableView *tableConfigTableView;
- (IBAction)generateRotationButton:(id)sender;
@property (weak) IBOutlet NSTextField *nameOfRotationOutlet;
@property NSMutableArray *studentList;
@property NSMutableArray *studentListWorkingCopy;
@property NSMutableArray *allRotations;
@property Rotation *rotation;
@end
