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
    DataProc *proc = [[DataProc alloc] init];
    NSMutableArray *studentList = [proc readNamesToStudents:@"names"];
    Rotation *testRotation = [[Rotation alloc] initEmptyRotation];
    for(int i = 0; i < 68;i++){
        [testRotation addEmptyTable:9];
    }
    
    RotationGenerator *gen = [[RotationGenerator alloc] initWithEmptyRotation:testRotation studentList:studentList andPastHistory:[[NSMutableArray alloc] init]];
    [gen generateRandomRotation];
    NSLog(@"%@",testRotation);
    //NSLog(@"%@",students);
    NSLog(@"%lu",(unsigned long)[students count]);
    RotationGenerator *gen = [[RotationGenerator alloc] initWithNumOfTables:68 numOfMeals:30 studentList:students andPastHistory:[[NSMutableArray alloc] init]];
    [gen lockStudent:[students objectAtIndex:0] atTable:1];
    Rotation *result = [gen generateRandomRotation];
    NSLog(@"%@",result);
    NSLog(@"=====\n\n\n\n");
    gen = [[RotationGenerator alloc] initWithNumOfTables:68 numOfMeals:30 studentList:students andPastHistory:[[NSMutableArray alloc] initWithObjects:result, nil]];
    result = [gen generateRandomRotation];
    NSLog(@"%@",result);
    /*
    //NSLog(@"test generate waiters:");
    NSMutableArray *waiters =[gen generateWaiters];
    NSLog(@"%lu",(unsigned long)[waiters count]);
    //NSLog(@"%@",waiters);
    [gen assignRandomWaiters:waiters];
    //NSLog(@"%@",gen.currentRotation.tables);
    //NSLog(@"%@",waiters);
    students = [gen eliminateDuplicateOf:waiters inList:students];
    gen.students = students;
    NSLog(@"%lu",(unsigned long)[students count]);
    [gen assignRandomStudents];
    NSLog(@"%@",gen.currentRotation.tables);

    */
    //NSLog(@"%@",students);
    NSLog(@"%lu",(unsigned long)[students count]);
    RotationGenerator *gen = [[RotationGenerator alloc] initWithNumOfTables:68 numOfMeals:30 studentList:students andPastHistory:[[NSMutableArray alloc] init]];
    //[gen lockStudent:[students objectAtIndex:0] atTable:1];
    Rotation *result = [gen generateRandomRotation];
    NSLog(@"%@",result);
    NSLog(@"=====\n\n\n\n");
    gen = [[RotationGenerator alloc] initWithNumOfTables:68 numOfMeals:30 studentList:students andPastHistory:[[NSMutableArray alloc] initWithObjects:result, nil]];
    result = [gen generateRandomRotation];
    NSLog(@"%@",result);
    

    /*
    //NSLog(@"test generate waiters:");
    NSMutableArray *waiters =[gen generateWaiters];
    NSLog(@"%lu",(unsigned long)[waiters count]);
    //NSLog(@"%@",waiters);
    [gen assignRandomWaiters:waiters];
    //NSLog(@"%@",gen.currentRotation.tables);
    //NSLog(@"%@",waiters);
    students = [gen eliminateDuplicateOf:waiters inList:students];
    gen.students = students;
    NSLog(@"%lu",(unsigned long)[students count]);
    [gen assignRandomStudents];
    NSLog(@"%@",gen.currentRotation.tables);

    */


>>>>>>> Stashed changes
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
-(void) prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{

}
@end
