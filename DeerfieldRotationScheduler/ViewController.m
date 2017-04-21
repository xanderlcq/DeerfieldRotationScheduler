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
}
-(void) closeWithoutSaving:(EditStudentVC *)controller{
    [self dismissViewController:controller];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.studentsListTableView setDelegate:self];
    [self.studentsListTableView setDataSource:self];
    Student *s1 = [[Student alloc] initWithFirstName:@"Xander" andLastName:@"Li" grade:12 gender:@"M"];
    Student *s2 = [[Student alloc] initWithFirstName:@"Gid" andLastName:@":)" grade:11 gender:@"M"];
    self.studentsList = [[NSMutableArray alloc] initWithObjects:s1,s2, nil];
    NSLog(@"%lu",[self.studentsList count]);
    [self refreshRotationsPopupMenu];

    [self.rotationDropDownOutlet addItemWithTitle:@"test"];
    [self.rotationDropDownOutlet addItemWithTitle:@"test1"];
    [self.rotationDropDownOutlet addItemWithTitle:@"test2"];
    
    
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
    NSLog(@"numberOfRows-%@",tableView.identifier);
    if([tableView.identifier isEqualToString:@"rotationTableView"]){
#warning TODO
    }
    if([tableView.identifier isEqualToString:@"studentListTableView"]){
        //NSLog(@"numberOfRows:%lu",[self.studentsList count]);
        return [self.studentsList count];
    }
    return 0;
}
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    NSLog(@"%@",tableColumn.identifier);
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
    }
    
    return cellView;
}
- (IBAction)rotationDropDown:(id)sender {
    NSLog(@"%lu",[self.rotationDropDownOutlet indexOfSelectedItem])
    ;
    self.currentDisplayedRotation = [self.allRotations objectAtIndex:[self.rotationDropDownOutlet indexOfSelectedItem]];
}
@end
