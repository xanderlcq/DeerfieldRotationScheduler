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
    NSLog(@"User has selected row %@", tableView.selectedRowIndexes);

    
}
-(void) viewWillDisappear{
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"Save"];
    [alert addButtonWithTitle:@"Discard"];
        [alert setMessageText:@"Invalid format"];
        [alert setInformativeText:@"Please enter a valid grade (9-12)"];
        [alert setAlertStyle:NSWarningAlertStyle];
        NSModalResponse response = [alert runModal];
        if(response == NSAlertFirstButtonReturn){
            NSLog(@"first button");
            [self.delegate closeWithStudentsList:self.studentList vc:self];
        }
        if(response == NSAlertSecondButtonReturn){
            NSLog(@"second button");
            [self.delegate closeWithoutSaving:self];
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
        index = [selectedIndexes indexGreaterThanIndex: index];
    }
    [self.tableView reloadData];
}
-(void) writeToFile:(NSString *) filePath withContent:(NSString *)content{
    NSLog(@"%@",filePath);
    NSLog(@"%@",content);
    [content writeToFile:filePath
              atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
}

//defaultName example: @"students.csv"
- (void)promptSaveDialogWithContent:(NSString *) content withDefaultFileName:(NSString *)defaultName{
    // create the save panel
    NSSavePanel *panel = [NSSavePanel savePanel];
    
    // set a new file name
    [panel setNameFieldStringValue:defaultName];
    
    // display the panel
    if([panel runModal] == NSModalResponseOK){
        NSURL *saveURL = [panel URL];
        NSLog(@"%@",[saveURL path]);
        [self writeToFile:[saveURL path] withContent:content];
    }
}
- (void)testOpenDialog {
    NSLog(@"123");
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:YES];
    
    // Multiple files not allowed
    [openDlg setAllowsMultipleSelection:YES];
    
    // Can't select a directory
    [openDlg setCanChooseDirectories:NO];
    
    // Display the dialog. If the OK button was pressed,
    // process the files.
    if ( [openDlg runModal] == NSModalResponseOK )
    {
        // Get an array containing the full filenames of all
        // files and directories selected.
        NSArray* filesURLs = [openDlg URLs];
        
        // Loop through all the files and process them.
        for(NSURL *u in filesURLs){
            NSLog(@"%@",[u path]);
        }
    }
}
- (IBAction)exportTemplateButton:(id)sender {
    [self testSaveDialog];
}
@end
