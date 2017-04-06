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

- (void)viewDidLoad {
    [super viewDidLoad];
//    DataProc* data = [[DataProc alloc] init];
//    [data readNames:@"names"];
    // Do any additional setup after loading the view.
    
    //testing table toString
    Student *s1 = [[Student alloc]initWithFirstName:@"Sarah" andLastName:@"Du"];
    Student *s2 = [[Student alloc]initWithFirstName:@"Xander" andLastName:@"Li"];
    Student *s3 = [[Student alloc]initWithFirstName:@"Gideon" andLastName:@"Yektai"];
    NSMutableArray *students1 = [NSMutableArray arrayWithObjects:
                                      s1, s2, s3, nil];
    DataProc *proc = [[DataProc alloc] init];
    
    students1 = [proc readNames:@"names"];
    for(int i = 0; i <[students1 count];i++){
        ((Student *)[students1 objectAtIndex:i]).rotationsWaited = arc4random_uniform(5);
    }
    StudentsSorter *sorter = [[StudentsSorter alloc] init];
    NSMutableArray *after = [sorter sortByRotationsWaited:students1];
    //NSLog(@"%@",after);
    RotationGenerator *gen = [[RotationGenerator alloc] init];
    gen.currentRotation = [[Rotation alloc] initWithTables:nil andMeals:5 andTables:5];
    NSLog(@"Waiters: %@",[gen generateWaiters:after]);
    
    
    
//    Table* t1 = [[Table alloc]initWithStudents:pretendStudents first:pretendStudents[0] andSecond:pretendStudents[2] wTable:38];
//    NSLog(@"DES: %@",[t1 description]);
//
//    [t1 initFromString:@"{<Student: 0x6080000868b0>, <Student: 0x608000086950>, <Student: 0x6080000869a0>}; Sarah Du; Gideon Yektai; 38"];
//    
//    
//    NSMutableArray *pretendTables = [NSMutableArray arrayWithObjects:
//                                      t1, nil];
//    Rotation* r1 = [[Rotation alloc]initWithTables:pretendTables andMeals:3 andTables:60];
//    NSLog(@"DES: %@",[r1 description]);
//
//    DataProc* da = [[DataProc alloc] init];
//    [da readNames:@"names"];

}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
