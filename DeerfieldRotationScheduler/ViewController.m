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
    Student* s1 = [[Student alloc] initWithFirstName:@"Xander" andLastName:@"Li" grade:12 gender:@"M"];
    Student* s2 = [[Student alloc] initWithFirstName:@"Brian" andLastName:@"Weer" grade:9 gender:@"F"];
    Student* s3 = [[Student alloc] initWithFirstName:@"EvErEtt" andLastName:@"Tsai" grade:10 gender:@"M"];
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [array addObject:s1];
    [array addObject:s2];
    [array addObject:s3];
    NSString* finalStr = [self convertStudentListToCSVString:array];
    NSLog(@"%@", finalStr);
}

-(void)writeToFile:(Rotation*)rotation{
    NSString* filepath = @"/Users/gyektai18/Desktop/Rotation.txt";
    NSString* rotStr = [[NSString alloc] init];
    NSMutableArray* tables = rotation.tables;
    for(int i = 0; i < tables.count; i++){
        rotStr = [NSString stringWithFormat:@"%@ \n\n%@", rotStr, [[tables objectAtIndex:i] namePresentably]];
    }
    int three = 0;
    int four = 0;
    int five = 0;
    int six = 0;
    int other = 0;
    for(int i = 0; i < tables.count; i++){
        Table* t = [tables objectAtIndex: i];
        if([t numOfMale] == 3)
            three++;
        else if([t numOfMale] == 4)
            four++;
        else if([t numOfMale] == 5)
            five++;
        else if([t numOfMale] == 6)
            six++;
        else
            other++;
    }
    rotStr = [NSString stringWithFormat:@"3 Male: %i, 4 Male: %i, 5 Male: %i, 6Male: %i, Other: %i \n%@", three, four, five, six, other, rotStr];
    [rotStr writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
-(NSString *) convertStudentListToCSVString:(NSMutableArray *) list{
    NSString* students = [[NSString alloc] init];
    for(int i = 0; i < list.count; i++){
        Student* stud = [list objectAtIndex:i];
        students = [NSString stringWithFormat:@"%@%@,%@,%@,%i\n", students, stud.firstName, stud.lastName, stud.gender, stud.grade];
    }
    return students;
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
