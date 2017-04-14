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
    DataProc* data = [[DataProc alloc] init];
    NSMutableArray *students = [data readNamesToStudents:@"names"];
    for(Student *s in students){
        s.grade = arc4random_uniform(4)+9;
        s.gender = arc4random_uniform(2) == 0?@"F":@"M";
        s.rotationsWaited = arc4random_uniform(2);
    }
    
    //NSLog(@"%@",students);
    NSLog(@"%lu",(unsigned long)[students count]);
    RotationGenerator *gen = [[RotationGenerator alloc] initWithNumOfTables:68 numOfMeals:30 studentList:students andPastHistory:[[NSMutableArray alloc] init]];
    //NSLog(@"test generate waiters:");
    NSMutableArray *waiters =[gen generateWaiters];
    NSLog(@"%lu",(unsigned long)[waiters count]);
    //NSLog(@"%@",waiters);
    [gen assignRandomWaiters:waiters];
    //NSLog(@"%@",gen.currentRotation.tables);
    //NSLog(@"%@",waiters);
    students = [gen eliminateDuplicateOf:waiters inList:students];
    NSLog(@"%lu",(unsigned long)[students count]);
    [gen assignRandomStudents];
    NSLog(@"%@",gen.currentRotation.tables);

    


}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
