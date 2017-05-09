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
    self.studentListWorkingCopy = [self deepCopy:self.studentList];
    [self.studentsListTableView setDelegate:self];
    [self.studentsListTableView setDataSource:self];
    [self.rotationTableView setDelegate:self];
    [self.rotationTableView setDataSource:self];
    [self.rotationSelectionTableView setDelegate:self];
    [self.rotationSelectionTableView setDataSource:self];
    [self.tableConfigTableView setDelegate:self];
    [self.tableConfigTableView setDataSource:self];
    [self.rotationSelectionTableView setAllowsMultipleSelection:YES];
    self.rotation = [[Rotation alloc] initEmptyRotation];
    [self applyAllLockedStudents];
    [self.rotation updateStudentInfo];
    [self refreshView];
    
}
-(void) applyAllLockedStudents{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Apply All Locked Student"];
    [alert addButtonWithTitle:@"Remove All Locks"];
    [alert setMessageText:@"Apply Locks?"];
    [alert setInformativeText:@"Do you want to apply all locked students to their table? or remove all locks"];
    [alert setAlertStyle:NSWarningAlertStyle];
    NSModalResponse response = [alert runModal];
    if(response == NSAlertFirstButtonReturn){
        //NSLog(@"first button");
        for(Student *s in self.studentListWorkingCopy){
            if(s.lockTableNum != -99){
                Table *t = [self.rotation getTableWithNumber:s.lockTableNum];
                if(!t){
                    t = [[Table alloc] initWithSize:1];
                    [t.students addObject:s];
                    t.tableNumber = s.lockTableNum;
                    [self.rotation.tables addObject:t];
                }else{
                    [t.students addObject:s];
                    t.numerOfStudents++;
                }
            }
        }
    }
    if(response == NSAlertSecondButtonReturn){
        for(Student *s in self.studentListWorkingCopy)
            s.lockTableNum = -99;
    }
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
        //NSLog(@"first button");
        [self.delegate closeGenRotationVCWithNewRotation:self.rotation students:self.studentListWorkingCopy andVC:self];
    }
    if(response == NSAlertSecondButtonReturn){
        //NSLog(@"second button");
        [self.delegate closeGenRotationVCWithoutSaving:self];
    }
    
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    //NSLog(@"numberOfRows-%@",tableView.identifier);
    if([tableView.identifier isEqualToString:@"rotationTableView"]){
        return [self.rotation.studentsInfo count];
    }
    if([tableView.identifier isEqualToString:@"studentListTableView"]){
        return [self.studentListWorkingCopy count];
    }
    if([tableView.identifier isEqualToString:@"rotationSelectionTableView"]){
        return [self.allRotations count];
    }
    if([tableView.identifier isEqualToString:@"tableConfigTableView"]){
        return [self.rotation.tables count];
    }
    
    return 0;
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if([tableView.identifier isEqualToString:@"studentListTableView"]){
        Student *s = [self.studentListWorkingCopy objectAtIndex:row];
        return [s valueForKey:[tableColumn identifier]];
    }else if([tableView.identifier isEqualToString:@"rotationTableView"]){
        StudentInfoUnit *s = [self.rotation.studentsInfo objectAtIndex:row];
        return [s valueForKey:[tableColumn identifier]];
    }else if([tableView.identifier isEqualToString:@"rotationSelectionTableView"]){
        Rotation *r = [self.allRotations objectAtIndex:row];
        return [r valueForKey:[tableColumn identifier]];
    }else if([tableView.identifier isEqualToString:@"tableConfigTableView"]){
        Table *t = [self.rotation.tables objectAtIndex:row];
        return [t valueForKey:[tableColumn identifier]];
    }
    return nil;
}
-(void)tableView:(NSTableView *)tableView sortDescriptorsDidChange: (NSArray *)oldDescriptors
{
    NSArray *newDescriptors = [tableView sortDescriptors];
    NSLog(@"%@",[tableView identifier]);
    if([tableView.identifier isEqualToString:@"studentListTableView"])
        [self.studentList sortUsingDescriptors:newDescriptors];
    if([tableView.identifier isEqualToString:@"rotationTableView"])
        [self.rotation.studentsInfo sortUsingDescriptors:newDescriptors];
    if([tableView.identifier isEqualToString:@"rotationSelectionTableView"])
        [self.allRotations sortUsingDescriptors:newDescriptors];
    if([tableView.identifier isEqualToString:@"tableConfigTableView"])
        [self.rotation.tables sortUsingDescriptors:newDescriptors];
    [tableView reloadData];
}
- (IBAction)addTableButton:(id)sender {
    for(int i = 0; i < self.tableQuatity.intValue;i++){
        [self.rotation addEmptyTable:self.tableSize.intValue];
    }
    [self.tableConfigTableView reloadData];
}
-(void)prompWarning:(NSString*)content{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:content];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert runModal];
}
-(BOOL) hasNameDuplicate:(NSString*)name{
    for(Rotation *r in self.allRotations){
        if([r.nameOfRotation isEqualToString:name]){
            return YES;
        }
    }
    return NO;
}
- (IBAction)generateRotationButton:(id)sender {
    double timeInSeconds = [[NSDate date] timeIntervalSince1970];
    NSLog(@"start time%f",timeInSeconds);
    if([self.rotation.tables count] == 0){
        [self prompWarning:@"you must add some tables"];
        return;
    }
    if([self.nameOfRotationOutlet.stringValue isEqualToString:@""]){
        [self prompWarning:@"you must have a table name"];
        return;
    }
    if([self hasNameDuplicate:self.nameOfRotationOutlet.stringValue]){
        [self prompWarning:@"you cannot reuse a rotation name"];
        return;
    }
    if([self.studentListWorkingCopy count] == 0){
        [self prompWarning:@"you must go back and add some students first"];
        return;
    }
    //[self.rotation clearStudentsOnTable];
    NSMutableArray *selectedPastHistory =[self selectedPastHistory];
    RotationGenerator *gen = [[RotationGenerator alloc] initWithEmptyRotation:self.rotation studentList:self.studentListWorkingCopy andPastHistory:selectedPastHistory];
    [gen generateRandomRotation];
    [self.rotation updateStudentInfo];
    self.rotation.nameOfRotation = self.nameOfRotationOutlet.stringValue;
    NSLog(@"start time%f",[[NSDate date] timeIntervalSince1970]-timeInSeconds);
    [self.rotationTableView reloadData];
    
}
-(NSMutableArray *)selectedPastHistory{
    NSMutableArray *selected = [[NSMutableArray alloc] init];
    NSIndexSet *selectedIndexes = [self.rotationSelectionTableView selectedRowIndexes];
    NSUInteger index = [selectedIndexes lastIndex];
    while ( index != NSNotFound )
    {
        [selected addObject:[self.allRotations objectAtIndex:index]];
        index = [selectedIndexes indexLessThanIndex: index];
    }
    return selected;
}

