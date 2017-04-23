//
//  GenerateRotationVC.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/23/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "GenerateRotationVC.h"

@interface GenerateRotationVC ()

@end

@implementation GenerateRotationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.studentsListTableView setDelegate:self];
    [self.studentsListTableView setDataSource:self];
    [self.rotationTableView setDelegate:self];
    [self.rotationTableView setDataSource:self];
    [self.rotationSelectionTableView setDelegate:self];
    [self.rotationSelectionTableView setDataSource:self];
}
-(void) viewWillDisappear{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Save"];
    [alert addButtonWithTitle:@"Discard"];
    [alert setMessageText:@"Exiting Student Edit Screen"];
    [alert setInformativeText:@"Do you want to save your changes?"];
    [alert setAlertStyle:NSWarningAlertStyle];
    NSModalResponse response = [alert runModal];
    if(response == NSAlertFirstButtonReturn){
        NSLog(@"first button");
        [self.delegate closeGenRotationVCWithNewRotation:self.rotation andVC:self];
    }
    if(response == NSAlertSecondButtonReturn){
        NSLog(@"second button");
        [self.delegate closeGenRotationVCWithoutSaving:self];
    }
    
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    //NSLog(@"numberOfRows-%@",tableView.identifier);
    if([tableView.identifier isEqualToString:@"rotationTableView"]){
        return [self.rotation.studentsInfo count];
    }
    if([tableView.identifier isEqualToString:@"studentListTableView"]){
        return [self.studentList count];
    }
    if([tableView.identifier isEqualToString:@"rotationSelectionTableView"]){
        return [self.allRotations count];
    }
    return 0;
}
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    //NSLog(@"%@",tableColumn.identifier);
    if([tableView.identifier isEqualToString:@"studentListTableView"]){
        Student *s = [self.studentList objectAtIndex:row];
        if([[tableColumn identifier] isEqualToString:@"firstNameCol"]){
            cellView.textField.stringValue = s.firstName;
        }
        if([[tableColumn identifier] isEqualToString:@"lastNameCol"]){
            cellView.textField.stringValue = s.lastName;
        }
        if([[tableColumn identifier] isEqualToString:@"genderCol"]){
            cellView.textField.stringValue = s.gender;
        }
        if([[tableColumn identifier] isEqualToString:@"gradeCol"]){
            cellView.textField.stringValue = [NSString stringWithFormat:@"%i",s.grade];
        }
    }else if([tableView.identifier isEqualToString:@"rotationTableView"]){
        StudentInfoUnit *s = [self.rotation.studentsInfo objectAtIndex:row];
        //NSLog(@"%@",s.waiter);
        if([[tableColumn identifier] isEqualToString:@"firstNameCol"]){
            cellView.textField.stringValue = [s firstName];
        }
        if([[tableColumn identifier] isEqualToString:@"lastNameCol"]){
            cellView.textField.stringValue = [s lastName];
        }
        if([[tableColumn identifier] isEqualToString:@"genderCol"]){
            cellView.textField.stringValue = [s gender];
        }
        if([[tableColumn identifier] isEqualToString:@"gradeCol"]){
            cellView.textField.stringValue = [s grade];
        }
        if([[tableColumn identifier] isEqualToString:@"tableNumCol"]){
            cellView.textField.stringValue = [s tableNum];
        }
        if([[tableColumn identifier] isEqualToString:@"waiterCol"]){
            cellView.textField.stringValue = [s waiter];
        }
    }else if([tableView.identifier isEqualToString:@"rotationSelectionTableView"]){
        Rotation *r = [self.allRotations objectAtIndex:row];
        cellView.textField.stringValue = r.nameOfRotation;
        
    }
    return cellView;
}
@end
