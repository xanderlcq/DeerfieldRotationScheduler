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
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.studentList count];
}
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    NSLog(@"%@",[tableColumn identifier]);
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
    if([[tableColumn identifier] isEqualToString:@"lastNameCol"]){
        cellView.textField.stringValue = [NSString stringWithFormat:@"%i",s.grade];
    }
    return cellView;
}
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *tableView = notification.object;
    NSLog(@"User has selected row %ld", (long)tableView.selectedRow);
    [self.tableView reloadData];
}

@end