-(NSMutableArray *) deepCopy:(NSMutableArray*)source{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for(Student *t in source){
        Student *n = [[Student alloc] initWithFirstName:t.firstName andLastName:t.lastName grade:t.grade gender:t.gender];
        n.rotationsWaited = t.rotationsWaited;
        n.lockTableNum = t.lockTableNum;
        [copy addObject:n];
    }
    return copy;
}

- (IBAction)lockButton:(id)sender {
    int index = (int)self.studentsListTableView.selectedRow;
    if(index == -1){
        [self prompWarning:@"you must select a student"];
        return;
    }
    Student *stud =[self.studentListWorkingCopy objectAtIndex:index];
    if(stud.lockTableNum!= -99){
        Table *t = [self.rotation getTableWithNumber:stud.lockTableNum];
        [t.students removeObject:stud];
    }
    Table *t = [self.rotation getTableWithNumber:self.lockNumOutlet.intValue];
    if(t){
        if([t.students count] == t.numerOfStudents){
            NSAlert *alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"Increase size by 1"];
            [alert addButtonWithTitle:@"Cancel"];
            [alert setMessageText:@"Table is full!"];
            [alert setInformativeText:@"Do you want to increase the size by 1?"];
            [alert setAlertStyle:NSWarningAlertStyle];
            NSModalResponse response = [alert runModal];
            if(response == NSAlertFirstButtonReturn){
                stud.lockTableNum = self.lockNumOutlet.intValue;
                [t.students addObject:stud];
                [self refreshView];
                t.numerOfStudents++;
                return;
            }
            if(response == NSAlertSecondButtonReturn){
                return;
            }
            
            
        }else{
            stud.lockTableNum = self.lockNumOutlet.intValue;
            [t.students addObject:stud];
            [self refreshView];
            return;
        }
    }else{
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"Add new table"];
        [alert addButtonWithTitle:@"Cancel"];
        [alert setMessageText:@"Table Doesn't exist"];
        [alert setAlertStyle:NSWarningAlertStyle];
        NSModalResponse response = [alert runModal];
        if(response == NSAlertFirstButtonReturn){
            //NSLog(@"first button");
            t = [[Table alloc] initWithSize:1];
            [t.students addObject:stud];
            stud.lockTableNum = self.lockNumOutlet.intValue;
            t.tableNumber = self.lockNumOutlet.intValue;
            [self.rotation.tables addObject:t];
            [self refreshView];
            return;
        }
        if(response == NSAlertSecondButtonReturn){
            return;
        }
    }


}
-(void)refreshView{
    [self.studentsListTableView reloadData];
    [self.tableConfigTableView reloadData];
    [self.rotationTableView reloadData];
}
- (IBAction)unlockButton:(id)sender {
    int index = (int)self.studentsListTableView.selectedRow;
    if(index != -1){
        Student *s = [self.studentListWorkingCopy objectAtIndex:index];
        Table *t = [self.rotation getTableWithNumber:s.lockTableNum];
        [t.students removeObject:s];
        s.lockTableNum = -99;
    }
    [self.studentsListTableView reloadData];
}
@end
