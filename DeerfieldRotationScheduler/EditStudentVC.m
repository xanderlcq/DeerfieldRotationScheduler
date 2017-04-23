//
//  EditStudentVC.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 4/18/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "EditStudentVC.h"


@implementation EditStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setAllowsMultipleSelection:YES];
    [self.tableView setAllowsColumnSelection:YES];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.studentList count];
}
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    //NSLog(@"%@",[tableColumn identifier]);
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
    return cellView;
}
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *tableView = notification.object;
    NSLog(@"User has selected row %@ column %@", tableView.selectedRowIndexes,tableView.selectedColumnIndexes);
#warning sort the list when a column is selected

    
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
            [self.delegate closeEditStudentVCWithStudentsList:self.studentList vc:self];
        }
        if(response == NSAlertSecondButtonReturn){
            NSLog(@"second button");
            [self.delegate closeEditStudentVCWithoutSaving:self];
        }
    
}

- (IBAction)addStudentButton:(id)sender {
    NSLog(@"add student button");
    NSString *grade =[self.gradeInput.stringValue stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![grade isEqualToString: @"9"]&&![grade isEqualToString: @"10"]&&![grade isEqualToString: @"11"]&&![grade isEqualToString: @"12"]){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Invalid format"];
        [alert setInformativeText:@"Please enter a valid grade (9-12)"];
        [alert setAlertStyle:NSWarningAlertStyle];
        if([alert runModal] == NSAlertFirstButtonReturn){
            return;
        }
    }
#warning CHECK First/Last Name input is not empty!
#warning Check if gender is "M" or "F"
    
    Student *s = [[Student alloc] initWithFirstName:self.firstNameInput.stringValue andLastName:self.lastNameInput.stringValue grade:self.gradeInput.intValue gender:self.genderInput.stringValue];
    [self.studentList addObject:s];
    [self.tableView reloadData];
}

- (IBAction)deleteButton:(id)sender {
    NSIndexSet *selectedIndexes = [self.tableView selectedRowIndexes];
    NSUInteger index = [selectedIndexes lastIndex];
    while ( index != NSNotFound )
    {
        
        [self.studentList removeObjectAtIndex:index];
        index = [selectedIndexes indexLessThanIndex: index];
    }
    [self.tableView reloadData];
}



- (IBAction)exportTemplateButton:(id)sender {
    NSString *templateContent = @"First Name,Last Name,Gender,Grade\nXander,Li,M,12\nSarah,Du,F,12\nGideo,Yektai,M,11";
    DataProc *proc = [[DataProc alloc] init];
    [proc promptSaveDialogWithContent:templateContent withDefaultFileName:@"student list template.csv"];
}

- (IBAction)importListButton:(id)sender {
    DataProc *proc = [[DataProc alloc] init];
    NSString *result = [proc openCSVInDialogToString];
    NSMutableArray *imported = [proc makeStudentsFromString:result];
    for(Student *stud in imported){
        [self.studentList addObject:stud];
    }
    [self.tableView reloadData];
    NSLog(@"%@",result);
#warning ENFORE CSV Format check
#warning  check for duplicate
}

- (IBAction)exportListButton:(id)sender {
    DataProc *proc = [[DataProc alloc] init];
    NSString *content = [proc convertStudentListToCSVString:self.studentList];
    [proc promptSaveDialogWithContent:content withDefaultFileName:@"Student List.csv"];
}
@end
