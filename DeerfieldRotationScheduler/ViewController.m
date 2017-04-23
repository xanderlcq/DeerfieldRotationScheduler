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

@implementation ViewController

-(void) closeWithStudentsList:(NSMutableArray *)studentsList vc:(EditStudentVC *)controller{
    NSLog(@"%@",studentsList);
    [self dismissViewController:controller];
    self.studentsList = studentsList;
    [self.studentsListTableView reloadData];
}
-(void) closeWithoutSaving:(EditStudentVC *)controller{
    [self dismissViewController:controller];
    [self.studentsListTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    Student *s1 = [[Student alloc] initWithFirstName:@"Xander" andLastName:@"Li" grade:12 gender:@"M"];
    Student *s2 = [[Student alloc] initWithFirstName:@"Gid" andLastName:@":)" grade:11 gender:@"M"];
    Student *s3 = [[Student alloc] initWithFirstName:@"Sarah" andLastName:@"Du" grade:12 gender:@"F"];
    Student *s4 = [[Student alloc] initWithFirstName:@"Kate" andLastName:@":)" grade:9 gender:@"F"];
    Student *s5 = [[Student alloc] initWithFirstName:@"Extra" andLastName:@":)" grade:9 gender:@"F"];

    self.studentsList = [[NSMutableArray alloc] initWithObjects:s1,s2,s3,s4,s5, nil];
    //NSLog(@"%lu",[self.studentsList count]);
    
    self.currentDisplayedRotation =[[Rotation alloc] initEmptyRotation];
    [self.currentDisplayedRotation addEmptyTable:2];
    [self.currentDisplayedRotation addEmptyTable:2];
    RotationGenerator *gen = [[RotationGenerator alloc] initWithEmptyRotation:self.currentDisplayedRotation studentList:self.studentsList andPastHistory:[[NSMutableArray alloc] init]];
    [gen generateRandomRotation];
    
    [self.currentDisplayedRotation updateStudentInfo];
    NSLog(@"%@",self.currentDisplayedRotation);
    
    [self.studentsListTableView setDelegate:self];
    [self.studentsListTableView setDataSource:self];
    [self.rotationTableView setDelegate:self];
    [self.rotationTableView setDataSource:self];
    
    
    self.currentDisplayedRotation.nameOfRotation = @"abc";
    self.allRotations = [[NSMutableArray alloc] initWithObjects:self.currentDisplayedRotation, nil];    
    [self refreshRotationsPopupMenu];
    
    DataProc *proc = [[DataProc alloc] init];
    NSString *rotationCvs = [proc convertRotationToCVSString:self.currentDisplayedRotation];
    NSString *studentListCvs = [proc convertStudentListToCSVString:self.currentDisplayedRotation.students];
    NSString *rotationName =[[rotationCvs componentsSeparatedByString:@","] objectAtIndex:0];
    NSMutableArray *restoredInfoUnits = [proc convertCVSStringToRotationInfoUnits:rotationCvs];
    NSMutableArray *restoredStudentsList = [proc makeStudentsFromString:studentListCvs];
    Rotation *restoredRotation = [[Rotation alloc] initFromCVSStringWithStudentsList:restoredStudentsList infoUnits:restoredInfoUnits andNameOfRotation:rotationName];
    
    NSLog(@"check");
}


-(void) refreshRotationsPopupMenu{
    [self.rotationDropDownOutlet removeAllItems];
    for(Rotation *r in self.allRotations){
        [self.rotationDropDownOutlet addItemWithTitle:r.nameOfRotation];
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}
-(void) prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{
    //editStudentsSeg
    if([segue.identifier isEqualToString:@"editStudentsSeg"]){
        NSLog(@"editStudentsSeg");
        EditStudentVC *vc = [segue destinationController];
        vc.delegate = self;
        vc.studentList = [self shallowCopy:self.studentsList];
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
@end
