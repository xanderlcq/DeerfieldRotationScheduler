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
    NSMutableArray *pretendStudents = [NSMutableArray arrayWithObjects:
                                      s1, s2, s3, nil];
    Table* t1 = [[Table alloc]initWithStudents:pretendStudents first:pretendStudents[0] andSecond:pretendStudents[2] wTable:38];
    NSLog(@"DES: %@",[t1 description]);
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
