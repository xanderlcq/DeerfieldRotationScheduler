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
    Student *s = [[Student alloc] initWithFirstName:@"Xander" andLastName:@"Li" gender:@"M"];
    s.grade = 10;
    
    self.studentsList = [[NSMutableArray alloc] initWithObjects:s, nil];

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
@end
