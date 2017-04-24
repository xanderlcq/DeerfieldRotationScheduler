//
//  ViewController.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/28/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "ViewController.h"
#import "Table.h"
#import "Student.h"
#import "Rotation.h"
#import "StudentsSorter.h"
#import "RotationGenerator.h"
#import "StorageHandler.h"

@implementation ViewController
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}
-(void)closeGenRotationVCWithNewRotation:(Rotation*) r students:(NSMutableArray *)studentList andVC:(GenerateRotationVC *)controller{
    [self dismissController:controller];
    [self.allRotations insertObject:r atIndex:0];
    self.studentsList = studentList;
    self.currentDisplayedRotation = r;
    [self refreshView];
    
}
-(void)closeGenRotationVCWithoutSaving:(GenerateRotationVC *)controller{
    [self dismissController:controller];
    [self refreshView];
}

-(void) closeEditStudentVCWithStudentsList:(NSMutableArray *)studentsList vc:(EditStudentVC *)controller{
    NSLog(@"%@",studentsList);
    [self dismissViewController:controller];
    self.studentsList = studentsList;
    [self refreshView];
}
-(void) closeEditStudentVCWithoutSaving:(EditStudentVC *)controller{
    [self dismissViewController:controller];
    [self refreshView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViews];
    StorageHandler *handler = [[StorageHandler alloc] initWithShareApplicationDelegate:[[NSApplication sharedApplication] delegate]];
    self.studentsList = [handler loadMasterStudentListFromCoreData];

    [self refreshView];
}
-(void)viewWillDisappear{
    StorageHandler *handler = [[StorageHandler alloc] initWithShareApplicationDelegate:[[NSApplication sharedApplication] delegate]];
    [handler storeMasterStudentList:self.studentsList];
}
-(void) refreshView{
    [self.currentDisplayedRotation updateStudentInfo];
    [self refreshRotationsPopupMenu];
    [self.rotationTableView reloadData];
    [self.studentsListTableView reloadData];
}
-(void) initializeViews{
    [self.studentsListTableView setDelegate:self];
    [self.studentsListTableView setDataSource:self];
    [self.rotationTableView setDelegate:self];
    [self.rotationTableView setDataSource:self];
    self.allRotations = [[NSMutableArray alloc] init];
}
-(void) refreshRotationsPopupMenu{
    [self.rotationDropDownOutlet removeAllItems];
    for(Rotation *r in self.allRotations){
        [self.rotationDropDownOutlet addItemWithTitle:r.nameOfRotation];
    }
}


-(void)prompWarning:(NSString*)content{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:content];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert runModal];
}
-(void) prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{
    //editStudentsSeg
    if([segue.identifier isEqualToString:@"editStudentsSeg"]){
        NSLog(@"editStudentsSeg");
        EditStudentVC *vc = [segue destinationController];
        vc.delegate = self;
        vc.studentList = [self shallowCopy:self.studentsList];
    }
    if([segue.identifier isEqualToString:@"genRotationSeg"]){
        NSLog(@"genRotationSeg");
        GenerateRotationVC *vc = [segue destinationController];
        vc.delegate = self;
        vc.allRotations = self.allRotations;
        vc.studentList = [self shallowCopy:self.studentsList];
        if([self.studentsList count] == 0){
            [self prompWarning:@"You must have some students first"];
        }
    }
}

-(NSMutableArray *) shallowCopy:(NSMutableArray *) original{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for(int i = 0; i < [original count]; i++){
        [copy insertObject:[original objectAtIndex:i] atIndex:i];
        
    }
    return copy;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    //NSLog(@"numberOfRows-%@",tableView.identifier);
    if([tableView.identifier isEqualToString:@"rotationTableView"]){
        return [self.currentDisplayedRotation.studentsInfo count];
    }
    if([tableView.identifier isEqualToString:@"studentListTableView"]){
        return [self.studentsList count];
    }
    return 0;
}
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    //NSLog(@"%@",tableColumn.identifier);
    if([tableView.identifier isEqualToString:@"studentListTableView"]){
        Student *s = [self.studentsList objectAtIndex:row];
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
        StudentInfoUnit *s = [self.currentDisplayedRotation.studentsInfo objectAtIndex:row];
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
    }
    return cellView;
}
- (IBAction)rotationDropDown:(id)sender {
    NSLog(@"%lu",[self.rotationDropDownOutlet indexOfSelectedItem])
    ;
    self.currentDisplayedRotation = [self.allRotations objectAtIndex:[self.rotationDropDownOutlet indexOfSelectedItem]];
    [self.currentDisplayedRotation updateStudentInfo];
    [self.rotationTableView reloadData];
}
- (IBAction)exportRotationButton:(id)sender {
    if(!self.currentDisplayedRotation){
        return;
    }
    [self.currentDisplayedRotation updateStudentInfo];
    DataProc *proc = [[DataProc alloc] init];
    NSString *cvs  = [proc convertRotationToCVSString:self.currentDisplayedRotation];
    [proc promptSaveDialogWithContent:cvs withDefaultFileName:[NSString stringWithFormat:@"%@%@",self.currentDisplayedRotation.nameOfRotation,@".csv"]];
}

- (IBAction)deleteRotationButton:(id)sender {
    [self.allRotations removeObject:self.currentDisplayedRotation];
    self.currentDisplayedRotation = [self.allRotations firstObject];
    [self refreshView];
    
}
@end
