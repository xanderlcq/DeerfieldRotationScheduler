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
    if([[tableColumn identifier] isEqualToString:@"rotationWaitedCol"]){
        cellView.textField.stringValue = [NSString stringWithFormat:@"%i",s.rotationsWaited];
    }
    return cellView;
}
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *tableView = notification.object;
    NSLog(@"User has selected row %@ column %@", tableView.selectedRowIndexes,tableView.selectedColumnIndexes);

    
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
            [self.delegate closeEditStudentVCWithStudentsList:self.studentList vc:self];
        }
        if(response == NSAlertSecondButtonReturn){

            [self.delegate closeEditStudentVCWithoutSaving:self];
        }
    
}

- (IBAction)addStudentButton:(id)sender {
    //NSLog(@"add student button");
    NSString *grade =[self.gradeInput.stringValue stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *first =self.firstNameInput.stringValue;
    NSString *last =self.lastNameInput.stringValue;
    NSString *gender =self.genderInput.stringValue;
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
    if([first isEqualToString:@""] || [last isEqualToString:@""]){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Invalid format"];
        [alert setInformativeText:@"Please enter a valid name"];
        [alert setAlertStyle:NSWarningAlertStyle];
        if([alert runModal] == NSAlertFirstButtonReturn){
            return;
        }
    }
    if(![gender isEqualToString:@"M"] || ![gender isEqualToString:@"F"]){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Invalid format"];
        [alert setInformativeText:@"Please enter a valid gender (M/F)"];
        [alert setAlertStyle:NSWarningAlertStyle];
        if([alert runModal] == NSAlertFirstButtonReturn){
            return;
        }
    }
    Student *s = [[Student alloc] initWithFirstName:first andLastName:last grade:self.gradeInput.intValue gender:gender];
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
        for(Student *existed in self.studentList)
            if([stud.firstName isEqualToString:existed.firstName] && [stud.lastName isEqualToString:existed.lastName])
                continue;
        [self.studentList addObject:stud];
    }
    [self.tableView reloadData];
}

- (IBAction)exportListButton:(id)sender {
    DataProc *proc = [[DataProc alloc] init];
    NSString *content = [proc convertStudentListToCSVString:self.studentList];
    [proc promptSaveDialogWithContent:content withDefaultFileName:@"Student List.csv"];
}
@end
