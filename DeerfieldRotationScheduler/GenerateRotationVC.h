//
//  GenerateRotationVC.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/23/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Rotation.h"
@class GenerateRotationVC;

@protocol GenerateRotationVCDelegate <NSObject>

-(void)closeGenRotationVCWithNewRotation:(Rotation*) r andVC:(GenerateRotationVC *)controller;
-(void)closeGenRotationVCWithoutSaving:(GenerateRotationVC *)controller;

@end

@interface GenerateRotationVC : NSViewController <NSTableViewDataSource,NSTableViewDelegate>

@property (nonatomic,weak) id<GenerateRotationVCDelegate>delegate;
@property (weak) IBOutlet NSTableView *studentsListTableView;
@property (weak) IBOutlet NSTableView *rotationTableView;
@property (weak) IBOutlet NSTableView *rotationSelectionTableView;

@property NSMutableArray *studentList;
@property NSMutableArray *allRotations;
@property Rotation *rotation;
@end
