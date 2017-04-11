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
    
    Table *t1 = [[Table alloc] init];
    Table *t2 = [[Table alloc] init];
    [t1.students addObject:s1];
    [t1.students addObject:s2];
    [t2.students addObject:s3];
    
    NSMutableArray *tables = [NSMutableArray arrayWithObjects: t1,t2,nil];
    
    Rotation *r1 = [[Rotation alloc]initWithTables:tables andMeals:3 andTables:2];
    NSLog(@"is Sarah sitting with Xander: %hhd",[r1 student:s1 isSittingWith:s2]);
    NSLog(@"is Sarah sitting with Gideon: %hhd",[r1 student:s1 isSittingWith:s3]);
    


}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
